
## < codes-preprocessing >

- runme.m: Place the downloaded Record folder (037 ~ 485) in the same place as the code for execution.

- dat2mat(i): Executing this file converts .dat files into .mat files, a MATLAB-based data format.

- merge_signal(i): It integrates the signal data of several separate record files into one.

- feature_extractor(i): Proceed with feature extraction through this code. Data is extracted in beat units from Waveform, and Systolic/Diastolic BP values corresponding to the beat are extracted as label information. Save the extracted beat data and label information in an array and save it as a file.

- noise_remove_ch2(i): Remove noise from data. Remove signals stored as NaN values, meaningless signals recorded entirely as 0, and outlier data that deviate from Sigma, and save the result as a file.

## < codes-model >

- tfrecord-builder.ipynb : Loads the preprocessed .mat file and converts the data into .tfrecord format for use as input data for Tensorflow.

- train.ipynb : Code to train a CNN-based model using the Tensorflow framework. Continue learning in the "Train" section. If you specify the folder name where .tfrecord is stored in the foldername variable, learning will proceed automatically.

- vgg16.py: Model code that transforms VGG-based CNN model to fit 1-Dimension data.

- tfparser.py : This is the code that stores the function that parses tfrecord files.

- datahelper.py : This is the code where various data processing functions are stored. Codes for saving training/test results, data normalization functions, etc. are stored.



