class AddImageToProducts < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :image, polymorphic: true, null: true
  end
end
