class AddImageUrlToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :status, :string
  end
end