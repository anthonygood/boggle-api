require "test_helper"

class DecoratedGridsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @decorated = create :decorated_grid
  end

  test "is successful" do
    get "/grid"

    assert_response :success
  end

  test "index should supply random decorated grid by default" do
    get "/grid"

    json_id = json_response["id"]["$oid"]

    assert_equal json_id, @decorated.id.to_s
  end
end
