# The example function below keeps track of the opponent's history and plays whatever the opponent played two plays ago.
# It is not a very good player so you will need to change the code to pass the challenge.
######
# This 'player' uses a simple Machine Learning model to predict que opponent's next move.
# First it plays 'random_matches' (= 100) random matches to have a history to learn the opponent's strategy.
# After these random plays, create and train the ML model to predict the opponent's next moves
# The model is re-done every 100 matches, and whenever the last 10 matches win rate is below 60%

import random

from MachLearn import LSTM

def player(prev_play, opponent_history=[], player_history=[], ml=[[None]]):
    random_matches = 100

    if not prev_play:
        opponent_history.clear()
        player_history.clear()
        ml[0] = None

    else:
        opponent_history.append(prev_play)

    if len(opponent_history) < random_matches: #first 'random_matches' played randomly to get history
        guess = random.choice(['R', 'P', 'S'])
        player_history.append(guess)
        return guess

    if len(opponent_history) == random_matches or len(opponent_history) % 100 == 0:
        #create and train model after 'random_matches' matches, then again every 100 matches
        ml[0] = LSTM()
        model = ml[0].create_and_train_model(''.join(opponent_history + player_history))

    #calculate the results each 10 plays
    if len(opponent_history) % 10 == 0:
        win_loss_tie = {
            'RR': 't',
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
                w1 = round(res.count('w') / 10, 2) #win rate
                w2 = round(res.count('w') / (res.count('w') + res.count('l')), 2) #win rate discarding ties
            else: #if no win
                w1 = 0
                w2 = 0
        
        if w2 < 0.6 and len(opponent_history) != random_matches: #if results are bad, train again
            ml[0] = LSTM()
            model = ml[0].create_and_train_model(''.join(opponent_history + player_history))

    prediction = ml[0].predict(''.join(opponent_history + player_history)) #make the prediction

    counter = {'R': 'P', 'P': 'S', 'S': 'R'}
    guess = counter[prediction[0]] #plays the counter to the prediction

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