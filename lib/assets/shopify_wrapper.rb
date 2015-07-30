class ShopifyWrapper

  @@shop_url = "https://3dae693202e59c005bab6edbea7bfeae:9072b1f172b0707b18b51576c9a4722a@sbtd-test-store.myshopify.com/admin"

  def initialize(fill_products = true)
    if Rails.env != 'production'
      ShopifyAPI::Base.site = @@shop_url
    end

  end
  
  def api()
    ShopifyAPI
  end
end
