require 'test_helper'

class FormsControllerTest < ActionController::TestCase
  setup do
    @form = forms(:one)
    @update = {
        
        


    prod_int_num: 0,
    prod_num: 'M1111',
    model_num: 'c-123',
    manufacturer: 'Something Brand INC.',
    upc: 123456789000,
    part_num: 'c-123',
    prod_type: 'Something',
    prod_terms: 'Something something something',
    dropship: 0,
    hype: 1,
    comp_price: 'msr',
    was_price_line: 999.99,
    price_add_on: 999.99,
    web_rest: 99.9,

    }
    
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:forms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create form" do
    assert_difference('Form.count') do
      post :create, form: {  }
    end

    assert_redirected_to form_path(assigns(:form))
  end

  test "should show form" do
    get :show, id: @form
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @form
    assert_response :success
  end

  test "should update form" do
    patch :update, id: @form, form: {  }
    assert_redirected_to form_path(assigns(:form))
  end

  test "should destroy form" do
    assert_difference('Form.count', -1) do
      delete :destroy, id: @form
    end

    assert_redirected_to forms_path
  end
end
