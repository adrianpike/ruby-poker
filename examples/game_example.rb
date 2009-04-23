#require 'rubygems'
#require 'adrianpike-ruby-poker'

require 'game.rb'

g = TexasHoldEm.new
g.new_player('Adrian Pike')
g.new_player('Amiel Martin')
g.start
p 'Adrians hand: '+g.hand('Adrian Pike').to_s
p 'Amiels hand: '+g.hand('Amiel Martin').to_s

g.bet('Adrian Pike',50)
g.bet('Amiel Martin',50)

g.bet('Adrian Pike',1)
g.bet('Amiel Martin',70)
g.bet('Adrian Pike',70)

g.bet('Adrian Pike',50)
g.fold('Amiel Martin')
#g.bet('Amiel Martin',50)

#g.bet('Adrian Pike',50)
#g.bet('Amiel Martin',50)
