class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, {:id => false} do |t|
      t.string :uuid
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :gender
      t.string :role

      t.timestamps
    end

    execute "ALTER TABLE users ADD PRIMARY KEY (uuid);"
    add_index :users, :uuid, :unique => true
  end
end
