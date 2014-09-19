class Message < ActiveRecord::Base
	attr_accessible :body, :topic_id, :user_id
	belongs_to :user
	belongs_to :topic
end
