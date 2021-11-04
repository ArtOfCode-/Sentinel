class AddFeedbacksCountToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :feedbacks_count, :integer

    reversible do |dir|
      dir.up do
        ActiveRecord::Base.connection.execute <<-SQL.squish
UPDATE posts SET feedbacks_count = (SELECT count(1) FROM feedbacks f WHERE f.post_id = posts.id);
        SQL
      end
    end
  end
end
