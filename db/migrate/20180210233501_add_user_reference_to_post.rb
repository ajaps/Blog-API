class AddUserReferenceToPost < ActiveRecord::Migration[5.1]
  def change
    # add_reference :blog_posts, :user, index: true
    add_reference :blog_posts, :users, index: true
    # add_foreign_key :blog_posts, :users
  end
end
