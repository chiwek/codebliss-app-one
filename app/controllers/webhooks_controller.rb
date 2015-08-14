require 'base64'
require 'openssl'
    
class WebhooksController < ApplicationController
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  
  def uninstall
    puts "uninstall fired"
    data = env["HTTP_X_SHOPIFY_HMAC_SHA256"]
    puts data
    puts "secret:"
    puts ShopifyApp.configuration.secret
    
    
    digest  = OpenSSL::Digest::Digest.new('sha256')
    val = OpenSSL::HMAC.digest(digest, ShopifyApp.configuration.secret, data)
    calculated_hmac = Base64.encode64(val).strip
    
    verified = calculated_hmac == data
    
    puts verified
    
    #shop = Shop.find_or_initialize_by(shopify_domain: ShopifyAPI::Shop.current.domain)
    #charge = ShopifyAPI::RecurringApplicationCharge.find(shop.shopify_reccuring_charge_id)
    #charge.delete    
  end
end
