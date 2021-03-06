class QuestsFacade
	class << self

		def get_current_quest(user)
			data = QuestService.call_current_quest(user)
			if data.present? && data[:data].present?
				create_quests(data)
			end
		end

		def get_current_game(user)
			data = QuestService.call_current_quest(user)
			if data.present? && data[:data].present? 
				dig_through_it(data)
			end
		end

		def get_won_games(user)
			data = QuestService.call_current_quest(user)
			if data.present? && data[:data].present? 
				find_won_games(data)
			end
		end

		def get_completed_quests(user)
			data = QuestService.call_completed_quests(user)
			if data.present? && data[:data].present?
				create_quests(data)
			end
		end

		def get_current_win_streak(user)
			QuestService.call_current_win_streak(user)
		end

		private

		def create_quests(data)
			data[:data].map do |datum|
				Quest.new(datum)
			end
		end

		def dig_through_it(data)
			return nil if !data[:included]
			game = data[:included].select do |game|
				game[:attributes][:status] == 'in_progress'
			end.first
			return nil if game.nil?
			Game.new(game)
		end

		def find_won_games(data)
			return nil if !data[:included]
			games = data[:included].select do |game|
				game[:attributes][:status] == 'won'
			end
			return nil if games.empty?
			games.map do |game|
				Game.new(game)
			end
		end
	end
end
