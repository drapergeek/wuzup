class Admin::MonitoredServicesController < ApplicationController
  def new
    @monitored_service = MonitoredService.new
  end

  def create
    monitored_service = MonitoredService.new(service_params)

    if monitored_service.save
      flash[:notice] = "Added #{monitored_service.name}"
      redirect_to new_admin_monitored_service_path
    else
      @monitored_service = monitored_service
      flash[:error] = 'Could not add service, please check for errors.'
      render :new
    end
  end

  private

  def service_params
    params.require(:monitored_service).permit(:name, :url)
  end
end
