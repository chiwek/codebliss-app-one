class HomeController < ApplicationController
  before_action :login_again_if_different_shop
  around_filter :shopify_session
  layout 'embedded_app'

  def index
    sp = ShopifyWrapper.new
    @products = sp.api::Product.find(:all, :params => {:limit => 10})
    @shopify_collections = sp.api::CustomCollection.find(:all, :params => {:limit => 10})
  end

end
