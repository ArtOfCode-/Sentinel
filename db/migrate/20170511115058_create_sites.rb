class CreateSites < ActiveRecord::Migration[5.0]
  def change
    create_table :sites do |t|
      t.string :name
      t.string :url
      t.string :logo
      t.string :domain
      t.boolean :is_child_meta

      t.timestamps
    end
  end
end
