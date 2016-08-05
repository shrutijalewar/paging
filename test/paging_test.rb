require 'test_helper'

describe Paging do

  it "has_a_version_number" do
    refute_nil ::Paging::VERSION
  end

  it "responds to generate" do
    assert_respond_to Paging, :generate
  end
end
