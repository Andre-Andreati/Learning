# The example function below keeps track of the opponent's history and plays whatever the opponent played two plays ago.
# It is not a very good player so you will need to change the code to pass the challenge.

import numpy as np
import random
import tensorflow as tf

from tensorflow.keras import layers

def create_and_train_model(opponent_hist, player_hist, length):

    print('\n\ntraining:\n', opponent_hist, '\n', player_hist, '\n\n')

    vocab = sorted(set(['R', 'P', 'S']))
    # Creating a mapping from unique characters to indices
    char2idx = {u:i for i, u in enumerate(vocab)}
    idx2char = np.array(vocab)

    def text_to_int(text):
        return [char2idx[c] for c in text]

    def int_to_text(ints):
        return ''.join(idx2char[ints])

    next_data = []
    data = []

    for i in range(len(opponent_hist) - length): #list with next play
        next_data.append(opponent_hist[length + i])

    for i in range(len(opponent_hist) - length): #list with previous 'length' plays
        data.append(opponent_hist[i : length + i] + player_hist[i : length + i])

    encoded_data = np.array([text_to_int(d) for d in data])
    encoded_next = np.array([text_to_int(d)[0] for d in next_data])

    features_onehot = np.array([tf.keras.utils.to_categorical(feature, num_classes=len(vocab)) for feature in encoded_data])
    labels_onehot = tf.keras.utils.to_categorical(encoded_next, num_classes=len(vocab))

    model = tf.keras.Sequential([
        layers.LSTM(128, input_shape=(features_onehot.shape[1], features_onehot.shape[2])),
        layers.Dense(127, activation='relu'),
        layers.Dense(3, activation='softmax')
    ])

    model.compile(loss='CategoricalCrossentropy',
                optimizer='adam',
                metrics=['Accuracy'])

    history = model.fit(
        features_onehot,
        labels_onehot,
        epochs=100)
    
    return model


def predict(model, opponent, player):
    vocab = sorted(set(['R', 'P', 'S']))
    # Creating a mapping from unique characters to indices
    char2idx = {u:i for i, u in enumerate(vocab)}
    idx2char = np.array(vocab)

    def text_to_int(text):
        return [char2idx[c] for c in text]

    def int_to_text(ints):
        return ''.join(idx2char[ints])
    
    # input: opponent and player histories
    # output: predicted output and it's probability
    m = min(len(opponent), len(player)) #if the inputs have different lengths, 'm' is the smaller length,
    seq = opponent[-m :] + player[-m :] #only use the last 'm' plays of each player
    seq_encoded = np.array([text_to_int(seq)]) #encode sequence of chars into sequence of ints
    seq_onehot = np.array([tf.keras.utils.to_categorical(se, num_classes=len(vocab)) for se in seq_encoded])
        #encode sequence of ints into sequence of one-hots
    pred = model.predict(seq_onehot, verbose=False) #run the prediction. Return list of probabilities for next char
    idx = np.argmax(pred) #idx of the char with max probability, equal to the integer encoding for the chars
    return int_to_text(idx), round(float(pred[0][idx]), 2) #predicted char, probability



def player(prev_play, opponent_history=[[None]], player_history=[[None]], model=[[None]]):
    random_matches = 100
    length = 20

    if not prev_play:
        print('\n\n\nfirst play')
        opponent_history[0] = []
        player_history[0] = []
        model[0] = None
        print(opponent_history, player_history, model, '\n\n')

    else:
        opponent_history[0].append(prev_play)

    #prints the results each 10 plays
    if prev_play and len(opponent_history[0]) % 10 == 0:
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
        l = len(opponent_history[0])
        res = []
        for i in range(10):
            res.append(win_loss_tie[player_history[0][l - 10 + i] + opponent_history[0][l - 10 + i]])
            if res.count('w'):
                w1 = round(res.count('w') / 10, 2)
                w2 = round(res.count('w') / (res.count('w') + res.count('l')), 2)
            else:
                w1 = 0
                w2 = 0
        print(f'runs {l - 10} to {l}: {w1}, {w2}, {res}')
        #print(opponent_history[0][-10:])
        #print(player_history[0][-10:])

    
    #print('entered player', '\n', ''.join(opponent_history), '\n', ''.join(player_history))

    if len(opponent_history[0]) < random_matches:# or len(opponent_history[0]) % 5 == 0:
        guess = random.choice(['R', 'P', 'S'])
        player_history[0].append(guess)
        return guess

    if len(opponent_history[0]) == random_matches:
        print("\n\ncreating model")
        print(opponent_history, player_history, model, '\n')
        model[0] = create_and_train_model(''.join(opponent_history[0]), ''.join(player_history[0]), length)

    '''if len(opponent_history[0]) % 2 == 0:
        guess = random.choice(['R', 'P', 'S'])
        player_history[0].append(guess)
        return guess'''

    prediction = predict(model[0], ''.join(opponent_history[0])[-length :], ''.join(player_history[0])[-length :])

    counter = {'R': 'P', 'P': 'S', 'S': 'R'}
    guess = counter[prediction[0]]

    player_history[0].append(guess)
    return guess


'''
def player(prev_play, opponent_history=[]):
    opponent_history.append(prev_play)

    guess = "R"
    if len(opponent_history) > 2:
        guess = opponent_history[-2]

    return guess
'''