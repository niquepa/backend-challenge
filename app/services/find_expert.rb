class FindExpert < ApplicationService
  # attr_reader @member
  def initialize(member, topic)
    @member = member
    @topic = topic
  end

  def call
    validations
    @friend_ids = get_member_friends_ids
    return [] if @friend_ids.blank?
    get_friends_experts
  end

  private
    def validations
      raise FindExpertsException::InvalidArgumentsException.new(message: "Invalid arguments") if @topic.blank?
    end

    def get_member_friends_ids
      @member.friends.pluck(:id).join(',')
    end

    def get_friends_experts(relation: Member.all)
      relation.select("members.id, members.name, members.short_url, (select name from members m where m.id = CASE WHEN friendships.member_id in (#{@friend_ids}) THEN friendships.member_id ELSE friendships.friend_id END) as friend, headings.text")
          .joins("INNER JOIN friendships ON (friendships.member_id in (#{@friend_ids})  OR friendships.friend_id in (#{@friend_ids}))")
          .joins(:headings)
          .where("members.id = CASE WHEN friendships.member_id in (#{@friend_ids}) THEN friendships.friend_id ELSE friendships.member_id END")
          .where("members.id NOT IN (#{@friend_ids}, #{@member.id})")
          .where('headings.text iLIKE ?', "%#{@topic}%")
          .distinct
    end

end
