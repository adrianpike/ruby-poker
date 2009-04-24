DEBUG=true
ANTE=5

class Player
	attr_accessor :name, :bet, :hand, :folded

	def initialize(name,cash)
		@name=name
		@cash=cash
		@hand = Array.new
	end
	
	def do_bet(amount)
		if amount<=@cash then
			@bet+=amount
			@cash-=amount
			
			true
		else
			false
		end
	end
	
	def win(amount)
		@cash += amount
	end
	
	def fold!; @folded=true;	end
	def folded?; @folded; end
	
	def new_round!; @bet=0; end
	
	def to_s; name; end
	
	def deal(card); hand << card; end
end

class Game
	def initialize(ante_size=ANTE)
		@deck = Deck.new
		@players = Hash.new
		@pot=0
		@started=false
		@play_size=ante_size
		@round=0
		@bet_position=0
		@rounds=[]
	end
	
	def fold(p)
		if is_players_turn?(p) then
			output "#{p} folded."
			@players[p].fold!
			advance_bet_position
		else
			output "#{p}: it's not your turn."	
		end
	end
	
	def bet(p,amount)
		if is_players_turn?(p) then
			if amount>=bet_to_player(p) then
				output "#{p} bets $#{amount}."
				
				if @players[p].do_bet(amount) then
					
					if (bet_to_player(p)<0) then
						output "#{p} raised $#{-bet_to_player(p)}."
					end
						
					@pot+=amount
							
					@play_size = @players[p].bet

					advance_bet_position
				else
					output "#{p}: You can't bet that much. You've only got #{@players[p].cash}"
				end
			else
				output "#{p}: You must bet at least $#{@play_size}."
			end
		else
			output "#{p}: it's not your turn."
		end
	end

	def new_player(p,cash=1000);
		unless @started
			if @players[p] then
				output "#{p}: You're already in a game!"
			else
				@players[p] = Player.new(p,cash); 
			end
		else
			output "We've already started!"
		end
	end

	# Helpers for I/O
	def hand(p); @players[p].hand; end
	
	def start
		unless @started
			deal
			start_round
			@started=true
		else
			output "We've already started!"
		end
	end


	# Stubs for various games
	def deal;end
	def final_hand(p); @players[p].hand; end
	
	# Hooks for external awesomeness
	def output(o);printf o;end
	def hook_end_hand;end
	def started?;@started;end
	
	private
	
	def is_players_turn?(p)
		p==@players.keys[@bet_position]
	end
	
	def bet_to_player(p)
		@play_size - (@players[p].bet || 0)	
	end

	def advance_bet_position
		# step @bet_position forward until we find the next person who hasn't folded who's bet_size is > 0
		# if we loop back then we get to call end_round
		
		if @play_size>0 then
			starting_bet_position = @bet_position
		
			begin
				player = @players[@players.keys[@bet_position]]
				if (not player.folded?) and (bet_to_player(@players.keys[@bet_position]))>0 then
					output "Play is $#{bet_to_player(@players.keys[@bet_position])} to #{@players.keys[@bet_position]}"
					return
				end
		
				@bet_position=((@bet_position+1) % @players.keys.length)
		
			end while starting_bet_position!=@bet_position
		
			end_round
		else
			@bet_position=first_unfolded_player
			output "#{@players.keys[@bet_position]} opens."
		end
	end

	def first_unfolded_player
		0 #TODO
	end
	
	def num_unfolded_players
		@players.values.collect{|p| p.folded? ? 0 : 1 }.inject{|sum,n| sum+n }
	end

	def start_round
		@play_size=0
		@players.each{|name,p|
			p.new_round!
			}
		advance_bet_position
		announce_game_updates
	end
	
	def end_round
		@round+=1
		if @round>=@rounds.size or num_unfolded_players<2 then
			end_hand
		else
			@players.each{|name,p|
				next if p.folded?
				p.new_round!
				}
		
			@bet_position=0
			output "It is now round #{@round} - #{@rounds[@round]}. The pot is $#{@pot}."
			start_round
		end
	end
	
	def end_hand
		hands=Hash.new
		
		@players.each{|name,p|
			next if p.folded?
			hands[name] = PokerHand.new(final_hand(name))
			}
			
		winner = hands.sort{|a,b| b[1]<=>a[1] }.first
		output winner.first+" wins $#{@pot} with a #{winner.last.hand_rating}!"
		@players[winner.first].win(@pot)
		hook_end_hand
	end
end

class TexasHoldEm < Game
	def initialize
		super
		@rounds=['Pre-flop','Flop','Turn','River']
		@river = Array.new
		5.times do;@river << @deck.deal;end
	end
	
	def river
		@river[0..(@round+1)] if @round>0
	end
	
	def deal
		@players.each{|name,p| 2.times { p.deal(@deck.deal) } }
	end
	
	def final_hand(p)
		@players[p].hand + river
	end

	def announce_game_updates
		output "River is now #{river}" if river
	end	
end