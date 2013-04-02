require 'spec_helper'

describe BillingController do
  let(:charge) do
    stub(
      'charge',
      confirmation_url: 'http://example.com/confirm',
      activate: true
    )
  end

  def valid_session
    {
      "shopify" => ShopifyAPI::Session.new('demo1.myshopify.com', '12345')
    }
  end

  def valid_attributes
    {
      charge_id: 1
    }
  end

  describe "GET 'index'" do
    context "without valid shopify session" do
      it 'redirects to login' do
        get :index
        response.should redirect_to(login_path)
      end
    end

    context "with a valid shopify session" do
      it 'creates recurring charge' do
        ShopifyAPI::RecurringApplicationCharge.should_receive(:create).and_return(charge)
        get :index, {}, valid_session
      end

      it 'redirects to payment confirmation url' do
        ShopifyAPI::RecurringApplicationCharge.stub(:create).and_return(charge)
        get :index, {}, valid_session
        response.should redirect_to(charge.confirmation_url)
      end
    end
  end

  describe "GET 'confirm'" do
    before do
      @shop = FactoryGirl.create(:shop)
      Shop.stub(:find_by_url).with('demo1.myshopify.com').and_return(@shop)
      ShopifyAPI::RecurringApplicationCharge.stub(:find).and_return(charge)
    end

    it 'activates charge' do
      charge.should_receive(:activate)
      ShopifyAPI::RecurringApplicationCharge.should_receive(:find).with('1').and_return(charge)
      get :confirm, valid_attributes, valid_session
    end

    context "activation failed" do
      before do
        charge.stub(:activate) { raise ActiveResource::ResourceInvalid, 'Failed.' }
      end

      it "redirects to login" do
        get :confirm, valid_attributes, valid_session
        response.should redirect_to(login_url)
      end
    end

    it "updates shop's payment status" do
      expect{
        get :confirm, valid_attributes, valid_session
      }.to change(@shop, :paid).from(false).to(true)
    end

    it "redirects to shop page" do
      get :confirm, valid_attributes, valid_session
      response.should redirect_to edit_shop_path(@shop)
    end
  end
end
