require "test_helper"

class FriendsQueryTest < ActiveSupport::TestCase
  setup do
    @member2 = members(:two)
    @friendship = friendships(:one)
    @friendship3 = friendships(:three)
  end

  test "should include friends" do
    friends = @friendship.member.friends
    assert_includes friends, @friendship.friend
    assert_includes friends,  @friendship3.member
    assert_not_includes friends, @member2
  end

end
