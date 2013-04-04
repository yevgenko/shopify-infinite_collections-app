require 'spec_helper'

feature 'Shop Settings' do
  scenario 'Update preferences' do
    log_in(url: 'ledner-stokes-and-mitchell2152.myshopify.com', paid: true, script_installed: true)
    select '4', from: 'Products per row'
    click_button "Update"
    page.should have_content('Preferences have been updated')
  end
end
