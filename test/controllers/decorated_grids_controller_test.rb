require "test_helper"

class DecoratedGridsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @grid = Grid.create! words: [{hello: true},{goodbye: true}]
    @decorated = @grid.decorated_grids.create!
  end

  test "is successful" do
    get "/grid"

    assert_response :success
  end

  test "index should supply random decorated grid by default" do
    get "/grid"

    assert_equal @decorated.as_json, json_response
  end

  test "show should return specified grid" do
    other_grid = Grid.create! words: [{hello: true}]
    decorated  = other_grid.decorated_grids.create!

    get "/grid/", params: {id: decorated.id}

    puts json_response

    assert_equal decorated.as_json, json_response
  end
end
