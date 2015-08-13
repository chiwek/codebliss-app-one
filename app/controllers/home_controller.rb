class HomeController < ApplicationController
  before_action :login_again_if_different_shop
  around_filter :shopify_session
  layout 'embedded_app'

  def index
   init_webhooks
   #init_payment
   @charges = ShopifyAPI::RecurringApplicationCharge.all
   @charges.each do |charge|
     charge.delete
   end
   
  end
  
  def payed
    puts "Payed action started"
    charge = ShopifyAPI::RecurringApplicationCharge.find(params[:charge_id])
    
    shop = Shop.find_or_initialize_by(shopify_domain: ShopifyAPI::Shop.current.domain)
    puts charge.status
    
    if charge.status == "accepted" || charge.status == "pending" 
      shop.shopify_reccuring_charge_id = params[:charge_id]
      puts "Payed action accepted and saved"
      
    else
      puts "Payed action not accepted and saved"
      shop.shopify_reccuring_charge_id = nil
    end
    
    shop.save!
    puts "Payed action end"
    
    redirect_to("http://#{DOMAIN_NAME}/")
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
      puts "Starting the payment process"
      shop = Shop.find_or_initialize_by(shopify_domain: ShopifyAPI::Shop.current.domain)
      raise "Shop invalid: #{shop.errors}" unless shop.valid?
      puts "Found Shop"
      
      if shop.shopify_reccuring_charge_id.nil? || shop.shopify_reccuring_charge_id.empty?
        puts "Na payment yet, making it happen"              
        price = 20.0
        plan_name = ShopifyAPI::Shop.current.plan_name
        
        if plan_name == "basic" 
          price = 10.0
        end
        
        puts "Found plan"
        charge = ShopifyAPI::RecurringApplicationCharge.create({:name => "Standard Plan", :price => price, :trial_days => 7, :test => true, :return_url => "http://#{DOMAIN_NAME}/home/payed"})
        raise "Charge invalid: #{charge.errors}" unless charge.valid?
        redirect_to(charge.confirmation_url)
      end     
    rescue => ex
      puts ex.message    
    end
  end
end
