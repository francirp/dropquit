class RemoveColumnsFromCheckpoints < ActiveRecord::Migration
  def change
    remove_column :checkpoints, :date
  end
end
