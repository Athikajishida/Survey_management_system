# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'is valid with a unique email' do
      user = User.new(email: 'test@example.com', password: 'password123')
      expect(user).to be_valid
    end

    it 'is invalid without an email' do
      user = User.new(email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'is invalid with a duplicate email' do
      User.create!(email: 'test@example.com', password: 'password123')
      user = User.new(email: 'test@example.com')
      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end
  end

  context 'associations' do
    it 'has many responses' do
      assoc = User.reflect_on_association(:responses)
      expect(assoc.macro).to eq :has_many
    end

    it 'has many user_category_scores' do
      assoc = User.reflect_on_association(:user_category_scores)
      expect(assoc.macro).to eq :has_many
    end
  end
end