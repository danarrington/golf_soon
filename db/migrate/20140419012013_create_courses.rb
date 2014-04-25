class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :gn_id
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.integer :holes
      t.integer :par
      t.integer :yards
      t.float :rating
      t.integer :slope

      t.timestamps
    end
  end
end
