class Admin::ManualSiteChecksController < ApplicationController
  def show
    MonitoredService.all.each do |service|
      3.times do
        ServiceChecker.new(service).execute
      end
    end

    flash[:notice] = 'Site checks ran'
    redirect_to root_path
  end
end
