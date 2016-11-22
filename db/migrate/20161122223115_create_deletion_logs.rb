class CreateDeletionLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :deletion_logs do |t|
      t.references :post, foreign_key: true
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
