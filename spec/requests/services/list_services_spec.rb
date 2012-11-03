require 'spec_helper' 
feature 'monitored services' do
  scenario 'list all monitored services' do
    create_monitored_services
    visit root_path
    verify_service_names_on_page
  end

  scenario 'view status of monitored services' do
    good_service = create(:good_service)
    visit root_path
    verify_page_has_status_for_service(good_service, "good")
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

  def verify_page_has_status_for_service(service, status)
    within "li#service_#{service.id}" do
      page.should have_content status
    end
  end
end
