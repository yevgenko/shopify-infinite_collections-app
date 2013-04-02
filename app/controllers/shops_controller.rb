class ShopsController < ApplicationController
  around_filter :shopify_session
  before_filter :correct_shop?
  before_filter :paid_shop?

  # GET /shops/1/edit
  def edit
    @shop = Shop.find(params[:id])
  end

  # PUT /shops/1
  # PUT /shops/1.json
  # def update
  #   @shop = Shop.find(params[:id])

  #   respond_to do |format|
  #     if @shop.update_attributes(params[:shop])
  #       format.html { redirect_to @shop, notice: 'Shop was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @shop.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  private

  # ensure shops can't modify each other's data
  def correct_shop?
    @shop ||= Shop.find(params[:id])
    unless shop_session.url == @shop.url
      session[:shopify] = nil
      redirect_to login_url, :alert => "Access denied."
    end
  end

  # ensure is paid shop
  def paid_shop?
    @shop ||= Shop.find(params[:id])
    redirect_to billing_index_path unless @shop.paid
  end
end
