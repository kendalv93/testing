require 'test_helper'

class CsvRowsControllerTest < ActionController::TestCase
  setup do
    @csv_row = csv_rows(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:csv_rows)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create csv_row" do
    assert_difference('CsvRow.count') do
      post :create, csv_row: {  }
    end

    assert_redirected_to csv_row_path(assigns(:csv_row))
  end

  test "should show csv_row" do
    get :show, id: @csv_row
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @csv_row
    assert_response :success
  end

  test "should update csv_row" do
    patch :update, id: @csv_row, csv_row: {  }
    assert_redirected_to csv_row_path(assigns(:csv_row))
  end

  test "should destroy csv_row" do
    assert_difference('CsvRow.count', -1) do
      delete :destroy, id: @csv_row
    end

    assert_redirected_to csv_rows_path
  end
end
