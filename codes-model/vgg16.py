import inspect
import os

import numpy as np
import tensorflow as tf

class VGG16:
    
    def __init__(self, signal_length, num_inputs, num_outputs, learning_rate):
        # Placeholders for input, output and dropout
        self.input_x = tf.placeholder(tf.float32, [None, signal_length, num_inputs], name="input_x")
        self.input_y = tf.placeholder(tf.float32, [None, num_outputs], name="input_y")
        self.dropout_keep_prob = tf.placeholder(tf.float32, name="dropout_keep_prob")
        
        self.num_outputs = num_outputs
        self.learning_rate = learning_rate
        
    def build(self):
        self.conv1_1 = self.conv_layer(self.input_x, 64, "conv1_1")
        self.conv1_2 = self.conv_layer(self.conv1_1, 64, "conv1_2")
        self.pool1 = self.max_pool(self.conv1_2, 'pool1')
        print(self.pool1)

        self.conv2_1 = self.conv_layer(self.pool1, 128, "conv2_1")
        self.conv2_2 = self.conv_layer(self.conv2_1, 128, "conv2_2")
        self.pool2 = self.max_pool(self.conv2_2, 'pool2')
        print(self.pool2)

        self.conv3_1 = self.conv_layer(self.pool2, 256, "conv3_1")
        self.conv3_2 = self.conv_layer(self.conv3_1, 256, "conv3_2")
        self.conv3_3 = self.conv_layer(self.conv3_2, 256, "conv3_3")
        self.pool3 = self.max_pool(self.conv3_3, 'pool3')
        print(self.pool3)

        self.conv4_1 = self.conv_layer(self.pool3, 512, "conv4_1")
        self.conv4_2 = self.conv_layer(self.conv4_1, 512, "conv4_2")
        self.conv4_3 = self.conv_layer(self.conv4_2, 512, "conv4_3")
        self.pool4 = self.max_pool(self.conv4_3, 'pool4')
        print(self.pool4)

        self.conv5_1 = self.conv_layer(self.pool4, 512, "conv5_1")
        self.conv5_2 = self.conv_layer(self.conv5_1, 512, "conv5_2")
        self.conv5_3 = self.conv_layer(self.conv5_2, 512, "conv5_3")
        self.pool5 = self.max_pool(self.conv5_3, 'pool5')
        self.pool5 = tf.contrib.layers.flatten(self.pool5)
        print(self.pool5)
        
        self.fc6 = tf.layers.dense(self.pool5, 4096, activation=tf.nn.relu, name="fc6")
        self.drop6 = tf.nn.dropout(self.fc6, self.dropout_keep_prob)
        print(self.drop6)

        self.fc7 = tf.layers.dense(self.drop6, 4096, activation=tf.nn.relu, name="fc7")
        self.drop7 = tf.nn.dropout(self.fc7, self.dropout_keep_prob)
        print(self.drop7)

        self.predictions = tf.layers.dense(self.drop7, self.num_outputs, name="fc8")
        print(self.predictions)
        
#         self.cost = tf.reduce_mean(tf.abs(tf.subtract(self.predictions, self.input_y) ) ) 
        self.cost = tf.reduce_mean(tf.abs(tf.subtract(self.predictions, self.input_y) ) )
        self.optimizer = tf.train.AdamOptimizer(learning_rate=self.learning_rate, epsilon=1).minimize(self.cost)

    def avg_pool(self, bottom, name):
        return tf.layers.average_pooling1d(inputs=bottom, pool_size=2, strides=2, padding='SAME', name=name)

    def max_pool(self, bottom, name):
        return tf.layers.max_pooling1d(inputs=bottom, pool_size=3, strides=3, padding='SAME', name=name)

    def conv_layer(self, bottom, filters, name):
        with tf.variable_scope(name):
            relu = tf.nn.relu(
                tf.layers.batch_normalization(
                    tf.layers.conv1d (
                        inputs=bottom, 
                        filters=filters, 
                        kernel_size=3, 
                        padding='SAME', 
                        name=name
                    )
                )
            )
        return relu