class BaseException < StandardError
  attr_reader :message, :response

  def initialize(message: nil, response: nil)
    @message, @response = message, response
  end
end
