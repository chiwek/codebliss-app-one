class WebhooksController < ApplicationController
  around_filter :shopify_session
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  
  def uninstall
    puts "uninstall fired"
    
    
  end
end
