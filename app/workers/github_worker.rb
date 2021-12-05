require 'net/http'

class GithubWorker
  include Sidekiq::Worker

  def perform(*args)
    # Do something
    p "Worker about to start"
    uri = URI("https://api.github.com/users")
    response = Net::HTTP.get(uri)
    p response
    p "Worker ends"
  end
end
