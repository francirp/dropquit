class RemoveCheckpointId < ActiveRecord::Migration
  def change
    remove_column :posts, :checkpoint_id
  end
end
