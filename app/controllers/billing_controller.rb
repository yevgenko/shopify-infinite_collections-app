class BillingController < ApplicationController
  around_filter :shopify_session

  def index
    charge = ShopifyAPI::RecurringApplicationCharge.create(
      name: 'The Best Plan',
      price: 9,
      return_url: billing_confirm_url,
      trial_days: 14,
      test: Rails.env.development?
    )

    redirect_to charge.confirmation_url
  end

  def confirm
    begin
      ShopifyAPI::RecurringApplicationCharge.find(params[:charge_id]).activate

      s = session[:shopify].url
      shop = Shop.find_by_url(s)
      shop.paid = true
      shop.save

      redirect_to edit_shop_path(shop)
    rescue
      redirect_to login_url, alert: "Sorry, but we're failed to charge your Shopify account."
    end
  end
end
