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

private

  def session_params
    params.require(:session).permit(:id, :type, :hours)
  end

end
