class KpiCalculator
  def self.average_score_per_category(survey_id)
    UserCategoryScore.joins(:category)
                     .where(survey_id: survey_id)
                     .group('categories.id', 'categories.name')
                     .select('categories.id, categories.name, AVG(percentage) as avg_score')
                     .order('categories.name')
  end
  
  def self.employee_engagement_index(survey_id)
    UserCategoryScore.where(survey_id: survey_id)
                     .group(:user_id)
                     .select('user_id, AVG(percentage) as engagement_score')
                     .order(engagement_score: :desc)
  end
  
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
end