class DashboardController < ApplicationController
  def index
    @current_quest = QuestsFacade.get_current_quest(current_user)
    @completed_quests = QuestsFacade.get_completed_quests(current_user)
    @current_game = QuestsFacade.get_current_game(current_user)
    @current_win_streak = QuestsFacade.get_current_win_streak(current_user)
    @top_3_win_streak = GamesFacade.get_top_3_quest_streak
  end
end