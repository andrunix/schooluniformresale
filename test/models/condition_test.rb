require 'test_helper'

class ConditionTest < ActiveSupport::TestCase
# describe Condition do
  test "should save with description" do
    cnd = Condition.new
    assert_not cnd.save
    cnd.description = "Like New"
    assert cnd.save
  end

end
