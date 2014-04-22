class AddWorkflowStateToQuit < ActiveRecord::Migration
  def change
    add_column :quits, :workflow_state, :string
  end
end
