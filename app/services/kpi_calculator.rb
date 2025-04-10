# @file app/services/kpi_calculator.rb
# @description Service class to compute dynamic Key Performance Indicators (KPIs) based on survey responses.
# Supports analysis such as average scores, engagement index, performance brackets, and personalized benchmarks.
# @version 1.0.0
# @author
#   - Athika Jishida

class KpiCalculator
  # Calculates the average score (percentage) for each category in a given survey.
  # @param survey_id [Integer] the ID of the survey.
  # @return [ActiveRecord::Relation] list of category IDs, names, and their average scores.
  def self.average_score_per_category(survey_id)
    UserCategoryScore.joins(:category)
                     .where(survey_id: survey_id)
                     .group('categories.id', 'categories.name')
                     .select('categories.id, categories.name, AVG(percentage) as avg_score')
                     .order('categories.name')
  end
  
  # Computes the engagement index for each user by averaging their category scores.
  # @param survey_id [Integer]
  # @return [ActiveRecord::Relation] list of users and their average engagement scores.
  def self.employee_engagement_index(survey_id)
    UserCategoryScore.where(survey_id: survey_id)
                     .group(:user_id)
                     .select('user_id, AVG(percentage) as engagement_score')
                     .order(engagement_score: :desc)
  end
 
  # Calculates the percentage of users falling into each performance classification.
  # Classifications: Poor, Average, Good, Very Proficient.
  # @param survey_id [Integer]
  # @return [Hash] classification names as keys with percentage values.
  def self.performance_brackets(survey_id)
    total_users = UserCategoryScore.where(survey_id: survey_id).select(:user_id).distinct.count
    return {} if total_users.zero?
    
    brackets = {
      'Poor' => 0,
      'Average' => 0,
      'Good' => 0,
      'Very Proficient' => 0
    }
    
    UserCategoryScore.where(survey_id: survey_id).find_each do |score|
      brackets[score.classification] += 1
    end
    
    # Convert to percentages
    brackets.transform_values { |count| (count.to_f / total_users * 100).round(2) }
  end
  # Compares average, min, and max category performance for the given survey.
  # @param survey_id [Integer]
  # @return [Hash] category names as keys with performance data.
  def self.category_performance_comparison(survey_id)
    categories = Category.where(survey_id: survey_id)
    
    result = {}
    categories.each do |category|
      scores = UserCategoryScore.where(category: category)
      
      result[category.name] = {
        avg_score: scores.average(:percentage)&.round(2) || 0,
        min_score: scores.minimum(:percentage) || 0,
        max_score: scores.maximum(:percentage) || 0
      }
    end
    
    result
  end
  
  # Generates dynamic classification thresholds based on quartiles of all user scores.
  # Useful for evolving datasets.
  # @param survey_id [Integer]
  # @return [Hash] threshold cutoffs for each classification.
  def self.dynamic_classification_thresholds(survey_id)
    scores = UserCategoryScore.where(survey_id: survey_id).pluck(:percentage).compact
    return { poor: 0, average: 30, good: 60, very_proficient: 80 } if scores.empty?
    
    sorted_scores = scores.sort
    quartile_1 = sorted_scores[sorted_scores.length * 0.25]
    median = sorted_scores[sorted_scores.length * 0.5]
    quartile_3 = sorted_scores[sorted_scores.length * 0.75]
    
    {
      poor: 0,
      average: quartile_1.round(2),
      good: median.round(2),
      very_proficient: quartile_3.round(2)
    }
  end


  # Fetches individual user’s category-wise scores and classifications for a survey.
  # @param survey_id [Integer]
  # @param user_id [Integer]
  # @return [Array<Hash>] details per category (score, percentage, classification).
  def self.user_scores_for_survey(survey_id, user_id)
    scores = UserCategoryScore.includes(:category)
                              .where(survey_id: survey_id, user_id: user_id)

    scores.map do |score|
      {
        category: score.category.name,
        total_score: score.total_score,
        max_score: score.max_score,
        percentage: score.percentage.round(2),
        classification: score.classification
      }
    end
  end

  # Calculates a user’s overall engagement score (average of all category percentages).
  # @param survey_id [Integer]
  # @param user_id [Integer]
  # @return [Float] engagement percentage.
  def self.user_engagement_score(survey_id, user_id)
    scores = UserCategoryScore.where(survey_id: survey_id, user_id: user_id)
    return 0 if scores.empty?

    scores.average(:percentage).round(2)
  end


  # Compares a user’s category performance with the average across all users.
  # @param survey_id [Integer]
  # @param user_id [Integer]
  # @return [Array<Hash>] category-wise comparison between user and average.
  def self.user_vs_average_scores(survey_id, user_id)
    user_scores = user_scores_for_survey(survey_id, user_id)
    overall_scores = average_score_per_category(survey_id)

    comparison = user_scores.map do |user_score|
      avg_score = overall_scores.find { |s| s.name == user_score[:category] }

      {
        category: user_score[:category],
        user_percentage: user_score[:percentage],
        average_percentage: avg_score&.avg_score&.round(2) || 0.0,
        classification: user_score[:classification]
      }
    end

    comparison
  end
end