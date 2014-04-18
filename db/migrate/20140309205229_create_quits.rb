class CreateQuits < ActiveRecord::Migration
  def change
    create_table :quits do |t|
      t.integer :user_id
      t.integer :length
      t.date :start_date
      t.string :substance
      t.float :investment

      t.timestamps
    end
  end
end
