class SubscribersController < ApplicationController
  allow_unauthenticated_access
  before_action :set_product

  def create
    @subscriber = @product.subscribers.new(subscriber_params)

    if @subscriber.save
      redirect_to @product, notice: "You have successfully subscribed to this product."
    else
      redirect_to @product, alert: "There was an error subscribing to this product."
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def subscriber_params
    params.expect(subscriber: [ :email ])
  end
end
