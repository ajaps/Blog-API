class ChangeUserIdToString < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :id # remove existing primary key
    execute "ALTER TABLE users ADD PRIMARY KEY (user_id);"

    add_index :users, :user_id, unique: true
  end
end
