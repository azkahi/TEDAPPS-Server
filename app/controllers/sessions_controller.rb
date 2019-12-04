require "csv"

class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :update, :destroy]

  # GET /sessions
  def index
    @sessions = Session.all

    render json: @sessions
  end

  # GET /sessions/1
  def show
    render json: @session
  end

  # POST /sessions
  def create
    @session = Session.new(session_params)

    if @session.save
      render json: @session, status: :created, location: @session
    else
      render json: @session.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sessions/1
  def update
    if @session.update(session_params)
      render json: @session
    else
      render json: @session.errors, status: :unprocessable_entity
    end
  end

  def get_top
    @user = User.all

    top_sessions = []

    @user.each { |user|
      @sessions = user.sessions

      list_unique_class = []

      @sessions.each do |session|
        if !(list_unique_class.include? session.key)
          list_unique_class << session.key
        end
      end

      top_session = { :name => user.name, :phone => user.phone, :email => user.email, :user_type => user.user_type, :class_attended => list_unique_class.length }

      top_sessions << top_session
    }

    top_sessions.sort_by{|e| -e[:class_attended]}

    attributes = %w{name phone email user_type class_attended}

    top_sessions_csv = CSV.generate(headers: true) do |csv|
      csv << attributes

      top_sessions.each do |top_session|
        csv << [ top_session[:name], top_session[:phone], top_session[:email], top_session[:user_type], top_session[:class_attended] ]
      end
    end



    render plain: top_sessions_csv.to_s
  end

  # DELETE /sessions/1
  def destroy
    @session.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @session = Session.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def session_params
      params.require(:session).permit(:key)
    end
end
