class ResponsesController < ApplicationController
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
  
  def response_params
    params.permit(:user_id, question_answer_object: [:question_id, :answer_id, :score, :category_id])
  end
end