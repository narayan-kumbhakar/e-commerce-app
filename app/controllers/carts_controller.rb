class CartsController < ApplicationController
    before_action :set_cart, only: %i[ show destroy ]

    def show
        render json: @cart
    end

    def destroy
        @cart.destroy
    end

    private

    def set_cart
        @cart = Cart.find(params[:id])
    end

    def cart_params
        params.require(:cart).permit(:user_id)
    end
end
