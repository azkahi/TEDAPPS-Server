class AddStartTimeToScore < ActiveRecord::Migration[6.0]
  def change
    add_column :scores, :start_time, :datetime
  end
end
