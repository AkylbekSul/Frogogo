class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy

  def calculate_total
    self.total_amount = cart_items.includes(:product).sum('quantity * products.price')
    save
  end

  def total_items
    cart_items.sum(:quantity)
  end
end
