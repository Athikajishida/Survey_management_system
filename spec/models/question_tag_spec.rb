require 'rails_helper'

RSpec.describe QuestionTag, type: :model do
  let(:tag) { Tag.create!(name: 'Tag') }
  let(:question) { Question.create!(text: 'Q', question_type: 'mcq', position: 1, category: Category.create!(name: 'C', survey: Survey.create!(title: 'S'))) }

  it 'is valid with question and tag' do
    qt = QuestionTag.new(question: question, tag: tag)
    expect(qt).to be_valid
  end
end