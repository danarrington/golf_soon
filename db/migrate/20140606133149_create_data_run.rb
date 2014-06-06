class CreateDataRun < ActiveRecord::Migration
  def change
    create_table :data_runs do |t|
      t.timestamps
    end
    add_column :tee_times, :last_data_run_id, :integer
  end
end
