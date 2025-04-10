require 'rails_helper'

RSpec.describe Response, type: :model do
  let(:user) { User.create!(email: 'user@example.com', password: 'password') }
  let(:survey) { Survey.create!(title: 'Survey 1') }
  let(:response) { Response.create!(user: user, survey: survey) }

  it 'belongs to user' do
    expect(response.user).to eq(user)
  end

  it 'belongs to survey' do
    expect(response.survey).to eq(survey)
  end

  it '#complete! sets completed_at' do
    response.complete!
    expect(response.completed_at).to_not be_nil
  end
end