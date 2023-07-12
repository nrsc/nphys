import numpy as np
import pyabf
import matplotlib as mplt
import matplotlib.pyplot as plt
import pandas as pd


def getVoltages(abf):
    voltages = []
for sweep in abf.sweepList:
    abf.setSweep(sweep, channel=0)
voltages.append(abf.sweepEpochs)
return [voltages]

# def getTime(abf):
#   time = []
#   for sweep in abf.sweepList:
#     abf.setSweep(sweep, channel=0)
#     time.append(abf.)


#currents.append(abf.sweepY)
#abf.setSweep(sweep, channel=0)
#t = getABF(r.file)
#currents = []
