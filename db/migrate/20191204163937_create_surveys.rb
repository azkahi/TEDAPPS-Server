class CreateSurveys < ActiveRecord::Migration[6.0]
  def change
    create_table :surveys do |t|
      t.string :participant_type
      t.text :favourite_session
      t.text :favourite_speaker
      t.text :favourite_moderator
      t.text :new_cap
      t.text :reason_new_cap
      t.string :satisfaction
      t.text :suggestion
      t.text :next_session_suggestion

      t.timestamps
    end
  end
end
