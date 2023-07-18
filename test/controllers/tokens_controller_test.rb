require 'test_helper'

class TokensControllerTest < ActionDispatch::IntegrationTest
  test 'should get create' do
    get tokens_create_url
    assert_response :success
  end

  test 'should get verify' do
    get tokens_verify_url
    assert_response :success
  end
end
