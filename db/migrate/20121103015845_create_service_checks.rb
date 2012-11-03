class CreateServiceChecks < ActiveRecord::Migration
  def change
    create_table :service_checks do |t|
      t.boolean :up, default: false
      t.references :monitored_service, null: false

      t.timestamps
    end
  end
end
