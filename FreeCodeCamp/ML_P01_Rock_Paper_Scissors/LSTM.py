import itertools as it
import numpy as np
import tensorflow as tf
from tensorflow.keras import layers

class LSTM():
    def __init__(self, num=2, seq_size=range(2,5), matches_range=[5, 10]):
        self.num = num #number of previous matches to analyze
        self.seq_size = seq_size #sequence sizes to test
        self.matches_range = matches_range #number of previous matches to look for moves
        self.length = max(num, max(seq_size), max(matches_range)) + 1 #length of timestep to analize. +1 for the move to predict

        self.vocab_moves = sorted(['R', 'P', 'S'])

        self.vocab_seq = self._get_vocab_seq() #vocab of sequences with 2-5 elements
        self.vocab = self._get_vocab() #full vocabulary

    def _int_encoding(self, text):
        return self.vocab.index(text)

    def _int_decoding(self, ints):
        return self.vocab[ints]
    
    def _text_to_int(self, text):
        return [self._int_encoding(c) for c in text]
    
    def _int_to_text(self, ints):
        return ''.join([self._int_decoding(i) for i in ints])
    
    def _get_vocab_seq(self):
        vocab_seq = {}
        for i in self.seq_size:
            vocab_seq[i] = []
            for seq in it.product(self.vocab_moves, repeat=i):
                vocab_seq[i].append(''.join(seq))
        return vocab_seq
    
    def _get_vocab(self):
        vocab = self.vocab_moves.copy()
        for i in self.seq_size:
            for seq in it.product(self.vocab_moves, repeat=i):
                vocab.append(''.join(seq))
        return vocab

    #function for counting the number of occurences of a substring in a string
    def _count_substring(self, s, sub):
        # Initialize count to zero
        cnt = 0

        # Iterate through the string to check for the substring
        for i in range(len(s) - len(sub) + 1):
            if s[i:i + len(sub)] == sub:  # If substring matches, increment count
                cnt += 1
        return cnt
    
    def get_features(self, seq, encoded=True):

        opponent_hist = seq[: len(seq)//2]
        player_hist = seq[len(seq)//2 :]
        #print('opponent_hist: ', opponent_hist)
        #print('player_hist  : ', player_hist)

        #opponent's and player's last 'i'th move in the last 'num' matches:
        op_last_move = [opponent_hist[-i - 1] for i in range(self.num)] #[op last move, op 2nd last move, ..., op length'th last move]
        pl_last_move = [player_hist[-i - 1] for i in range(self.num)] #[pl last move, pl 2nd last move, ..., pl length'th last move]
        last_move = op_last_move + pl_last_move
        #print('last_move: ', last_move)

        #opponent's and player's most common move:
        op_common_all = max(set(self.vocab_moves), key = lambda x: self._count_substring(opponent_hist, x))
        pl_common_all = max(set(self.vocab_moves), key = lambda x: self._count_substring(player_hist, x))
        common_all = [op_common_all, pl_common_all]
        #print('common_all: ', common_all)

        #opponent's and player's most common move in the last 'matches_range' moves:
        op_common = []
        pl_common = []
        for i in self.matches_range:
            os = opponent_hist[-i :]
            op_common.append(max(set(os), key = lambda x: self._count_substring(os, x)))
            ps = player_hist[-i :]
            pl_common.append(max(set(ps), key = lambda x: self._count_substring(ps, x)))
        common = op_common + pl_common
        #print('common: ', common)

        #opponent's and player's most common sequence of 'seq_size' moves starting with the last 'seq_size'-1 moves
        op_possible_seqs = [opponent_hist[-1] + char for char in self.vocab_moves]
        op_possible_seqs_count = {}
        for seq in op_possible_seqs:
            op_possible_seqs_count[seq] = self._count_substring(opponent_hist, seq)
        op_common_seq_last = max(op_possible_seqs_count, key=op_possible_seqs_count.get)

        pl_possible_seqs = [player_hist[-1] + char for char in self.vocab_moves]
        pl_possible_seqs_count = {}
        for seq in pl_possible_seqs:
            pl_possible_seqs_count[seq] = self._count_substring(player_hist, seq)
        pl_common_seq_last = max(pl_possible_seqs_count, key=pl_possible_seqs_count.get)
        common_seq_last = [op_common_seq_last[-1], pl_common_seq_last[-1]]

        #all features together
        features = last_move + common_all + common + common_seq_last
        if encoded:
            features = [self._int_encoding(f) for f in features]
        return features
    
    def get_features_from_timestep(self, timestep, encoded=True): #timestep is a list of all opponent's and player's moves
        opponent_hist = timestep[: len(timestep)//2 - 1]
        player_hist = timestep[len(timestep)//2 : -1]
        seq = opponent_hist + player_hist
        features = self.get_features(seq, encoded)
        return features
    
    def get_label(self, timestep, encoded=True):
        opponent_hist = timestep[: len(timestep)//2]
        label = opponent_hist[-1]
        if encoded:
            label = self._int_encoding(label)
        return label
    
    def get_timesteps(self, hist):
        op_hist = hist[: len(hist)//2]
        pl_hist = hist[len(hist)//2 :]
        timesteps = []
        for i in range(self.length, len(op_hist) + 1):
            timesteps.append(op_hist[:i] + pl_hist[:i])
        return timesteps
    
    def get_features_list(self, hist, encoded = True):
        timesteps = self.get_timesteps(hist)
        features = []
        for timestep in timesteps:
            features.append(self.get_features_from_timestep(timestep, encoded))
        return np.array(features)
    
    def get_labels_list(self, hist, encoded = True):
        timesteps = self.get_timesteps(hist)
        labels = []
        for timestep in timesteps:
            labels.append(self.get_label(timestep, encoded))
        return np.array(labels)
    
    def create_and_train_model(self, hist):
        features = self.get_features_list(hist)
        labels = self.get_labels_list(hist)
        
        features_onehot = tf.one_hot(features, len(self.vocab))
        labels_onehot = tf.one_hot(labels, len(self.vocab_moves))

        #print('\n\nfeatures.shape: ', features_onehot.shape)
        #print('labels.shape: ', labels_onehot.shape, '\n\n')

        self.model = tf.keras.Sequential([
            layers.LSTM(64, input_shape=(features_onehot.shape[1], features_onehot.shape[2])),
            layers.Dense(64, activation='relu'),
            layers.Dense(labels_onehot.shape[1], activation='softmax')
        ])

        self.model.compile(loss='CategoricalCrossentropy',
                    optimizer='adam',
                    metrics=['Accuracy'])

        history = self.model.fit(
            features_onehot,
            labels_onehot,
            epochs=100)
        
        return self.model
    
    def predict(self, hist):
        features = self.get_features(hist)
        features_onehot = tf.one_hot([features], len(self.vocab))
        pred = self.model.predict(features_onehot, verbose=False)
        idx = np.argmax(pred) #idx of the char with max probability, equal to the integer encoding for the chars
        return self._int_to_text([idx]), round(float(pred[0][idx]), 2) #predicted char, probability