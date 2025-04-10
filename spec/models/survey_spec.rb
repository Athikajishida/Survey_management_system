require 'rails_helper'

RSpec.describe Survey, type: :model do
  it 'is valid with a title' do
    survey = Survey.new(title: 'Survey 1')
    expect(survey).to be_valid
  end

  it 'is invalid without a title' do
    survey = Survey.new(title: nil)
    survey.valid?
    expect(survey.errors[:title]).to include("can't be blank")
  end
end