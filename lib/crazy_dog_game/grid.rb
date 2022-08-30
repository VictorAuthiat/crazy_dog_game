# frozen_string_literal: true

module CrazyDogGame
  # Grid allows to verify cards permutation
  class Grid
    attr_reader :size, :cards

    # @param cards [Array]
    # @param permutation [Array]
    def initialize(cards, permutation)
      @cards       = cards
      @permutation = permutation
      @size        = Math.sqrt(@cards.count).to_i
    end

    # @return [TrueClass, FalseClass]
    def valid?
      mapped_permutation.each_with_index.all? do |card, card_index|
        CrazyDogGame::Card.new(self, card, card_index).valid?
      end
    end

    # Transforms given permutation by real cards
    #
    # @return [Array]
    def mapped_permutation
      @_mapped_permutation ||= @permutation.map do |permutation_index|
        @cards[permutation_index - 1]
      end
    end
  end
end
