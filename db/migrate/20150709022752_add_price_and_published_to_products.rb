class AddPriceAndPublishedToProducts < ActiveRecord::Migration
  def change
    add_column :products, :price, :decimal, precision: 8, scale: 2
    add_column :products, :published, :boolean
  end
end
