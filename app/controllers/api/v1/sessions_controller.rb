class Api::V1::SessionsController < ApplicationController

  def index
    @sessions = Session.all
    render json: @sessions
  end

  def show
    @session = Session.find(params[:id])
    render json: @session
  end

  def update
    @session = Session.find(params[:id])
    if session_params[:type] == "increment_problems"
      @session.update(problems: @session.problems += 1)
      @session.reload
      render json: @session.problems
    elsif session_params[:type] == "add_time"
      @session.update(hours: @session.hours += session_params[:hours])
      @session.reload
      render json: @session.hours
    end
  end

  def days
    @today = Date.today
    @session = Session.find(session_params[:id])
    if !@session.days.find{|day| day.date === @today}
      Day.create(session_id: session_params[:id], date: Date.today)
    end
    @session.days.reload
    @days = @session.days
    render json: @days
  end




private

  def session_params
    params.require(:session).permit(:id, :type, :hours)
  end

end
