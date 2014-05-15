class CreateTeeTime < ActiveRecord::Migration
  def change
    create_table :tee_times do |t|
      t.datetime :tee_time
      t.references :course
      t.decimal :price
      t.integer :players
      t.integer :percent_off
      t.string :booking_link
      t.timestamps
    end
  end
end
