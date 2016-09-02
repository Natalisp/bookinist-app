class AddHavereadColumn < ActiveRecord::Migration
  def change
    add_column :books, :have_read, :boolean
  end
end
