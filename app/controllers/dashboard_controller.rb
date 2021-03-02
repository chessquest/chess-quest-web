class DashboardController < ApplicationController
  def index
    require 'pry'; binding.pry
    @current_quest = QuestsFacade.get_current_quest(current_user)
    @completed_quests = QuestsFacade.get_completed_quests(current_user)
    @current_game = nil
    @current_win_treak = QuestsFacade.get_current_win_streak(current_user)
    top_3_win_treak = nil
  end
end