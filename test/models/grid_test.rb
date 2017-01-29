require 'test_helper'

class GridTest < ActiveSupport::TestCase
  test "has letters array attribute" do
    grid = Grid.new
    assert grid.letters == []
  end

  test "it saves to the database" do
    grid = Grid.new

    assert grid.save
    assert Grid.count == 1
  end
end
