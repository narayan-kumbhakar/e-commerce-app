class PaymentsController < ApplicationController

    def create
        @order = Order.find(params[:order_id])
        @payment = Payment.new(payment_params)
        if @payment.save
            @payment.update(status: 0, transaction_id: SecureRandom.hex)
            @order.update(status: 1)
            render json: @payment
        else
            render json: { errors: @payment.errors.full_messages },
                status: :unprocessable_entity
        end
    end

    def update
        @payment = Payment.find(params[:id])
        @payment.update(payment_params)
        render json: @payment
    end

    private 

    def payment_params
        params.permit(:status, :order_id)
    end
end
