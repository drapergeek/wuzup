require 'spec_helper'

feature 'monitored services' do
  scenario 'list all monitored services' do
    create_monitored_services
    visit root_path
    verify_service_names_on_page
  end

  def create_monitored_services
    @services = []
    @services << create(:monitored_service, name: "Main Website")
    @services << create(:monitored_service, name: "Internal Website")
    @services << create(:monitored_service, name: "Mail Website")
  end

  def verify_service_names_on_page
    @services.all? do |service|
      page.should have_content service.name
    end
  end
end
