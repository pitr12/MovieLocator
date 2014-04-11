class CreateLocalizations < ActiveRecord::Migration
  def change
    create_table :localizations do |t|
      t.integer :movie_id
      t.integer :location_id

      t.timestamps
    end
  end
end
