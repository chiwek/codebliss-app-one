class WebhooksController < ApplicationController
  before_action :login_again_if_different_shop
  around_filter :shopify_session
  def uninstall
    puts "uninstall fired"
    @charges = ShopifyAPI::RecurringApplicationCharge.all
    @charges.each do |charge|
      charge.delete
    end
    
  end
end
