require 'rails_helper'

RSpec.describe KpiCalculator, type: :service do
  let!(:survey) { Survey.create!(title: "Employee Survey", description: "Quarterly") }
  let!(:category1) { Category.create!(name: "Communication", survey: survey) }
  let!(:category2) { Category.create!(name: "Teamwork", survey: survey) }
  let!(:user1) { User.create!(email: "user1@example.com", password: "password") }
  let!(:user2) { User.create!(email: "user2@example.com", password: "password") }

  before do
    UserCategoryScore.create!(user: user1, survey: survey, category: category1, total_score: 7, max_score: 10, percentage: 70.0)
    UserCategoryScore.create!(user: user1, survey: survey, category: category2, total_score: 9, max_score: 10, percentage: 90.0)
    UserCategoryScore.create!(user: user2, survey: survey, category: category1, total_score: 3, max_score: 10, percentage: 30.0)
    UserCategoryScore.create!(user: user2, survey: survey, category: category2, total_score: 2, max_score: 10, percentage: 20.0)
  end

  describe '.average_score_per_category' do
    it 'returns average percentage per category' do
      result = described_class.average_score_per_category(survey.id)
      expect(result.length).to eq(2)
      expect(result.map(&:name)).to include("Communication", "Teamwork")
    end
  end

  describe '.employee_engagement_index' do
    it 'returns average score per user' do
      result = described_class.employee_engagement_index(survey.id)
      expect(result.map(&:user_id)).to match_array([user1.id, user2.id])
    end
  end

  def self.performance_brackets(survey_id)
    # Get unique users for this survey
    users = UserCategoryScore.where(survey_id: survey_id).select(:user_id).distinct.pluck(:user_id)
    return {} if users.empty?
    
    brackets = {
      'Poor' => 0,
      'Average' => 0,
      'Good' => 0,
      'Very Proficient' => 0
    }
    
    # For each user, calculate their average score across all categories
    users.each do |user_id|
      avg_score = UserCategoryScore.where(survey_id: survey_id, user_id: user_id).average(:percentage).to_f
      
      # Classify based on average score
      classification = if avg_score < 30
                         'Poor'
                       elsif avg_score < 60
                         'Average'
                       elsif avg_score < 80
                         'Good'
                       else
                         'Very Proficient'
                       end
      
      brackets[classification] += 1
    end
    
    # Convert to percentages
    total_users = users.count
    brackets.transform_values { |count| (count.to_f / total_users * 100).round(1) }
  end

  describe '.category_performance_comparison' do
    it 'returns avg, min, and max percentage per category' do
      result = described_class.category_performance_comparison(survey.id)
      expect(result["Communication"][:avg_score]).to eq(50.0)
      expect(result["Teamwork"][:max_score]).to eq(90.0)
    end
  end

  describe '.dynamic_classification_thresholds' do
    it 'returns dynamic quartile-based thresholds' do
      result = described_class.dynamic_classification_thresholds(survey.id)
      expect(result[:good]).to be_between(30, 70)
    end
  end

  describe '.user_scores_for_survey' do
    it 'returns category scores for a user' do
      result = described_class.user_scores_for_survey(survey.id, user1.id)
      expect(result).to be_an(Array)
      expect(result.first).to have_key(:category)
    end
  end

  describe '.user_engagement_score' do
    it 'returns average percentage score for a user' do
      expect(described_class.user_engagement_score(survey.id, user1.id)).to eq(80.0)
    end
  end

  describe '.user_vs_average_scores' do
    it 'compares user scores to overall averages' do
      result = described_class.user_vs_average_scores(survey.id, user1.id)
      expect(result.first).to have_key(:average_percentage)
    end
  end
end
