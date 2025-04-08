class KpisController < ApplicationController
  def dashboard
    @survey = Survey.find(params[:survey_id])
    @avg_scores = KpiCalculator.average_score_per_category(@survey.id)
    @engagement_index = KpiCalculator.employee_engagement_index(@survey.id)
    @performance_brackets = KpiCalculator.performance_brackets(@survey.id)
    @category_comparison = KpiCalculator.category_performance_comparison(@survey.id)
    @dynamic_thresholds = KpiCalculator.dynamic_classification_thresholds(@survey.id)
    
    respond_to do |format|
      format.html
      format.json { render json: { 
        avg_scores: @avg_scores,
        engagement_index: @engagement_index,
        performance_brackets: @performance_brackets,
        category_comparison: @category_comparison,
        dynamic_thresholds: @dynamic_thresholds
      } }
    end
  end
end