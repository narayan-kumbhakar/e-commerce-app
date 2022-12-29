class CartItemsController < ApplicationController
    def create
        # Find associated product and current cart
        chosen_product = Product.find(params[:product_id])
        add_items_to_cart(chosen_product)
        
        if @cart_item.save!
            render(json: CartItemSerializer.new(@cart_item).serializable_hash.to_json)
        else
            render json: { errors: @cart_item.errors.full_messages },
            status: :unprocessable_entity
        end
        
    end

    def destroy
        @cart_item = CartItem.find(params[:id])
        @cart_item.destroy
    end

    def add_quantity
        @cart_item = CartItem.find(params[:id])
        @cart_item.quantity += 1
        if @cart_item.save
            render(json: CartItemSerializer.new(@cart_item).serializable_hash.to_json)
        end
    end

    def reduce_quantity
        @cart_item = CartItem.find(params[:id])
        if @cart_item.quantity > 1
            @cart_item.quantity -= 1
            if @cart_item.save
                render(json: CartItemSerializer.new(@cart_item).serializable_hash.to_json)
            end
        elsif @cart_item.quantity == 1
            destroy
        end
    end

    private

    def cart_item_params
        params.require(:cart_item).permit(:quantity, :price, :product_id, :cart_id, :order_id)
    end

    def add_items_to_cart(chosen_product)
        @current_cart = Cart.find(params[:cart_id])
        if @current_cart.products.include?(chosen_product)
            @cart_item = @current_cart.cart_items.find_by(product_id: chosen_product)
            @cart_item.quantity += 1
        else
            @cart_item = CartItem.new
            @cart_item.cart = @current_cart
            @cart_item.product = chosen_product
            @cart_item.quantity = 1
        end
    end
end
