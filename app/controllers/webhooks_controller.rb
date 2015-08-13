class WebhooksController < ApplicationController
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  
  def uninstall
    puts "uninstall fired"
    shop = Shop.find_or_initialize_by(shopify_domain: ShopifyAPI::Shop.current.domain)
    charge = ShopifyAPI::RecurringApplicationCharge.find(shop.shopify_reccuring_charge_id)
    charge.delete    
  end
end
