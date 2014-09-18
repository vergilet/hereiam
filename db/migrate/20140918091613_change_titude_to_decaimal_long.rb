class ChangeTitudeToDecaimalLong < ActiveRecord::Migration
  def change
  	  	change_column :topics, :longitude, :decimal, precision: 20, scale: 15
  end
end
