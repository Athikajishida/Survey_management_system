require 'rails_helper'

RSpec.describe UserCategoryScore, type: :model do
  let(:user) { User.create!(email: 'user@example.com', password: 'password') }
  let(:survey) { Survey.create!(title: 'Survey 1') }
  let(:category) { Category.create!(name: 'Category 1', survey: survey) }

  context 'validations' do
    it 'is valid with valid scores' do
      score = UserCategoryScore.new(user: user, survey: survey, category: category, total_score: 10, max_score: 20)
      expect(score).to be_valid
    end

    it 'is invalid without total_score' do
      score = UserCategoryScore.new(max_score: 20)
      score.valid?
      expect(score.errors[:total_score]).to include("can't be blank")
    end

    it 'is invalid without max_score' do
      score = UserCategoryScore.new(total_score: 20)
      score.valid?
      expect(score.errors[:max_score]).to include("can't be blank")
    end

    it 'calculates percentage before save' do
      score = UserCategoryScore.new(user: user, survey: survey, category: category, total_score: 10, max_score: 20)
      score.save
      expect(score.percentage).to eq 50.0
    end
  end

  describe '#classification' do
    it 'returns Poor for < 30%' do
      score = UserCategoryScore.new(total_score: 5, max_score: 50)
      score.calculate_percentage
      expect(score.classification).to eq 'Poor'
    end

    it 'returns Average for 30-59%' do
      score = UserCategoryScore.new(total_score: 20, max_score: 50)
      score.calculate_percentage
      expect(score.classification).to eq 'Average'
    end

    it 'returns Good for 60-79%' do
      score = UserCategoryScore.new(total_score: 35, max_score: 50)
      score.calculate_percentage
      expect(score.classification).to eq 'Good'
    end

    it 'returns Very Proficient for 80%+' do
      score = UserCategoryScore.new(total_score: 45, max_score: 50)
      score.calculate_percentage
      expect(score.classification).to eq 'Very Proficient'
    end
  end
end