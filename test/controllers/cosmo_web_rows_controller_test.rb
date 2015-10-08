require 'test_helper'

class CosmoWebRowsControllerTest < ActionController::TestCase
  setup do
    @cosmo_web_row = cosmo_web_rows(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cosmo_web_rows)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cosmo_web_row" do
    assert_difference('CosmoWebRow.count') do
      post :create, cosmo_web_row: {  }
    end

    assert_redirected_to cosmo_web_row_path(assigns(:cosmo_web_row))
  end

  test "should show cosmo_web_row" do
    get :show, id: @cosmo_web_row
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cosmo_web_row
    assert_response :success
  end

  test "should update cosmo_web_row" do
    patch :update, id: @cosmo_web_row, cosmo_web_row: {  }
    assert_redirected_to cosmo_web_row_path(assigns(:cosmo_web_row))
  end

  test "should destroy cosmo_web_row" do
    assert_difference('CosmoWebRow.count', -1) do
      delete :destroy, id: @cosmo_web_row
    end

    assert_redirected_to cosmo_web_rows_path
  end
end
