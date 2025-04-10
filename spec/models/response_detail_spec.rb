require 'rails_helper'

RSpec.describe ResponseDetail, type: :model do
  let(:survey) { Survey.create!(title: 'Survey') }
  let(:user) { User.create!(email: 'user@example.com', password: 'password') }
  let(:response) { Response.create!(user: user, survey: survey) }
  let(:category) { Category.create!(name: 'Category', survey: survey) }
  let(:question) { Question.create!(text: 'Question?', question_type: 'mcq', position: 1, category: category) }
  let(:answer) { Answer.create!(text: 'Answer', score: 3, question: question) }

  it 'is valid with score' do
    detail = ResponseDetail.new(response: response, question: question, answer: answer, score: 3)
    expect(detail).to be_valid
  end

  it 'is invalid without score' do
    detail = ResponseDetail.new(response: response, question: question, answer: answer, score: nil)
    detail.valid?
    expect(detail.errors[:score]).to include("can't be blank")
  end
end
