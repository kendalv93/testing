require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  setup do
    @product = products(:one)
    @product.save!
  end

  test 'should ignore price up dates' do
    Product.find(@product.id).update('price' => 20)
    assert Product.find(@product.id).price == 9.99
  end
  # test "the truth" do
  #   assert true
  # end
end
