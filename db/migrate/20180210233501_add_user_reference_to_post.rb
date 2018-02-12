class AddUserReferenceToPost < ActiveRecord::Migration[5.1]
  def change
    add_reference :blog_posts, :user, foreign_key: true
  end
end
