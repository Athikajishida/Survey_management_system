class Response < ApplicationRecord
  belongs_to :user
  belongs_to :survey
  has_many :response_details, dependent: :destroy
  
  def complete!
    update(completed_at: Time.current)
  end
end
