require 'rubygems'
require 'ruby-poker'


g = TexasHoldEm.new
g.new_player('Adrian Pike')
g.new_player('Amiel Martin')
g.new_player('Nathan Carnes')
p "START"
g.start
p "STARTING"

p 'Adrians hand: '+g.hand('Adrian Pike').to_s
p 'Amiels hand: '+g.hand('Amiel Martin').to_s

# round one, should be simple as pie
g.bet('Adrian Pike',50)
g.bet('Amiel Martin',50)
g.fold('Nathan Carnes')

# round two, slightly more complicated
g.bet('Adrian Pike',1)
g.bet('Amiel Martin',70)
g.bet('Nathan Carnes',12)
g.bet('Adrian Pike',70)
g.bet('Amiel Martin',1)

# round three, simple
g.bet('Adrian Pike',50)
g.fold('Amiel Martin')




 # test #2
g = TexasHoldEm.new
g.new_player('Adrian Pike')
g.start

# round one, should be simple as pie
g.bet('Adrian Pike',50)
g.bet('Adrian Pike',50)
g.bet('Adrian Pike',50)
g.bet('Adrian Pike',50)