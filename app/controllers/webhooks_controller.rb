class WebhooksController < ApplicationController
  def uninstall
    puts "uninstall fired"
    params.each do |key, val|
      puts "key: " << key.to_s << ", val:" << val.to_s      
    end
  end
end
