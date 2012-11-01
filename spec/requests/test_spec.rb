require 'spec_helper'

feature 'home page load' do
  scenario 'load the home page' do
    visit root_path
    page.should have_content "Sign in"
  end
end

