class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :type
      t.text :content
      t.date :date

      t.timestamps
    end
  end
end
