class HomeController < ApplicationController
  before_action :login_again_if_different_shop
  around_filter :shopify_session
  layout 'embedded_app'

  def index
   init_webhooks
   @charges = ShopifyAPI::RecurringApplicationChargeTest.all
      
  end
  
  def init_webhooks
    begin
     webhook = ShopifyAPI::Webhook.create(:format => "json", :topic => "app/uninstalled", :address => "http://#{DOMAIN_NAME}/webhooks/uninstall")
     raise "Webhook invalid: #{webhook.errors}" unless webhook.valid?
    rescue => ex
      puts ex.message
    
    end
  end 

  def init_payment
    begin
      charges = ShopifyAPI::RecurringApplicationCharge.all
      /*
      price = 20.0
      plan_name = ShopifyAPI::Shop.current.plan_name
      if plan_name == "basic" 
        price = 10.0
      end
     charge = ShopifyAPI::RecurringApplicationCharge.create({:name => "Standard Plan", :price => price, :trial_days => 7, :test => true})
     redirect_to(charge.confirmation_url)
     */
    rescue => ex
      puts ex.message    
    end
    charges
  end
end
