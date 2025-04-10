# @file spec/controllers/kpis_controller_spec.rb
# @description Test suite for KpisController, covering both admin-level KPI dashboard
# and user-specific KPI views. Uses mocking to isolate controller behavior from service logic.
# @version 1.0.0
# @requires Devise test helpers and KpiCalculator service mocking for isolation
# @note Ensures JSON response structure and successful HTTP status codes for KPI endpoints.
# @author
#   - Athika Jishida
require 'rails_helper'

RSpec.describe KpisController, type: :controller do
  describe 'GET #dashboard' do
    let(:survey) { Survey.create!(title: "Test Survey", active: true) }

    before do
      # Mocking KpiCalculator service methods to isolate controller logic
      allow(KpiCalculator).to receive(:average_score_per_category).and_return([])
      allow(KpiCalculator).to receive(:employee_engagement_index).and_return(75.5)
      allow(KpiCalculator).to receive(:performance_brackets).and_return({})
      allow(KpiCalculator).to receive(:category_performance_comparison).and_return([])
      allow(KpiCalculator).to receive(:dynamic_classification_thresholds).and_return({})
    end

    # Test: Admin KPI dashboard returns all KPI metrics as JSON with 200 OK
    it 'assigns all KPI values and returns success' do
      get :dashboard, params: { survey_id: survey.id }, format: :json

      expect(response).to have_http_status(:ok)
      # Validate expected JSON keys
      body = JSON.parse(response.body)
      expect(body).to include('avg_scores', 'engagement_index', 'performance_brackets', 'category_comparison', 'dynamic_thresholds')
    end
  end

  describe 'GET #user_dashboard' do
  let(:user) { User.create!(email: "test@example.com", password: "password123") }
  let!(:survey) { Survey.create!(title: "Test Survey", active: true) }

    before do
      sign_in user
      # Mock user-specific KPI calculations
      allow(KpiCalculator).to receive(:user_engagement_score).and_return(88.8)
      allow(KpiCalculator).to receive(:user_scores_for_survey).and_return([])
      allow(KpiCalculator).to receive(:user_vs_average_scores).and_return({})
    end

    # Test: User KPI dashboard returns personalized data with correct structure
    it 'returns user KPI dashboard data as JSON' do
      get :user_dashboard, params: { user_id: user.id, survey_id: survey.id }, format: :json
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body).to include('engagement_score', 'category_scores', 'comparison')
    end
  end
end