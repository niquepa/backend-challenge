require 'open-uri'

class CreateMemberHeadings < ApplicationService
  def initialize(member)
    @member = member
    @url = member.url
  end

  def call
    site = Nokogiri::HTML(URI.open(@url))
    ['h1','h2','h3'].each do |tag|
      site.css(tag).each do |i|
        Heading.create(member: @member, text: i.text.strip)
      end
    end
  rescue Exception => e
    raise CreateMemberHeadingsException.new(message: "HeadingsException: #{e}")
  end

end
