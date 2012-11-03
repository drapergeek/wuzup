require 'spec_helper'

describe ServiceCheck do
  it { should belong_to(:monitored_service) }
  it { should validate_presence_of(:monitored_service) }
end
