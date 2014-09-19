class Message < ActiveRecord::Base
	attr_accessor :body, :topic_id,  :user_id

	belongs_to :user
	belongs_to :topic
end
