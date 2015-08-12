class WebhooksController < ApplicationController
  def uninstall
    puts "uninstall fired"
    @charges = ShopifyAPI::RecurringApplicationCharge.all
    @charges.each do |charge|
      charge.delete
    end
    
  end
end
