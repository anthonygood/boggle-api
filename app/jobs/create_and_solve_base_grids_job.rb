class CreateAndSolveBaseGridsJob < ApplicationJob
  queue_as :default

  # This job creates (and solves!) as many base grids as requested.
  # NOTE: it's desirable to subsequently destroy any grids which
  # have too few possibly words (> 250 at least, > 300 ideal).
  def perform(count)
    count.times do
      g = Grid.create!
      g.solve!
    end
  end
end
