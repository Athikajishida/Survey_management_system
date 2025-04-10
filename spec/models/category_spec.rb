require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:survey) { Survey.create!(title: 'Survey') }

  it 'is valid with a name' do
    category = Category.new(name: 'Category', survey: survey)
    expect(category).to be_valid
  end

  it 'is invalid without a name' do
    category = Category.new(name: nil)
    category.valid?
    expect(category.errors[:name]).to include("can't be blank")
  end
end
