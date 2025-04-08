class ResponseDetail < ApplicationRecord
  belongs_to :response
  belongs_to :question
  belongs_to :answer
  
  validates :score, presence: true, numericality: { only_integer: true }
end
