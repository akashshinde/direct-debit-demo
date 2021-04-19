class ApplicationController < ActionController::Base
  def initialize
    super
    @client = GoCardlessPro::Client.new(
      access_token: ENV['GC_ACCESS_TOKEN'],
      environment: :sandbox
    )
  end
end
