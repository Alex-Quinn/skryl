class AlterActivitiesForStrava < ActiveRecord::Migration
  def up
    remove_column :activities, :gps
    remove_column :activities, :latitude
    remove_column :activities, :longitude
    remove_column :activities, :heartrate
    remove_column :activities, :device_type
    remove_column :activities, :calories
    remove_column :activities, :hr_data
    add_column :activities, :commute, :boolean
    add_column :activities, :trainer, :boolean
    add_column :activities, :name, :string
  end

  def down
  end
end
