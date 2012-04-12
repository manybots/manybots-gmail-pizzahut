require 'test_helper'

module ManybotsGmailPizzahut
  class PizzahutControllerTest < ActionController::TestCase
    test "should get show" do
      get :show
      assert_response :success
    end
  
  end
end
