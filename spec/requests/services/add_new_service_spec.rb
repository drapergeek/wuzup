require 'spec_helper'

feature 'Add services' do
  scenario 'Admin adds valid service' do
    sign_in_as_admin
    add_new_service
    verify_flash_on_new_service_page
    verify_new_service_shows_on_homepage
  end

  scenario 'Admin creates invalid service' do
    sign_in_as_admin
    create_invalid_service
    verify_service_was_not_created
  end

  def verify_service_was_not_created
    page.should have_content 'Could not add service, please check for errors.'
  end

  def create_invalid_service
    click_link 'Add Service'
    click_button 'Add Service'
  end

  def add_new_service
    click_link 'Add Service'
    fill_in 'Name', with: 'Google'
    fill_in 'Url', with: 'http://google.com'
    click_button 'Add Service'
  end

  def verify_flash_on_new_service_page
    page.should have_content "Added Google"
    page.should have_content "Add Service"
  end

  def verify_new_service_shows_on_homepage
    visit root_path
    page.should have_content "Google"
  end

  def sign_in_as_admin
    user = create(:user)
    visit root_url
    click_link 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end
end
