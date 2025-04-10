# @file app/models/response_detail.rb
# @description Captures individual question responses from a survey.
# Stores selected answer and score for each question.
# @version 1.0.0
# @author
#   - Athika Jishida
class ResponseDetail < ApplicationRecord
  belongs_to :response
  belongs_to :question
  belongs_to :answer
  
  validates :score, presence: true, numericality: { only_integer: true }
end
