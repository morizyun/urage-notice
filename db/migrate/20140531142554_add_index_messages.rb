class AddIndexMessages < ActiveRecord::Migration
  def change
    add_index :notices, [:notice_id, :locale], unique: true
    change_column :notices, :locale, :string, null: false
  end
end
