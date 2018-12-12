class CartController < ApplicationController

  before_action :authenticate_user!, except: [:add_to_cart, :view_order]

  def add_to_cart
    line_item = LineItem.create(product_id: params[:product_id], quantity: params[:quantity])

    line_item.update(line_item_total: (line_item.quantity * line_item.product.price))

    redirect_back(fallback_location: root_path)
  end

  def view_order
    @line_items = LineItem.all
  end

  def checkout
	# * Collect all the Line Items
	# * We created a new Order
	# 	* Fed it the current_user ID & set subtotal to 0
	# * Deduct the quantity ordered from the Product's inventory
	# * Build our order_items Hash which will have
	# * Calculate the Order subtotal
	# * Save the Order!
	# * Then calculate sales tax and grand_total (+ saving, using .update()
	# * Delete the Line Items currently in the table (so that they won't appear if you return)

    line_items = LineItem.all
    @order = Order.create(user_id: current_user.id, subtotal: 0)

    line_items.each do |line_item|
      line_item.product.update(quantity: (line_item.product.quantity - line_item.quantity))
      @order.order_items[line_item.product_id] = line_item.quantity
      @order.subtotal += line_item.line_item_total
    end
    @order.save

    @order.update(sales_tax: (@order.subtotal * 0.08))
    @order.update(grand_total: (@order.sales_tax + @order.subtotal))

    line_items.destroy_all
  end
end
