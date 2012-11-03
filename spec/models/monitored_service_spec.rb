require 'spec_helper'

describe MonitoredService do
  it { should have_many(:service_checks) }

  describe "#status" do
    let!(:service) { build_stubbed(:monitored_service) }

    context "with less than 3 previous checks" do
      it "has a status of unknown" do
        service.stubs(:sufficient_checks?).returns(false)
        service.status.should == 'unknown'
      end
    end

    context "with 1/3 previous checks as bad" do
      it "has a status of warning" do
        service.stubs(:up_check_count).returns(2)
        service.stubs(:down_check_count).returns(1)
        service.status.should == 'warning'
      end
    end

    context "with 2/3 previous checks as bad" do
      it "has a status of warning" do
        service.stubs(:up_check_count).returns(1)
        service.stubs(:down_check_count).returns(2)
        service.status.should == 'warning'
      end
    end

    context "with 3/3 previous checks as bad" do
      it "has a status of failure" do
        service.stubs(:up_check_count).returns(0)
        service.stubs(:down_check_count).returns(3)
        service.status.should == 'failure'
      end
    end

    context "with 3 previous checks as good" do
      it "has a status of good" do
        service.stubs(:up_check_count).returns(3)
        service.stubs(:down_check_count).returns(0)
        service.status.should == 'good'
      end
    end
  end

  describe "#up_check_count" do
    let!(:service) { create(:monitored_service) }

    context "with more than 3 previous service checks" do
      it "returns only from the last 3 good checks" do
        create(:up_check, monitored_service: service)
        create(:up_check, monitored_service: service)
        create(:up_check, monitored_service: service)
        create(:down_check, monitored_service: service)

        service.up_check_count.should == 2
      end
    end

    it "returns the number of good_checks from the last 3 checks" do
      create(:up_check, monitored_service: service)
      create(:down_check, monitored_service: service)
      create(:down_check, monitored_service: service)

      service.up_check_count.should == 1
    end
  end

  describe "#down_check_count" do
    it "returns the number of back checks from the last 3 checks" do
      service = create(:monitored_service)

      create(:up_check, monitored_service: service)
      create(:down_check, monitored_service: service)
      create(:down_check, monitored_service: service)

      service.down_check_count.should == 2
    end
  end
end
