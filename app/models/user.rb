class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  has_many :events, dependent: :delete_all
  has_many :subscribes, dependent: :destroy

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

  def subscribed?(event)
    subscribes.find_by(event_id: event.id)
  end

  def subscribe!(user_id, event_id)
    subscribes.create!(user_id: user_id, event_id: event_id)
  end  

  def unsubscribe!(event_id)
    subscribes.find_by(event_id: event_id).destroy
  end

end
