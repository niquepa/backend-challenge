class FriendshipsController < ApplicationController
  before_action :set_member
  before_action :set_friendship, only: [:show, :update, :destroy]

  # GET /friendships
  def index
    @friendships = @member.friendships

    render json: @friendships
  end

  # GET /friendships/1
  def show
    render json: @friendship
  end

  # POST /friendships
  def create
    @member.is_friend?(params[:friend_id])
    @friendship = @member.friendships.build(friendship_params)

    if @friendship.save
      render json: @friendship, status: :created, location: member_friendships_path(@member)
    else
      render json: @friendship.errors, status: :unprocessable_entity
    end
  end

  # DELETE /friendships/1
  def destroy
    @friendship.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = @member.friendships.find(params[:id])
    end

    def set_member
      @member = Member.find(params[:member_id])
    end

    # Only allow a list of trusted parameters through.
    def friendship_params
      params.require(:friendship).permit(:member_id, :friend_id)
    end
end
