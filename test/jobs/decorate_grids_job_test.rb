require 'test_helper'

class DecorateGridsJobTest < ActiveJob::TestCase

  setup do
    # Avoid solving grid
    @grid = Grid.create(words: [{hello: true},{goodbye: true}])

    DecorateGridsJob.perform_now
  end

  test "it decorates grids" do
    assert_equal 1, @grid.decorated_grids.count
  end

  test "it won't plain-decorate (without multipliers) twice" do

    DecorateGridsJob.perform_now

    assert_equal 1, @grid.decorated_grids.count
  end

  test "it applies multipliers" do
    multipliers = [{acts_upon: :word, value: 9}]

    DecorateGridsJob.perform_now multipliers

    new_grid    = @grid.decorated_grids.second
    multipliers = new_grid.multipliers

    assert_equal 2, @grid.decorated_grids.count
    assert_equal 1, multipliers.count

    assert_equal :word, multipliers.first.acts_upon
    assert_equal 9, multipliers.first.value
  end
end
