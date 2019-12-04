class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :update, :destroy]

  # GET /surveys
  def index
    @surveys = Survey.all

    render json: @surveys
  end

  # GET /surveys/1
  def show
    render json: @survey
  end

  # POST /surveys
  def create
    @user = User.find(params[:id])
    @survey = @user.build_survey(survey_params)

    if @survey.save
      render json: @survey, status: :created, location: @survey
    else
      render json: @survey.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /surveys/1
  def update
    if @survey.update(survey_params)
      render json: @survey
    else
      render json: @survey.errors, status: :unprocessable_entity
    end
  end

  # DELETE /surveys/1
  def destroy
    @survey.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def survey_params
      params.require(:survey).permit(:participant_type, :favourite_session, :favourite_speaker, :favourite_moderator, :new_cap, :reason_new_cap, :satisfaction, :suggestion, :next_session_suggestion)
    end
end
