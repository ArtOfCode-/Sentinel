class AddCounterCachesToPostsAndReasons < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :reasons_count, :integer
    add_column :reasons, :posts_count, :integer

    reversible do |dir|
      dir.up do
        ActiveRecord::Base.connection.execute <<-SQL.squish
UPDATE posts SET reasons_count = (SELECT count(1) FROM reasons r INNER JOIN posts_reasons pr on pr.reason_id = r.id WHERE pr.post_id = posts.id);
        SQL

        ActiveRecord::Base.connection.execute <<-SQL.squish
UPDATE reasons SET posts_count = (select COUNT(1) FROM posts p INNER JOIN posts_reasons pr on pr.post_id = p.id WHERE pr.reason_id = reasons.id);
        SQL
      end
    end
  end
end
