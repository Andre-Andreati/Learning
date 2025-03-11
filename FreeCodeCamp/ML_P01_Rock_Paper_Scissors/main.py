# This entrypoint file to be used in development. Start by reading README.md
from RPS_game import play, mrugesh, abbey, quincy, kris, human, random_player
from RPS import player
from unittest import main

#play(player, quincy, 1000) #fixed sequence
#play(player, abbey, 1000) #most common opponent 2-seq play
#play(player, kris, 1000) #last opponent play
#play(player, mrugesh, 1000) #last 10 opponent plays (most common play)

# Uncomment line below to play interactively against a bot:
# play(human, abbey, 20, verbose=True)

# Uncomment line below to play against a bot that plays randomly:
# play(human, random_player, 1000)



# Uncomment line below to run unit tests automatically
main(module='test_module', exit=False)