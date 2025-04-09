class Admin::DashboardController < Admin::BaseController
  def index
    @surveys = Survey.all.order(created_at: :desc)
    @survey = Survey.find_by(id: params[:survey_id]) || @surveys.first

    if @survey
      @avg_scores = KpiCalculator.average_score_per_category(@survey.id)
      @engagement_index = KpiCalculator.employee_engagement_index(@survey.id)
      @performance_brackets = KpiCalculator.performance_brackets(@survey.id)
      @category_comparison = KpiCalculator.category_performance_comparison(@survey.id)
      @dynamic_thresholds = KpiCalculator.dynamic_classification_thresholds(@survey.id)
    end
  end
end
