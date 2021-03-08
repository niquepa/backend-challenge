class MembersController < ApplicationController
  before_action :set_member, only: [:show, :update, :destroy]

  # GET /members
  def index
    @members = Member.all

    render json: @members, each_serializer: MembersSerializer
  end

  # GET /members/1
  def show
    render json: @member
  end

  # POST /members
  def create
    @member = Member.new(member_params)

    @member.short_url = ShortenUrl.call(@member.url)

    if @member.save
      CreateMemberHeadings.call(@member)
      render json: @member, status: :created, location: @member
    else
      render json: @member.errors, status: :unprocessable_entity
    end

  rescue ShortenUrlException, CreateMemberHeadingsException => e
    render json: { errors: e.message }, status: :unprocessable_entity
  end

  # PATCH/PUT /members/1
  def update
    
    if @member.update(member_params)
      if @member.url_changed?
        @member.short_url = ShortenUrl.call(@member.url)
        CreateMemberHeadings.call(@member)
        end
      render json: @member
    else
      render json: @member.errors, status: :unprocessable_entity
    end
  end

  # DELETE /members/1
  def destroy
    @member.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def member_params
      params.require(:member).permit(:name, :url).tap do |require_params|
        require_params.require([:name, :url])
      end
    end
end
