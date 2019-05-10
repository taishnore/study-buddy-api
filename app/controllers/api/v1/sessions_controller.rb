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
    if session_params[:type] == "Increment"
      @session.update(problems: @session.problems += 1)
      @session.reload
      render json: @session.problems
    end
  end

private

  def session_params
    params.require(:session).permit(:id, :type)
  end

end
