# frozen_string_literal: true

require_relative "crazy_dog_game/utils"

# CrazyDogGame is a very har puzzle with billions of possibilities..
module CrazyDogGame
  autoload :Card, './lib/crazy_dog_game/card'
  autoload :Grid, './lib/crazy_dog_game/grid'
  autoload :Game, './lib/crazy_dog_game/game'

  # Default card set directly from the crazy dog game
  # Please note that the cards are already ordered
  DEFAULT_CARDS = [
    [-1, -4, 2, 3], [-2, -4, 2, 3], [-2, -3, 4, 1],
    [-1, -3, 2, 4], [-1, -3, 1, 4], [-2, -1, 3, 4],
    [-1, -2, 4, 3], [-2, -4, 1, 3], [-2, -4, 1, 3]
  ].freeze

  class << self
    # Run basic example
    #
    # @param cards [Array]
    # @return [Array]
    def run_example(cards: DEFAULT_CARDS)
      cards = CrazyDogGame::Utils.shuffle(cards)
      game  = CrazyDogGame::Game.new(cards)

      game.start
      game.valid_grids
    end

    # Number of different possibilities for a grid
    #
    # @note (n! * i^n) / i
    # @param grid_size [Integer]
    # @return [Integer]
    def possibilities_count(grid_size:)
      sides_count                 = 4
      cards_count                 = grid_size.pow(2)
      fact_cards_count            = (1..(cards_count)).inject(:*)
      sides_count_pow_cards_count = sides_count.pow(cards_count)

      (fact_cards_count * sides_count_pow_cards_count) / sides_count
    end

    # Number of operations required to check a grid
    #
    # @note 2(n - 1)n
    # @param grid_size [Integer]
    # @return [Integer]
    def required_operations_count(grid_size:)
      2 * (grid_size - 1) * grid_size
    end
  end
end
