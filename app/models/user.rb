class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_google(email:, uid:)
    create_with(uid: uid).find_or_create_by!(email: email) 
  end

  # def quests
  # end
end
