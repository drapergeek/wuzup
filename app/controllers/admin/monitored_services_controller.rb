class Admin::MonitoredServicesController < ApplicationController
  def new
    @monitored_service = MonitoredService.new
  end

  def create
    monitored_service = MonitoredService.new(service_params)
    monitored_service.save

    flash[:notice] = "Added #{monitored_service.name}"
    redirect_to new_admin_monitored_service_path
  end

  private

  def service_params
    params.require(:monitored_service).permit(:name, :url)
  end
end
