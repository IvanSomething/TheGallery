class AddStatusToPicture < ActiveRecord::Migration[6.1]
  def change
    add_column :pictures, :status, :string, default: 'pending'
  end
end
