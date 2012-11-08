class ServiceChecker

  def initialize(service)
    @service = service
    @url = @service.url
  end

  def execute
    create_service_check
  end

  private

  def create_service_check
    @service.create_service_check!(site_status)
  end

  def site_status
    @site_status ||= check_site_status
  end

  def check_site_status
    begin
      response = HTTParty.get(@url)
      response.code == 200
    rescue SocketError
      false
    end
  end
end
