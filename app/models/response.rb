# @file app/models/response.rb
# @description Stores a user's response to a survey, including associated answers.
# Handles marking the survey as complete.
# @version 1.0.0
# @author
#   - Athika Jishida
class Response < ApplicationRecord
  belongs_to :user
  belongs_to :survey
  has_many :response_details, dependent: :destroy
  
  def complete!
    update(completed_at: Time.current)
  end
end
