class MonitoredServicesController < ApplicationController
  def index
    @monitored_services = MonitoredService.all
  end
end
