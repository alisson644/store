class SubscriptersController < ApplicationController
  allow_unauthenticated_access
  before_action :set_product

  def create
    @subscripter = @product.subscripters.new(subscripter_params)

    if @subscripter.save
      redirect_to @product, notice: "You have successfully subscribed to this product."
    else
      redirect_to @product, alert: "There was an error subscribing to this product."
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def subscripter_params
    params.expect(subscripter: [ :email ])
  end
end
