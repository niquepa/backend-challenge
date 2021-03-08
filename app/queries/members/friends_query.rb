module Members
  class FriendsQuery
  
    def self.call(relation: Member.all , member_id:, scope: false)
      query = relation.joins("INNER JOIN friendships ON (member_id = #{member_id}  OR friend_id = #{member_id})")
      query.where("members.id = CASE WHEN member_id=#{member_id} THEN friend_id ELSE member_id END")
    end
  end
end
