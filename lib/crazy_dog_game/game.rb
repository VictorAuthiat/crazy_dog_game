# frozen_string_literal: true

module CrazyDogGame
  # Game can be created started or finished and return valid grids
  class Game
    attr_reader :valid_grids

    # @example
    #   cards = [[1, 2, 3, 4], ...]
    #   CrazyDogGame::Game.new(cards)
    #
    # @todo:
    #   - Remove state.
    #   - Add an Obsever class to register game duration
    #
    # @param cards [Array]
    def initialize(cards)
      @cards       = CrazyDogGame::Utils.order(cards)
      @state       = :created
      @valid_grids = []
    end

    # Fetch valid grids and finish the game
    #
    # @return [Symbol]
    def start
      fetch_valid_grids

      @state = :finished
    end

    private

    def fetch_valid_grids
      permutations = build_permutations

      permutations.each_with_index do |permutation, index|
        # @cards.count!/4 -> for 9, there will be 90 720 permutations
        break if index == permutations.count / 4

        grid = CrazyDogGame::Grid.new(@cards, permutation)
        @valid_grids << grid.mapped_permutation if grid.valid?
      end
    end

    # @cards.count! -> for 9, there will be 362 880 permutations
    def build_permutations
      (1..@cards.count).to_a.permutation.to_a
    end
  end
end
