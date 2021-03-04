class Quest
  attr_reader :id, :user_id, :status, :name

  def initialize(data)
    @id = data[:id]
    @user_id = data[:attributes][:user_id]
    @status = data[:attributes][:status]
    @name = "Quest for the #{Faker::Games::ElderScrolls.jewelry} or something"
  end
end
