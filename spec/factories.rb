FactoryGirl.define do
  factory :monitored_service do
    name "Main Website"
    factory :good_service do
      after(:create) do |service|
        service.service_checks << create(:up_check)
        service.service_checks << create(:up_check)
        service.service_checks << create(:up_check)
      end
    end
  end

  factory :service_check do
    monitored_service

    factory :up_check do
      up true
    end

    factory :down_check do
      up false
    end
  end
end
