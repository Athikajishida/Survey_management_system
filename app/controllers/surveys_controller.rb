class SurveysController < ApplicationController
  def index
    @surveys = Survey.where(active: true)
  end
  
  def show
    @survey = Survey.find(params[:id])
  end
end