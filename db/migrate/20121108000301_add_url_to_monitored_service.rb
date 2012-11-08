class AddUrlToMonitoredService < ActiveRecord::Migration
  def change
    add_column :monitored_services, :url, :string, null: false
  end
end
