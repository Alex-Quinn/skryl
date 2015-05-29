class CreateClimbingRoutesTable < ActiveRecord::Migration
  def up
    create_table :climbing_routes do |t|
      t.string   :name
      t.string   :grade
      t.string   :location
      t.string   :link
      t.date     :completed_at

      t.timestamps
    end
  end

  def down
  end
end
