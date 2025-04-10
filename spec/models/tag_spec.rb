require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'is valid with a name' do
    tag = Tag.new(name: 'Skill')
    expect(tag).to be_valid
  end

  it 'is invalid without a name' do
    tag = Tag.new(name: nil)
    tag.valid?
    expect(tag.errors[:name]).to include("can't be blank")
  end

  it 'is invalid with duplicate name' do
    Tag.create!(name: 'Skill')
    tag = Tag.new(name: 'Skill')
    tag.valid?
    expect(tag.errors[:name]).to include("has already been taken")
  end
end
