require 'twitter-text'
require 'twitter'
class TwitterApi
  include Twitter::TwitterText::Validation
  attr_reader :client

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
    end
  end

  def tweet volop
    url='https://www.harrowcn.org.uk/'
    msg = "New #volunteer opportunity: #{volop.title} - For more information visit #{url}"
    valid_tweet = parse msg
    client.update valid_tweet
  end

  private
    def parse msg
      parse_result = parse_tweet msg
      msg[parse_result[:valid_range_start]..parse_result[:valid_range_end]]
    end
end
