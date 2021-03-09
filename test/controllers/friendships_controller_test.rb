require "test_helper"

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @member = members(:one)
    @member2 = members(:two)
    @friendship = friendships(:one)
  end

  test "should get index" do
    get member_friendships_url(@member), as: :json
    assert_response :success
  end

  test "should create friendship" do
    assert_difference('Friendship.count') do
      post member_friendships_url(@member), params: { friendship: { friend_id: @member2.id } }, as: :json
    end

    assert_response 201
  end

  test "should not create duplicated friendship" do
    post member_friendships_url(@member), params: { friendship: { friend_id: @member2.id } }, as: :json
    assert_response 201
    post member_friendships_url(@member), params: { friendship: { friend_id: @member2.id } }, as: :json
    assert_response 422
    post member_friendships_url(@member2), params: { friendship: { friend_id: @member.id } }, as: :json
    assert_response 422
  end

  test "should show friendship" do
    get member_friendship_url(@member, @friendship), as: :json
    assert_response :success
  end

  test "should destroy friendship" do
    assert_difference('Friendship.count', -1) do
      delete member_friendship_url(@member, @friendship), as: :json
    end

    assert_response 204
  end
end
