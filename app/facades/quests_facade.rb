class QuestsFacade
	class << self

		def get_current_quest(user)
			data = QuestService.call_current_quest(user)
			if data.present? && data[:data].present?
				create_quests(data)
			end
		end

		def get_completed_quests(user)
			data = QuestService.call_completed_quests(user)
			if data.present? && data[:data].present?
				create_quests(data)
			end
		end


		private

		def create_quests(data)
			data[:data].map do |datum|
				Quest.new(datum)
			end
		end

	end
end