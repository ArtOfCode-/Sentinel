class AddSiteToPosts < ActiveRecord::Migration[5.0]
  def change
    add_reference :posts, :site, foreign_key: true
  end
end
