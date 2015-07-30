class ShopCollectionsController < ApplicationController
  before_action :set_shop_collection, only: [:show, :edit, :update, :destroy]


  # GET /shop_collections
  # GET /shop_collections.json
  def index
    @shop_collections = ShopCollection.all
    puts Rails.env
  end

  # GET /shop_collections/1
  # GET /shop_collections/1.json
  def show
  end

  # GET /shop_collections/new
  def new
    sp = ShopifyWrapper.new
    @shopify_collections = sp.api::CustomCollection.find(:all)
    puts @shopify_collections
    #@shopify_collections = [{"id" => 1, "title" => "Test 1", "handle" => "test-1"}, {"id" => 2, "title" => "Test 2", "handle" => "test-2"}]
    @shop_collection = ShopCollection.new
    
    
  end

  # GET /shop_collections/1/edit
  def edit
    @shopify_collections = ShopifyAPI::CustomCollection.find(:all)
    
  end

  # POST /shop_collections
  # POST /shop_collections.json
  def create
    @shop_collection = ShopCollection.new(shop_collection_params)

    respond_to do |format|
      if @shop_collection.save
        format.html { redirect_to @shop_collection, notice: 'Shop collection was successfully created.' }
        format.json { render :show, status: :created, location: @shop_collection }
      else
        format.html { render :new }
        format.json { render json: @shop_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shop_collections/1
  # PATCH/PUT /shop_collections/1.json
  def update
    respond_to do |format|
      if @shop_collection.update(shop_collection_params)
        format.html { redirect_to @shop_collection, notice: 'Shop collection was successfully updated.' }
        format.json { render :show, status: :ok, location: @shop_collection }
      else
        format.html { render :edit }
        format.json { render json: @shop_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop_collections/1
  # DELETE /shop_collections/1.json
  def destroy
    @shop_collection.destroy
    respond_to do |format|
      format.html { redirect_to shop_collections_url, notice: 'Shop collection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop_collection
      @shop_collection = ShopCollection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_collection_params
      params.require(:shop_collection).permit(:name, :shop_collection_id, :autofill, :sort_field, :sort_order, :instock_only, :checked_at)
    end
end
