# frozen_string_literal: true

module CrazyDogGame
  # Card class allows to verify consistency with adjacent cards
  class Card
    # @param grid [CrazyDogGame::Grid]
    # @param card [Array]
    # @param index [Integer]
    def initialize(grid, card, index)
      @grid  = grid
      @card  = card
      @index = index
    end

    # @returns [TrueClass, FalseClass]
    def valid?
      bottom_side_result.zero? && right_side_result.zero?
    end

    # @returns [Integer]
    def grid_size
      @grid.size
    end

    # @returns [Array]
    def mapped_permutation
      @grid.mapped_permutation
    end

    private

    def right_side_result
      right_value = @card[2]
      card_index  = @index + 1

      card_result =
        if ((card_index) % grid_size).zero?
          right_value * -1
        else
          mapped_permutation[card_index][0]
        end

      card_result + right_value
    end

    def bottom_side_result
      bottom_value = @card[3]

      card_result =
        if @index >= (@grid.cards.count - grid_size)
          bottom_value * -1
        else
          mapped_permutation[@index + grid_size][1]
        end

      card_result + bottom_value
    end
  end
end
