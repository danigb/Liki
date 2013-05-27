class InboxController < ApplicationController
  include Mandrill::Rails::WebHookProcessor

  def handle_inbound(event_payload)
    logger.info "INBOX: #{event_payload.inspect}"
  end
end
