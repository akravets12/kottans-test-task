class AddFieldsToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :destruction_delay, :integer
    add_column :messages, :password, :string
    add_column :messages, :destruction_visits, :integer
  end
end
