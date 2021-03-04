class QuestService

	class << self
		def call_current_quest(user)
			quest_data = conn(user).get('quests') do |req|
				req.params[:status] = 'in_progress'
			end
			parse(quest_data)
		end

		def call_completed_quests(user)
			quest_data = conn(user).get('quests') do |req|
				req.params[:status] = 'completed'
			end
			parse(quest_data)
		end

		def call_current_win_streak(user)
			data = conn(user).get('win_streak')
			return 0 if parse(data)[:data].nil?
			parse(data)[:data][:attributes][:streak]
		end

		private

		def conn(user)
			Faraday.new(url: "https://chess-quest-api.herokuapp.com/api/v1/users/#{user.id}/")
		end

		def parse(response)
			JSON.parse(response.body, symbolize_names: true)
		end
	end
end
