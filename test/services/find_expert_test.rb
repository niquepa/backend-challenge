require "test_helper"

class FriendsQueryTest < ActiveSupport::TestCase
  setup do
    @member = members(:one)
    @member2 = members(:two)
    @member3 = members(:three)
    @member4 = members(:four)
    @member6 = members(:six)
  end

  test "should connect friends" do
    experts = FindExpert.call(@member, "dog breeding")
    assert_includes experts, @member2
    assert_includes experts,  @member4
    assert_not_includes experts, @member3
  end

  test "should return empty if no friends" do
    experts = FindExpert.call(@member6, "dog breeding")
    assert_equal experts, []
  end

end
