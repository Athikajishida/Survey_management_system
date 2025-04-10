require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:survey) { Survey.create!(title: 'Survey') }
  let(:category) { Category.create!(name: 'Category', survey: survey) }

  it 'is valid with text, type, and position' do
    question = Question.new(text: 'Text', question_type: 'mcq', position: 1, category: category)
    expect(question).to be_valid
  end

  it 'is invalid without text' do
    question = Question.new(text: nil)
    question.valid?
    expect(question.errors[:text]).to include("can't be blank")
  end
end