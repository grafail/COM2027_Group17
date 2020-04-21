require 'test_helper'

class CartControllerTest < ActionDispatch::IntegrationTest
  test "should get cart" do
    get cart_cart_url
    assert_response :success
  end

end
