require "test_helper"

class MultiplierTest < ActiveSupport::TestCase

  test "validates acts upon" do
    multi = Multiplier.new acts_upon: :baboon

    refute multi.valid?
  end
end
