class DecorateGridsJob < ApplicationJob
  queue_as :default

  # By default, no multipliers (beyond 1) are applied.
  # Pass an array of multipliers like so:
  # DecorateGridsJob.perform_later [{acts_upon: :word, value: 3},{acts_upon: :letter, value: 5}]
  def perform(multipliers=[])
    # Do something later
    Grid.each do |grid|

      # We don't want to plain-decorate (ie. decorate without any multipliers) more than once,
      # since all plainly decorated grids will be alike. Therefore, avoid duplicate plain-decoration.
      unless multipliers.empty? && plainly_decorated?(grid)
        decorated_grid = grid.decorated_grids.create!
      end

      if multipliers.any?
        # Do something.
        multipliers.each {|multiplier| apply multiplier, decorated_grid }
      end
    end
  end

  def apply(multiplier, grid)
    acts_upon = multiplier[:acts_upon]
    value     = multiplier[:value]

    raise "Invalid multiplier" unless acts_upon && value

    grid.multipliers.create! acts_upon: acts_upon, value: value
  end

  private

  def plainly_decorated?(grid)
    grid.decorated_grids.where(multipliers: nil).exists?
  end
end
