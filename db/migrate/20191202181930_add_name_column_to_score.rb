class AddNameColumnToScore < ActiveRecord::Migration[6.0]
  def change
    add_column :scores, :username, :string
  end
end
