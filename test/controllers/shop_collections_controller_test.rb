require 'test_helper'

class ShopCollectionsControllerTest < ActionController::TestCase
  setup do
    @shop_collection = shop_collections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shop_collections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shop_collection" do
    assert_difference('ShopCollection.count') do
      post :create, shop_collection: { autofill: @shop_collection.autofill, checked_at: @shop_collection.checked_at, instock_only: @shop_collection.instock_only, name: @shop_collection.name, shop_collection_id: @shop_collection.shop_collection_id, sort_field: @shop_collection.sort_field, sort_order: @shop_collection.sort_order }
    end

    assert_redirected_to shop_collection_path(assigns(:shop_collection))
  end

  test "should show shop_collection" do
    get :show, id: @shop_collection
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shop_collection
    assert_response :success
  end

  test "should update shop_collection" do
    patch :update, id: @shop_collection, shop_collection: { autofill: @shop_collection.autofill, checked_at: @shop_collection.checked_at, instock_only: @shop_collection.instock_only, name: @shop_collection.name, shop_collection_id: @shop_collection.shop_collection_id, sort_field: @shop_collection.sort_field, sort_order: @shop_collection.sort_order }
    assert_redirected_to shop_collection_path(assigns(:shop_collection))
  end

  test "should destroy shop_collection" do
    assert_difference('ShopCollection.count', -1) do
      delete :destroy, id: @shop_collection
    end

    assert_redirected_to shop_collections_path
  end
end
