require 'test_helper'

class SplitwisesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @splitwise = splitwises(:one)
  end

  test "should get index" do
    get splitwises_url
    assert_response :success
  end

  test "should get new" do
    get new_splitwise_url
    assert_response :success
  end

  test "should create splitwise" do
    assert_difference('Splitwise.count') do
      post splitwises_url, params: { splitwise: {  } }
    end

    assert_redirected_to splitwise_url(Splitwise.last)
  end

  test "should show splitwise" do
    get splitwise_url(@splitwise)
    assert_response :success
  end

  test "should get edit" do
    get edit_splitwise_url(@splitwise)
    assert_response :success
  end

  test "should update splitwise" do
    patch splitwise_url(@splitwise), params: { splitwise: {  } }
    assert_redirected_to splitwise_url(@splitwise)
  end

  test "should destroy splitwise" do
    assert_difference('Splitwise.count', -1) do
      delete splitwise_url(@splitwise)
    end

    assert_redirected_to splitwises_url
  end
end
