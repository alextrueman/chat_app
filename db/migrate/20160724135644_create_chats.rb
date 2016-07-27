class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.string :name
      t.string :users_id, array: true, default: '{}'

      t.timestamps null: false
    end
  end
end
