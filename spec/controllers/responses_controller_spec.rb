require 'rails_helper'

RSpec.describe ResponsesController, type: :controller do
  describe 'POST #create' do
  let(:valid_params) do
    user = User.create!(email: "test-#{rand(1000)}@example.com", password: "password123")
    survey = Survey.create!(title: "Test Survey", active: true)
    category = Category.create!(name: "Test Category", survey: survey)
    question = Question.create!(
      text: "Test Question",
      category: category,
      question_type: "single_choice",
      position: 1
    )
    answer = Answer.create!(text: "Test Answer", question: question, score: 4)
  
    {
      user_id: user.id,
      question_answer_object: [
        { question_id: question.id, answer_id: answer.id, score: 4, category_id: category.id }
      ]
    }
  end

    it 'returns success for valid response' do
      allow_any_instance_of(SurveyResponseProcessor).to receive(:process).and_return({ success: true })

      post :create, params: valid_params
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['status']).to eq('success')
    end

    it 'returns error for invalid response' do
      allow_any_instance_of(SurveyResponseProcessor).to receive(:process).and_return({ success: false, errors: ['Invalid data'] })

      post :create, params: valid_params
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['status']).to eq('error')
    end
  end
end