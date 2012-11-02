namespace :dev do
  desc "Creates some sample data for testing locally"
  task prime: 'db:migrate' do
    require 'database_cleaner'
    require 'factory_girl_rails'

    if Rails.env != "development"
      raise "This task can only be create in the development environment"
    end

    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean

    puts "Creating development data..."
    puts ""
    puts "**** USERS ****"

    admin = FactoryGirl.create(:user, email: 'admin@example.com')
    puts "Admin login: #{admin.email} / #{admin.password}"

    puts "**** DONE ****"
    puts ""
  end
end
