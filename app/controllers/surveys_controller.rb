# @file app/controllers/surveys_controller.rb
# @description Controller to manage survey listing and individual survey display.
# Provides access to active surveys and checks if the user has already participated.
# @version 1.0.0
# @author
#   - Athika Jishida
class SurveysController < ApplicationController
  # GET /surveys
  #
  # Fetches all active surveys for listing.
  def index
    @surveys = Survey.where(active: true)
  end
  
  # GET /surveys/:id
  #
  # Displays the selected survey.
  # If a user is signed in, checks whether the user has already submitted a response to prevent duplicates.
  def show
    @survey = Survey.find(params[:id])
    if user_signed_in?
      @already_participated = Response.exists?(user_id: current_user.id, survey_id: @survey.id)
    end
  end
end