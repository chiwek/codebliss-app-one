class HomeController < ApplicationController
  before_action :login_again_if_different_shop
  around_filter :shopify_session
  layout 'embedded_app'

  def index
   init_webhooks
   @charges = ShopifyAPI::RecurringApplicationCharge.all
  end
  
  def payed
    
    puts "Payed action started"
    charge = ShopifyAPI::RecurringApplicationCharge.find(params[:id])
    
    shop = Shop.find_or_initialize_by(shopify_domain: ShopifyAPI::Shop.current.shopify_domain)
    if charge.status == "accepted" || charge.status == "pending" 
      shop.shopify_reccuring_charge_id = params[:id]
      puts "Payed action accepted and saved"
    else
      puts "Payed action not accepted and saved"
      shop.shopify_reccuring_charge_id = nil
    end
    
    shop.save!
    puts "Payed action end"
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
      shop = Shop.find_or_initialize_by(shopify_domain: ShopifyAPI::Shop.current.shopify_domain)
      if shop.shopify_reccuring_charge_id == nil
        charge = ShopifyAPI::RecurringApplicationCharge.find(params[:id])
              
        price = 20.0
        plan_name = ShopifyAPI::Shop.current.plan_name
        
        if plan_name == "basic" 
          price = 10.0
        end
        charge = ShopifyAPI::RecurringApplicationCharge.create({:name => "Standard Plan", :price => price, :trial_days => 7, :test => true, :return_url => "http://#{DOMAIN_NAME}/home/payed"})
        redirect_to(charge.confirmation_url)
      end     
    rescue => ex
      puts ex.message    
    end
    charges
  end
end
