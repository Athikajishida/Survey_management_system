require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:question) { Question.create!(text: 'Q', question_type: 'mcq', position: 1, category: Category.create!(name: 'C', survey: Survey.create!(title: 'S'))) }

  it 'is valid with text and score between 1 and 5' do
    answer = Answer.new(text: 'Answer', score: 3, question: question)
    expect(answer).to be_valid
  end

  it 'is invalid with score < 1' do
    answer = Answer.new(text: 'Answer', score: 0, question: question)
    answer.valid?
    expect(answer.errors[:score]).to include("must be greater than or equal to 1")
  end

  it 'is invalid with score > 5' do
    answer = Answer.new(text: 'Answer', score: 6, question: question)
    answer.valid?
    expect(answer.errors[:score]).to include("must be less than or equal to 5")
  end
end