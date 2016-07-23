class Subscribe < ActiveRecord::Base
	belongs_to :user, class_name: "User"
  	belongs_to :event, class_name: "User"
  	validates :user_id, presence: true
  	validates :event_id, presence: true
end
