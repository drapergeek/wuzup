require 'spec_helper'
# as an adminstrator
# when I visit the manual site check page
# I should see that the sites have been checked
feature 'checking services' do
  scenario 'manually update services' do
    create(:monitored_service, name: "google",  url: "http://www.google.com")
    visit admin_manual_site_check_path
    page.should have_content "Site checks ran"
    page.should have_content "google good"
  end
end
