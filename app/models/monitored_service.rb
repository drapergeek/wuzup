class MonitoredService < ActiveRecord::Base
  SERVICE_CHECK_COUNT = 3
  WARNING = 'warning'
  FAILURE = 'failure'
  GOOD = 'good'
  UNKNOWN = 'unknown'

  attr_accessible :name

  has_many :service_checks

  def status
    if sufficient_checks?
      if down_check_count >= 1 && down_check_count <= 2
        WARNING
      elsif down_check_count == 3
        FAILURE
      elsif up_check_count == 3
        GOOD
      end
    else
      UNKNOWN
    end
  end

  def up_check_count
    previous_checks.select(&:up).count
  end

  def down_check_count
    previous_checks.reject(&:up).count
  end

  private

  def previous_checks
    service_checks.limit(SERVICE_CHECK_COUNT).order("created_at DESC")
  end

  def sufficient_checks?
    up_check_count + down_check_count == SERVICE_CHECK_COUNT
  end
end
