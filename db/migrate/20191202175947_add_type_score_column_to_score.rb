class AddTypeScoreColumnToScore < ActiveRecord::Migration[6.0]
  def change
    add_column :scores, :score_type, :string
  end
end
