class GamesController < ApplicationController
  def create
    data = GamesFacade.new_game(params, current_user.id)
    redirect_to gameplay_path(data[:data][:id])
  end
end
