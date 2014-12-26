require_relative 'hand'

class Player

	def self.buy_in(bankroll)
		Player.new(bankroll)
	end
	
	attr_accessor :hand, :bankroll


	def initialize(bankroll)
		@bankroll = bankroll
	end

	def deal_in(hand)
		@hand = hand
	end

	def show_hand
		@hand.cards.each_with_index {|card, i| print "#{i}=>#{card}  "}
		print "\n"
	end

	def to_s
		"Player"
	end

	def respond_bet
		input = nil
		until ['C', 'B', 'F'].include? input
			puts "Would like to (C)all, (B)et, or (F)old?"
			input = gets.chomp.upcase
		end

		case input
		when 'C' then :call
		when 'B' then :bet
		when 'F' then :fold
		end
	end

	def get_bet
		input = nil
		while input.nil? || input > @bankroll
			puts "You have $#{@bankroll}"
			puts "How much do you want to bet?"
			input = gets.chomp.to_i
		end

		input
	end

	def get_cards_to_trade
		input = nil
		until input.is_a?(Array) && input.all? {|n| n.between?(0,4)}
			puts "Which cards would you like to discard?"
			puts "(seperate each position with a space)"
			input = gets.chomp.scan(/\d/).map(&:to_i)
		end

		chosen = input.map{ |i| hand[i] }
		# @hand.discard(chosen)
		# chosen.length #return the number discarded
	end

	def take_bet(amount)
		raise "not enough money" unless amount <= bankroll
		@bankroll -= amount
		amount
	end

	def receive_winnings(amount)
		@bankroll += amount
	end

	def return_cards
		@cards = hand.cards
		@hand = nil
		@cards
	end

	def fold
		@folded = true
	end

	def unfold
		@folded = false
	end

	def folded?
		@bankroll.zero? || @folded
	end

	def trade_cards(old_cards, new_cards)
		@hand.trade_cards(old_cards,new_cards)
	end

	def <=>(other_player)
		@hand <=> other_player.hand
	end

end
