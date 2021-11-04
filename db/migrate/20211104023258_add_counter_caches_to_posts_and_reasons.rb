class AddCounterCachesToPostsAndReasons < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :reasons_count, :integer
    add_column :reasons, :posts_count, :integer

    reversible do |dir|
      dir.up do
        ActiveRecord::Base.connection.execute <<-SQL.squish
update reasons r
inner join (
select reason_id, COUNT(post_id) as count
from posts_reasons
group by reason_id) x on x.reason_id = r.id
set r.posts_count = count;
        SQL

        ActiveRecord::Base.connection.execute <<-SQL.squish
update posts p
inner join (
select post_id, COUNT(reason_id) as count
from posts_reasons
group by post_id) x on x.post_id = p.id
set p.reasons_count = count;
        SQL
      end
    end
  end
end
