class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :FirstName
      t.string :LastName
      t.string :email
      t.string :gender
      t.string :role

      t.timestamps
    end
  end
end
