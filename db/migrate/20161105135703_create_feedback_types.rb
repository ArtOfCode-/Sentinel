class CreateFeedbackTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :feedback_types do |t|
      t.string :name
      t.string :short_code
      t.string :character
      t.string :color

      t.timestamps
    end
  end
end
