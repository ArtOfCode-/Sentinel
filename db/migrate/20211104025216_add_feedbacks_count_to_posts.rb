class AddFeedbacksCountToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :feedbacks_count, :integer

    reversible do |dir|
      dir.up do
        ActiveRecord::Base.connection.execute <<-SQL.squish
update posts p
inner join (
select post_id, COUNT(id) as count
from feedbacks
group by post_id) x on x.post_id = p.id
set p.feedbacks_count = count;
        SQL
      end
    end
  end
end
