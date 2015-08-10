class HomeController < ApplicationController
  before_action :login_again_if_different_shop
  around_filter :shopify_session
  layout 'embedded_app'

  def index
   init_webhooks 
  end
  
  def init_webhooks
    begin
     webhook = ShopifyAPI::Webhook.create(:format => "json", :topic => "app/uninstalled", :address => "http://#{DOMAIN_NAME}/webhooks/uninstall")
     raise "Webhook invalid: #{webhook.errors}" unless webhook.valid?
    rescue => ex
      puts ex.message
    
    end
  end 

end
