class WidgetController < ApplicationController
  def index
    @shop = Shop.find_by_url!(params[:shop])
  end
end
