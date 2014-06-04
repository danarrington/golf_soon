class AddIconsToTeeTime < ActiveRecord::Migration
  def change
    add_column :tee_times, :cart, :boolean
    add_column :tee_times, :holes, :integer
  end
end
