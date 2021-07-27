class AddDescriptionToPictures < ActiveRecord::Migration[6.1]
  def change
    add_column :pictures, :description, :string
  end
end
