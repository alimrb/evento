class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  has_many :events, dependent: :delete_all
  has_many :active_subscribes, class_name:  "subscribes",
                                  foreign_key: "event_id",
                                  dependent:   :destroy

  VALID_EMAIL_REGEX =/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  VALID_NAME_REGEX = /\A[A-Za-z][A-Za-z0-9._-]{2,19}\z/
  validates :name, presence: true, 
                            length: { maximum: 50 }, 
                            format: { with: VALID_NAME_REGEX },
                            uniqueness: { case_sensitive: false }
  validates :email, presence: true,
                            format: { with: VALID_EMAIL_REGEX },
                            uniqueness: { case_sensitive: true }
  validates :password, presence: true, 
                                  confirmation: true,
                                  length: { in: 6..16 },
                                  on: :create

  def subscribing?(subscribe)
    active_subscribes.find_by(subscribe)
  end

  def subscribe!(user_id, event_id)
    active_subscribes.create!(user_id: user_id, event_id: event_id)
  end  

  def unsubscribe!(user_id, event_id)
    active_subscribes.find_by(user_id: user_id, event_id: event_id).destroy
  end

end
