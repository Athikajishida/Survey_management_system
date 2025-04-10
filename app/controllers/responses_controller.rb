# @file app/controllers/responses_controller.rb
# @description Handles incoming survey response data from users.
# Delegates to the SurveyResponseProcessor service for transactional response creation.
# @version 1.0.0
# @author
#   - Athika Jishida
class ResponsesController < ApplicationController
  # POST /responses
  #
  # Creates a new survey response for a user.
  # Utilizes the SurveyResponseProcessor to ensure data integrity.
  # Returns success or error as JSON.
  def create
    processor = SurveyResponseProcessor.new(response_params)
    result = processor.process
    
    if result[:success]
      render json: { status: 'success', message: 'Response recorded successfully' }, status: :created
    else
      render json: { status: 'error', errors: result[:errors] }, status: :unprocessable_entity
    end
  end
  
  private

  # Strong parameter method to permit nested question/answer structure.
  def response_params
    params.permit(:user_id, question_answer_object: [:question_id, :answer_id, :score, :category_id])
  end
end