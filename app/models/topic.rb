class Topic < ActiveRecord::Base

	belongs_to :user
	has_many :messages
	geocoded_by :address
	after_validation :geocode

end
