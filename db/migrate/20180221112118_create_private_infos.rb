class CreatePrivateInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :private_infos do |t|
      t.text :password
      t.string :user_id

      t.timestamps
    end

    add_foreign_key :private_infos, :users, column: :user_id, primary_key: :user_id
  end
end
