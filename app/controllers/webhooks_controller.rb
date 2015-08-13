require 'base64'
require 'openssl'
    
class WebhooksController < ApplicationController
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  
  def uninstall
    puts "uninstall fired"
    puts env["HTTP_X_SHOPIFY_HMAC_SHA256"]
    
    digest  = OpenSSL::Digest::Digest.new('sha256')
    calculated_hmac = Base64.encode64(OpenSSL::HMAC.digest(digest, ShopifyApp.configure.secret, data)).strip
    verified = calculated_hmac == hmac_header
    
    puts verified
    
    #shop = Shop.find_or_initialize_by(shopify_domain: ShopifyAPI::Shop.current.domain)
    #charge = ShopifyAPI::RecurringApplicationCharge.find(shop.shopify_reccuring_charge_id)
    #charge.delete    
  end
end
