# frozen_string_literal: true
require 'gocardless_pro'

class WebhooksController < ApplicationController
  include ActionController::Live

  protect_from_forgery except: :create
  
  def create
    # We recommend storing your webhook endpoint secret in an environment variable
    # for security
    webhook_endpoint_secret = ENV['GC_WEBHOOK_TOKEN']

    # In a Rack app (e.g. Sinatra), access the POST body with
    # `request.body.tap(&:rewind).read`
    request_body = request.raw_post

    # In a Rack app (e.g. Sinatra), the header is available as
    # `request.env['HTTP_WEBHOOK_SIGNATURE']`
    signature_header = request.headers['Webhook-Signature']

    begin
      events = GoCardlessPro::Webhook.parse(request_body: request_body,
                                            signature_header: signature_header,
                                            webhook_endpoint_secret: webhook_endpoint_secret)

      # Process the events...
      events.each do |event|
        e = Event.new
        e.event_id = event.id
        e.created_at = event.created_at
        e.action = event.action
        e.origin = event.details['origin']
        e.cause = event.details['cause']
        e.description = event.details['description']
        e.resource_type = event.resource_type
        e.save
      end

      render status: 204, nothing: true
    rescue GoCardlessPro::Webhook::InvalidSignatureError
      render status: 498, nothing: true
    end
  end
end
