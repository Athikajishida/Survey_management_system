class Admin::SurveysController < Admin::BaseController
  before_action :set_survey, only: %i[ show edit update destroy ]

  def index
    @surveys = Survey.all
  end

  def show
  end

  def new
    @survey = Survey.new
  end

  def edit
  end

  def create
    @survey = Survey.new(survey_params)

    if @survey.save
      redirect_to admin_survey_path(@survey), notice: "Survey was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @survey.update(survey_params)
      redirect_to admin_survey_path(@survey), notice: "Survey was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @survey.destroy
    redirect_to admin_surveys_path, notice: "Survey was successfully destroyed."
  end

  private

  def set_survey
    @survey = Survey.find(params[:id])
  end

  def survey_params
    params.require(:survey).permit(:title, :description, :active, :version, :is_template)
  end
end
