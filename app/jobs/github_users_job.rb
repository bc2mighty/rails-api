require 'net/http'

class GithubUsersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    p "In active Jobs:"
    p args
    # "https://api.github.com/users/#{args.first[:username]}"
    uri = URI("https://api.github.com/users")
    response = Net::HTTP.get(uri)
    p response
    # return render json: response
  end
end
