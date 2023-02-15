import glob
import numpy as np
import tensorflow as tf

def parse(serialized):
    # Define a dict with the data-names and types we expect to find in the TFRecords file.
    features = \
        {
            'ecg'  : tf.FixedLenFeature([3750,], tf.float32),
            'ppg'  : tf.FixedLenFeature([3750,], tf.float32),
            'systolic': tf.FixedLenFeature([1,], tf.int64),
            'diastolic': tf.FixedLenFeature([1,], tf.int64),
            'annotation': tf.FixedLenFeature([4,], tf.int64)
        }
    
    # Parse the serialized data so we get a dict with our data.
    parsed = tf.parse_single_example(serialized=serialized, features=features)  
    
    return parsed['ecg'], parsed['ppg'], parsed['systolic'], parsed['diastolic'], parsed['annotation']

def input_fn(filenames, batch_size=64, buffer_size=2048):
    # Args:
    # filenames:   Filenames for the TFRecords files.
    # batch_size:  Return batches of this size.
    # buffer_size: Read buffers of this size. The random shuffling is done on the buffer, so it must be big enough.

    # Create a TensorFlow Dataset-object which has functionality for reading and shuffling data from TFRecords files.
    dataset = tf.data.TFRecordDataset(filenames=filenames)

    # Parse the serialized data in the TFRecords files.
    # This returns TensorFlow tensors.
    dataset = dataset.map(parse)
    dataset = dataset.shuffle(buffer_size)
    dataset = dataset.batch(batch_size)

    # Create an iterator for the dataset and the above modifications.
    iterator = dataset.make_initializable_iterator()
    
    # Get the next batch of images and labels.
    return iterator

def get_tflist(path, foldername, subjects):
    test_filenames = []

    for sid in subjects:
        test_filenames.extend(glob.glob(path + foldername + "s" + str(sid) + "*" + ".tfrecords"))

    np.random.shuffle(test_filenames)
    
    return test_filenames