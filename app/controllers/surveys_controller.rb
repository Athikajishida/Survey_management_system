class SurveysController < ApplicationController
  def index
    @surveys = Survey.where(active: true)
  end
  
  def show
    @survey = Survey.find(params[:id])
    if user_signed_in?
      @already_participated = Response.exists?(user_id: current_user.id, survey_id: @survey.id)
    end
  end
end