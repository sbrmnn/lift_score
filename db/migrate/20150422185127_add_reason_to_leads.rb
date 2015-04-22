class AddReasonToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :reason, :string
  end
end
