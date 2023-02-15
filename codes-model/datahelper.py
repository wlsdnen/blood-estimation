import h5py
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def save_txt(error, data, name):
    filename = "%s_%s.txt" % (error, name)
    np.savetxt(filename, data, delimiter=',')
    print("saved", filename)

def export_result(labels, predictions, annotations):
    mae1 = "%.2f" % (np.mean(np.abs(labels[:,0] - predictions[:,0])))
    mae2 = "%.2f" % (np.mean(np.abs(labels[:,1] - predictions[:,1])))
    err_name = mae1 + "_" + mae2
    
    save_txt(err_name, labels, "y")
    save_txt(err_name, predictions, "p")
    save_txt(err_name, annotations, "i")
    
def load_subjects(path, txtname):
    filename = path + txtname
    subjects = np.loadtxt(filename, delimiter=',', dtype=np.int16)
    np.random.shuffle(subjects)
    return subjects

def min_max_scaler(data):
    return (data - np.min(data)) / (np.max(data) - np.min(data) + 1e-8)

def draw_result(data):    
    plt.figure(figsize=(15,10))
    plt.plot(data)
    plt.show()

def load_result(filename):
    y = np.loadtxt(filename+'_y.txt',delimiter=',',dtype=np.float64)    
    p = np.loadtxt(filename+'_p.txt',delimiter=',',dtype=np.float64)
    i = np.loadtxt(filename+'_i.txt',delimiter=',',dtype=int)
    return y, p, i

def merge_results(filenames):
    y = np.array([])
    p = np.array([])
    a = np.array([])
    for filename in filenames:
        _y, _p, _a = load_result(filename[:-6])
        y = np.concatenate((y, _y), axis=0) if y.size else _y
        p = np.concatenate((p, _p), axis=0) if p.size else _p
        a = np.concatenate((a, _a), axis=0) if a.size else _a
    return y,p,a


def load_signal(rid, path):
    f1 = h5py.File(path.replace("*", str(rid)), 'r')
    e = f1['ECG'].value.T
    p = f1['PPG'].value.T
    b = f1['ABP'].value.T
    return e, p, b


def get_map (SBP, DBP):
    return (SBP + 2*DBP) / 3

def get_pp (SBP, DBP):
    return SBP - DBP


def print_progress(error, count, total):
    # Percentage completion.
    pct_complete = float(count) / total

    # Status-message.
    # Note the \r which means the line should overwrite itself.
    msg = "\r- Progress: {0:.1%}, error: {1:.2f}".format(pct_complete, error)

    # Print it.
    sys.stdout.write(msg)
    sys.stdout.flush()
    