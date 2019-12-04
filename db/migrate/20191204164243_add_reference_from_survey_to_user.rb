class AddReferenceFromSurveyToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :surveys, :user
  end
end
