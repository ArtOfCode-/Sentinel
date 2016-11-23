class CreateFlags < ActiveRecord::Migration[5.0]
  def change
    create_table :flags do |t|
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true
      t.string :flag_type

      t.timestamps
    end
  end
end
