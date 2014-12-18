class ChangeTitudeToDecaimal < ActiveRecord::Migration
  def change
  	change_column :topics, :latitude, :decimal, precision: 20, scale: 15
  	change_column :topics, :longitude, :decimal, precision: 20, scale: 15
  end
end
