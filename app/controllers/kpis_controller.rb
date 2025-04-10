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

  def user_dashboard
    @user = current_user
    @surveys = Survey.all
    @selected_survey = Survey.find_by(id: params[:survey_id]) || @surveys.first
  
    if @selected_survey
      @engagement_score = KpiCalculator.user_engagement_score(@selected_survey.id, @user.id)
      @user_scores = KpiCalculator.user_scores_for_survey(@selected_survey.id, @user.id)
      @user_comparison = KpiCalculator.user_vs_average_scores(@selected_survey.id, @user.id)
    else
      @engagement_score = @user_scores = @user_comparison = []
    end
  
    respond_to do |format|
      format.html
      format.json {
        render json: {
          engagement_score: @engagement_score,
          category_scores: @user_scores,
          comparison: @user_comparison
        }
      }
    end
  end
end