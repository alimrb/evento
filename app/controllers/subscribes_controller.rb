class SubscribesController < ApplicationController
	def new
		@subscribes = Subscribe.new
	end

	def create
		user_id = current_user.id
		event_id = params[:event_id]
		@subscribes = Subscribe.new(user_id: user_id, event_id: event_id)
		@subscribes.save
		redirect_to events_path
	end

	def subscribe_params
		raise params.inspect
    	params.require(:subscribe).permit(:event_id)   
  	end
end