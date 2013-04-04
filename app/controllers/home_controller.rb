class HomeController < ApplicationController

  around_filter :shopify_session

  def index
    shop = Shop.find_by_url(shop_session.url)
    redirect_to edit_shop_path(shop)
  end

end
