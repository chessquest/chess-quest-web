class Quest
  attr_reader :id, :user_id, :status, :name

  def initialize(data)
    @id = data[:data][:id]
    @user_id = data[:data][:attributes][:user_id]
    @status = data[:data][:attributes][:status]
    @name = data[:data][:attributes][:name]
  end

end