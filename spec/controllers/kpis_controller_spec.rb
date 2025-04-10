require 'rails_helper'

RSpec.describe KpisController, type: :controller do
  describe 'GET #dashboard' do
    let(:survey) { Survey.create!(title: "Test Survey", active: true) }

    before do
      allow(KpiCalculator).to receive(:average_score_per_category).and_return([])
      allow(KpiCalculator).to receive(:employee_engagement_index).and_return(75.5)
      allow(KpiCalculator).to receive(:performance_brackets).and_return({})
      allow(KpiCalculator).to receive(:category_performance_comparison).and_return([])
      allow(KpiCalculator).to receive(:dynamic_classification_thresholds).and_return({})
    end

    it 'assigns all KPI values and returns success' do
      get :dashboard, params: { survey_id: survey.id }, format: :json

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body).to include('avg_scores', 'engagement_index', 'performance_brackets', 'category_comparison', 'dynamic_thresholds')
    end
  end

  describe 'GET #user_dashboard' do
  let(:user) { User.create!(email: "test@example.com", password: "password123") }
  let!(:survey) { Survey.create!(title: "Test Survey", active: true) }

    before do
      sign_in user
      allow(KpiCalculator).to receive(:user_engagement_score).and_return(88.8)
      allow(KpiCalculator).to receive(:user_scores_for_survey).and_return([])
      allow(KpiCalculator).to receive(:user_vs_average_scores).and_return({})
    end

    it 'returns user KPI dashboard data as JSON' do
      # Update to match your routes - include user_id since it's a nested route
      get :user_dashboard, params: { user_id: user.id, survey_id: survey.id }, format: :json

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body).to include('engagement_score', 'category_scores', 'comparison')
    end
  end
end