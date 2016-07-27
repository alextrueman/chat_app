class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :user_id
      t.integer :chat_id
      t.integer :last_readed

      t.timestamps null: false
    end
  end
end
