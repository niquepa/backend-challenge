class ShortenUrl < ApplicationService
  def initialize(url)
    @url = url
    @client = Bitly::API::Client.new(token: ENV['BITLY_TOKEN'])
  end

  def call
    bitly = @client.shorten(long_url: @url)
    bitly.link
  rescue Bitly::Error => e
    raise ShortenUrlException.new(message: "ShortenUrlException: #{e}")
  end

end
