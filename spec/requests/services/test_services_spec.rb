require 'spec_helper'

feature 'checking services' do
  scenario 'manually update services' do
    create_monitored_service
    visit admin_manual_site_check_path
    verify_monitored_service_checked
  end

  def create_monitored_service
    create(:monitored_service, name: "google", url: "http://www.google.com")
  end

  def verify_monitored_service_checked
    page.should have_content "Site checks ran"
    page.should have_content "google good"
  end
end
