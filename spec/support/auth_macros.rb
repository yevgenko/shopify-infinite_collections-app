module AuthMacros
  def log_in(attributes = {})
    @_current_shop = create(:shop, attributes)
    visit login_path
    fill_in "shop", with: @_current_shop.url
    click_button "Install"
  end

  def current_shop
    @_current_shop
  end
end
