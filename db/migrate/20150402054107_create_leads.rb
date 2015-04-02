class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.text :phone_number, null: false
      t.boolean :lead_sent, default: false
      t.timestamps null: false
    end
    add_index :leads, :name
    add_index :leads, :email
    add_index :leads, :lead_sent
  end
end
