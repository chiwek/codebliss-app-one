require 'base64'
require 'openssl'
    
class WebhooksController < ApplicationController
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  
  def uninstall
    connect_to_store
    
    shop = Shop.find_or_initialize_by(shopify_domain: ShopifyAPI::Shop.current.domain)
    charge = ShopifyAPI::RecurringApplicationCharge.find(shop.shopify_reccuring_charge_id)
    charge.delete
    shop.shopify_reccuring_charge_id = nil
    shop.save!
    puts "shop payment removed"
        
  end
  
  def verifiy_webhook
    data = env["HTTP_X_SHOPIFY_HMAC_SHA256"]
    digest  = OpenSSL::Digest::Digest.new('sha256')
    val = OpenSSL::HMAC.digest(digest, ShopifyApp.configuration.secret, data)
    calculated_hmac = Base64.encode64(val).strip
    
    calculated_hmac == data
  end
  
  def product_new
      data = ActiveSupport::JSON.decode(request.body.read)
      shopify_product_id = data["id"]

      Product.new_from_shopify(@s, shopify_product_id)

      head :ok
    end

    private

    def connect_to_store

      shop_url = request.headers['HTTP_X_SHOPIFY_SHOP_DOMAIN']
      @s = Shop.find_or_initialize_by(shopify_domain: shop_url)

      session = ShopifyAPI::Session.new(@s.shopify_domain, @s.shopify_token)
      session.valid?
      ShopifyAPI::Base.activate_session(session)

    end
end
