require 'test_helper'

class MtxProductsControllerTest < ActionController::TestCase
  setup do
    @mtx_product = mtx_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mtx_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mtx_product" do
    assert_difference('MtxProduct.count') do
      post :create, mtx_product: { description: @mtx_product.description, intro: @mtx_product.intro, name: @mtx_product.name, price: @mtx_product.price, status: @mtx_product.status }
    end

    assert_redirected_to mtx_product_path(assigns(:mtx_product))
  end

  test "should show mtx_product" do
    get :show, id: @mtx_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mtx_product
    assert_response :success
  end

  test "should update mtx_product" do
    patch :update, id: @mtx_product, mtx_product: { description: @mtx_product.description, intro: @mtx_product.intro, name: @mtx_product.name, price: @mtx_product.price, status: @mtx_product.status }
    assert_redirected_to mtx_product_path(assigns(:mtx_product))
  end

  test "should destroy mtx_product" do
    assert_difference('MtxProduct.count', -1) do
      delete :destroy, id: @mtx_product
    end

    assert_redirected_to mtx_products_path
  end
end
