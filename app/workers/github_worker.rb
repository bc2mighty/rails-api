require 'net/http'

class GithubWorker
  include Sidekiq::Worker

  def perform(*args)
    # Do something
    uri = URI("https://api.github.com/users")
    response = Net::HTTP.get(uri)
    p response
  end
end
