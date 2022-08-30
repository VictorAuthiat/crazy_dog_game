# frozen_string_literal: true

module CrazyDogGame
  # Don't know where to put this ^^'
  # @todo: move these methods to appropriate places
  module Utils
    class << self
      # Avoid multiplying n! by i^n
      #
      # @param cards [Array]
      # @return [Array]
      def order(cards)
        cards.map { |card| ordered_card(card) }
      end

      # Shuffle cards before testing
      #
      # @param cards [Array]
      # @return [Array]
      def shuffle(cards)
        cards.map { |card| rand_order(card) }
      end

      private

      def ordered_card(card)
        card.each_with_index.map do |_, card_index|
          card[start_index(card) - card_index]
        end
      end

      def rand_order(card)
        rand_index = rand(0..(card.count - 1))

        card.each_with_index.map { |_, card_index| card[rand_index - card_index] }
      end

      def start_index(card)
        values = card.each_with_index.map do |value, index|
          index if value.negative? && card[index - 1].negative?
        end

        values.compact.first
      end
    end
  end
end
