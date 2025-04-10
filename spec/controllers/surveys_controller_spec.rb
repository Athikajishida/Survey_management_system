require 'rails_helper'


RSpec.describe SurveysController, type: :controller do
  describe 'GET #index' do
    it 'assigns @surveys with only active surveys' do
      active_survey = Survey.create!(title: "Active", active: true)
      inactive_survey = Survey.create!(title: "Inactive", active: false)

      get :index

      expect(assigns(:surveys)).to include(active_survey)
      expect(assigns(:surveys)).not_to include(inactive_survey)
    end
  end

  describe 'GET #show' do
    let(:survey) { Survey.create!(title: "Test Survey", active: true) }

    context 'when user is signed in' do
      let(:user) { User.create!(email: "test@example.com", password: "password123") }

      before do
        sign_in user
      end

      it 'assigns @survey and @already_participated' do
        Response.create!(user: user, survey: survey)
        get :show, params: { id: survey.id }

        expect(assigns(:survey)).to eq(survey)
        expect(assigns(:already_participated)).to be true
      end
    end

    context 'when user is not signed in' do
      it 'assigns @survey' do
        get :show, params: { id: survey.id }

        expect(assigns(:survey)).to eq(survey)
        expect(assigns(:already_participated)).to be_nil
      end
    end
  end
end
