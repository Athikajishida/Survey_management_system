class SurveyResponseProcessor
  attr_reader :params, :user, :survey, :response
  
  def initialize(params)
    @params = params
    @user = User.find_by(id: params["user_id"])
    # For simplicity, we'll assume the survey is determined by the first question's category's survey
    first_question = Question.find_by(id: params["question_answer_object"].first["question_id"])
    @survey = first_question&.category&.survey if first_question
  end
  
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
  
  def create_response
    @response = Response.create!(user: user, survey: survey)
  end
  
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