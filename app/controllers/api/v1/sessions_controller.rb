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
  end

private

  def game_params
    params.require(:game).permit(:title, :user_id)
  end

end
