require 'spec_helper'

describe ServiceChecker do

  describe "#execute" do
    context "given a service with a url is that is up" do
      it "creates a service_check with a status of success" do
        service = stub(url: "http://www.google.com")
        service.stubs(:create_service_check!)

        ServiceChecker.new(service).execute
        service.should have_received(:create_service_check!).with(true)
      end
    end

    context"given a service with a url that is down" do
      it "creates a service_check with a status of failed" do
        service = stub(url: "http://doesnotexisteverjklsfjklsdfjdss2323j.com")
        service.stubs(:create_service_check!)

        ServiceChecker.new(service).execute
        service.should have_received(:create_service_check!).with(false)
      end
    end
  end
end
