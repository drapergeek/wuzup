class CreateMonitoredServices < ActiveRecord::Migration
  def change
    create_table :monitored_services do |t|
      t.string :name

      t.timestamps
    end
  end
end
