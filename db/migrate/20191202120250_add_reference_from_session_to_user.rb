class AddReferenceFromSessionToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :sessions, :user
  end
end
