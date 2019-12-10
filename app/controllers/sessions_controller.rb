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

  def get_session_detail
    @user = User.all

    top_sessions = []

    @user.each { |user|
      @sessions = user.sessions

      attended_flags = [0,0,0,0,0,0,0,0,0,0,0]

      @sessions.each do |session|
        if session.key.to_i >= 0 and session.key.to_i <= 10
          attended_flags[session.key.to_i] = 1
        end
      end

      top_session = { :name => user.name, :phone => user.phone, :email => user.email, :user_type => user.user_type, :class_0 => attended_flags[0], :class_1 => attended_flags[1], :class_2 => attended_flags[2], :class_3 => attended_flags[3], :class_4 => attended_flags[4], :class_5 => attended_flags[5], :class_6 => attended_flags[6], :class_7 => attended_flags[7], :class_8 => attended_flags[8], :class_9 => attended_flags[9], :class_10 => attended_flags[10], }

      top_sessions << top_session
    }

    attributes = %w{name phone email user_type class_0 class_1 class_2 class_3 class_4 class_5 class_6 class_7 class_8 class_9 class_10}

    top_sessions_csv = CSV.generate(headers: true) do |csv|
      csv << attributes

      top_sessions.each do |top_session|
        csv << [ top_session[:name], top_session[:phone], top_session[:email], top_session[:user_type], top_session[:class_0], top_session[:class_1], top_session[:class_2], top_session[:class_3], top_session[:class_4], top_session[:class_5], top_session[:class_6], top_session[:class_7], top_session[:class_8], top_session[:class_9], top_session[:class_10] ]
      end
    end

    render plain: top_sessions_csv.to_s
  end

  def normalize_value
    @users = User.all

    @users.each do |user|
      @sessions = user.sessions

      @sessions.each do |session|
        puts session.key.to_i
        if session.key.to_i > 5
          session.destroy
        end
      end
    end
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
