require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get home_home_url
    assert_response :success
  end

  test "should get contact" do
    get contact_url
    assert_response :success

    assert_template layout: 'application'

    assert_select 'h1', 'Contact Us.'
    assert_select 'p', 'If you have any question. Please feel free to contact us directly by completing the form below.'
  end

end
