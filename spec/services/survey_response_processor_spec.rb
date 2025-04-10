require 'rails_helper'
RSpec.describe SurveyResponseProcessor, type: :service do
  let!(:user) { User.create!(email: "test@example.com", password: "password") }
  let!(:survey) { Survey.create!(title: "Test Survey", description: "Test Description") }
  let!(:category) { Category.create!(name: "Test Category", survey: survey) }
  let!(:question) { Question.create!(
    text: "Test Question?", 
    category: category, 
    question_type: "multiple_choice", 
    position: 1
  ) }
  let!(:answer) { Answer.create!(text: "Test Answer", question: question, score: 4) }
  
  let(:valid_params) do
    {
      "user_id" => user.id,
      "question_answer_object" => [
        {
          "question_id" => question.id,
          "answer_id" => answer.id,
          "score" => 4,
          "category_id" => category.id
        }
      ]
    }
  end
  
  describe '#process' do
    context 'when user and survey are valid' do
      it 'creates response and related data' do
        result = described_class.new(valid_params).process
        expect(result[:success]).to eq(true)
        expect(Response.count).to eq(1)
        expect(ResponseDetail.count).to eq(1)
        expect(UserCategoryScore.count).to eq(1)
      end
    end
    
    context 'when user is missing' do
      it 'returns error' do
        invalid_params = valid_params.merge("user_id" => nil)
        result = described_class.new(invalid_params).process
        expect(result[:success]).to eq(false)
        expect(result[:errors]).to include("User not found")
      end
    end
    
    context 'when survey is missing' do
      it 'returns error' do
        allow(Question).to receive(:find_by).and_return(nil)
        result = described_class.new(valid_params).process
        expect(result[:success]).to eq(false)
        expect(result[:errors]).to include("Survey not found")
      end
    end
  end
end