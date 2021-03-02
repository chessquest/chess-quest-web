class DashboardController < ApplicationController
  def index
    @current_quest = QuestsFacade.get_current_quest(current_user)
    @completed_quests = QuestsFacade.get_completed_quests(current_user)
    @current_game = nil
  end
end
