require 'spec_helper'

describe HomeController do
  def valid_session
    {
      "shopify" => ShopifyAPI::Session.new('demo1.myshopify.com', '12345')
    }
  end

  describe "GET index" do
    it 'redirects to the shop settings page' do
      shop = FactoryGirl.create(:shop)
      get :index, {}, valid_session
      response.should redirect_to edit_shop_path(shop)
    end
  end
end
