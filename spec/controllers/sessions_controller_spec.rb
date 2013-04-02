require 'spec_helper'

describe SessionsController do
  def valid_params
    { "shop" => "demo1.myshopify.com" }
  end

  describe "GET auth/shopify/callback" do
    before do
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:shopify]
    end

    it 'records new shop' do
      expect {
        get :show, valid_params
      }.to change(Shop, :count).by(1)
    end

    it 'redirects to shop#edit page' do
      shop = FactoryGirl.create(:shop)
      get :show, valid_params
      response.should redirect_to edit_shop_url(shop)
    end
  end
end
