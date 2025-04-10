# @file app/services/survey_response_processor.rb
# @description Handles the creation and processing of a user's survey response. 
# Includes response recording, answer validation, and category-level scoring with classification.
# @version 1.0.0
# @author
#   - Athika Jishida
class SurveyResponseProcessor
  attr_reader :params, :user, :survey, :response

  # Initializes the processor with form data.
  # Extracts user and determines survey via the first question's category.
  def initialize(params)
    @params = params
    @user = User.find_by(id: params["user_id"])
    # For simplicity, we'll assume the survey is determined by the first question's category's survey
    first_question = Question.find_by(id: params["question_answer_object"].first["question_id"])
    @survey = first_question&.category&.survey if first_question
  end
  
  # Processes the full response within a database transaction.
  # Steps:
  # 1. Validate user & survey
  # 2. Create a Response record
  # 3. Store each question's answer
  # 4. Calculate category scores
  # 5. Mark response complete
  # @return [Hash] success or error message
  def process
    return { success: false, errors: ["User not found"] } unless user
    return { success: false, errors: ["Survey not found"] } unless survey
    
    ActiveRecord::Base.transaction do
      create_response
      process_answers
      calculate_category_scores
      @response.complete!
      { success: true, response: @response }
    rescue => e
      { success: false, errors: [e.message] }
    end
  end
  
  private

  # Creates the main response record.
  def create_response
    @response = Response.create!(user: user, survey: survey)
  end

  # Loops through each submitted answer and stores the score.
  def process_answers
    params["question_answer_object"].each do |answer_data|
      question = Question.find(answer_data["question_id"])
      answer = Answer.find(answer_data["answer_id"])
      score = answer_data["score"].to_i
      
      ResponseDetail.create!(
        response: @response,
        question: question,
        answer: answer,
        score: score
      )
    end
  end

  # Aggregates scores per category and stores them in `user_category_scores`.
  def calculate_category_scores
    # Group questions by category
    category_questions = {}
    
    params["question_answer_object"].each do |answer_data|
      category_id = answer_data["category_id"]
      category_questions[category_id] ||= []
      category_questions[category_id] << answer_data
    end
    
    # Calculate scores for each category
    category_questions.each do |category_id, questions|
      category = Category.find(category_id)
      
      total_score = questions.sum { |q| q["score"].to_i }
      max_score = questions.length * 5 # Assuming max score of 5 per question
      
      UserCategoryScore.create!(
        user: user,
        survey: survey,
        category: category,
        total_score: total_score,
        max_score: max_score
      )
    end
  end
end