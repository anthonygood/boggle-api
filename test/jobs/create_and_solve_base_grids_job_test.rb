require 'test_helper'

class CreateAndSolveBaseGridsJobTest < ActiveJob::TestCase
  setup do
    # Avoid loading trie.
    Boggle::Solver.stub :find_words!, [[{hello: true}],[{goodbye: true}]] do
      CreateAndSolveBaseGridsJob.perform_now 1
    end
  end

  test "it creates X grids" do
    assert_equal 1, Grid.count
  end

  test "it solves X grids" do
    assert_equal 2, Grid.last.words.count
  end
end
