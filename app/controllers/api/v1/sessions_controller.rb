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
      @session.days.last.update(problems: @session.days.last.problems += 1)
      @session.reload
      @session.days.reload
      render json: {total: @session.problems, today: @session.days.last.problems}
    elsif session_params[:type] == "add_time"
      @session.update(hours: @session.hours += session_params[:hours])
      @session.days.last.update(time_studied: @session.days.last.time_studied += session_params[:hours])
      @session.reload
      @session.days.reload
      render json: { id: @session.id, hours: @session.hours, time_today: @session.days.last.time_studied }
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

  def create
    @session = Session.create(title: session_params[:title])
    render json: @session
  end



private

  def session_params
    params.require(:session).permit(:id, :type, :hours, :title)
  end

end
