class ShopifyWrapper

  #@@shop_url = "https://711d686956e799ae867fdb837820cfd6:49967b3a20577534592bcac931adf83a@saved-by-the-dress.myshopify.com/admin"
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