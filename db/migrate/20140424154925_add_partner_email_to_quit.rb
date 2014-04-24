class AddPartnerEmailToQuit < ActiveRecord::Migration
  def change
    add_column :quits, :partner_email, :string
  end
end
