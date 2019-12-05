class ScoresController < ApplicationController
  before_action :set_score, only: [:show, :update, :destroy]

  # GET /scores
  def index
    @scores = Score.all

    render json: @scores
  end

  # GET /scores/1
  def show
    render json: @score
  end

  # POST /scores
  def create
    @score = Score.new(score_params)

    if @score.save
      render json: @score, status: :created, location: @score
    else
      render json: @score.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /scores/1
  def update
    if @score.update(score_params)
      render json: @score
    else
      render json: @score.errors, status: :unprocessable_entity
    end
  end

  # DELETE /scores/1
  def destroy
    @score.destroy
  end

  def start_quiz
    @score = Score.new(score: 0, time: -1, score_type: params[:score_type], username: params[:username], start_time: params[:time_start].to_datetime)

    if @score.save
      render json: @score, status: :created, location: @score
    else
      render json: @score.errors, status: :unprocessable_entity
    end
  end

  def end_quiz
    @score = Score.find_by(username: params[:username], score_type: params[:score_type])

    if not @score.blank?
      time_diff = ((params[:time_end].to_datetime - @score.start_time.to_datetime) * 24 * 60 * 60)

      if @score.update(score: params[:score], time: time_diff)
        render json: @score
      else
        render json: @score.errors, status: :unprocessable_entity
      end
    end
  end

  def show_score
    @scores = Score.where(score_type: params[:score_type]).where('time > 0').order(score: :desc, time: :asc)

    render json: @scores
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_score
      @score = Score.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def score_params
      params.require(:score).permit(:score, :time)
    end
end
