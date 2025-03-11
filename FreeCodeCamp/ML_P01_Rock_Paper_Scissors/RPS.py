# The example function below keeps track of the opponent's history and plays whatever the opponent played two plays ago.
# It is not a very good player so you will need to change the code to pass the challenge.

import itertools as it
import numpy as np
import random
import tensorflow as tf

from tensorflow.keras import layers

from LSTM import LSTM

def player(prev_play, opponent_history=[], player_history=[], ml=[[None]]):
    random_matches = 300

    if not prev_play:
        #print('\n\n\nfirst play')
        opponent_history.clear()
        player_history.clear()
        ml[0] = None
        #print(opponent_history, player_history, ml, '\n\n')

    else:
        opponent_history.append(prev_play)

    if len(opponent_history) < random_matches: #
        guess = random.choice(['R', 'P', 'S'])
        player_history.append(guess)
        return guess

    if len(opponent_history) == random_matches: #
        #print("\n\ncreating model")
        ml[0] = LSTM()
        model = ml[0].create_and_train_model(''.join(opponent_history) + ''.join(player_history))

    #prints the results each 10 plays
    if len(opponent_history) % 10 == 0:
        win_loss_tie = {'RR': 't',
                        'RP': 'l',
                        'RS': 'w',
                        'PR': 'w',
                        'PP': 't',
                        'PS': 'l',
                        'SR': 'l',
                        'SP': 'w',
                        'SS': 't'
                        }
        l = len(opponent_history)
        res = []
        for i in range(10):
            res.append(win_loss_tie[player_history[l - 10 + i] + opponent_history[l - 10 + i]])
            if res.count('w'):
                w1 = round(res.count('w') / 10, 2)
                w2 = round(res.count('w') / (res.count('w') + res.count('l')), 2)
            else:
                w1 = 0
                w2 = 0
        #print(f'runs {l - 10} to {l}: {w1}, {w2}, {res}')
        if w2 < 0.6 and len(opponent_history) != random_matches:
            #print("\n\ncreating model")
            ml[0] = LSTM()
            model = ml[0].create_and_train_model(''.join(opponent_history) + ''.join(player_history))

    prediction = ml[0].predict(''.join(opponent_history) + ''.join(player_history))

    counter = {'R': 'P', 'P': 'S', 'S': 'R'}
    guess = counter[prediction[0]]

    player_history.append(guess)
    return guess


'''
def player(prev_play, opponent_history=[]):
    opponent_history.append(prev_play)

    guess = "R"
    if len(opponent_history) > 2:
        guess = opponent_history[-2]

    return guess
'''