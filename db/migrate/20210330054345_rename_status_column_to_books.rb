class RenameStatusColumnToBooks < ActiveRecord::Migration[6.0]
  def change
    rename_column :books, :status, :image_url
  end
end
