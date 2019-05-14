import numpy as np
import seaborn as sns
import pymc3 as pm
import pandas as pd
import scipy as sp
import matplotlib.pyplot as plt
import click

@click.command()
@click.option('--current', '-c', help='current file')
@click.option('--output','-o', default='./', help='outputs')
@click.option('--window','-w', help='window size')

def event_dect(current, window, output):
    window = int(window)
    def switch_test(current, sample_num=1000):
        with pm.Model() as switch_point:
            #sps = pm.Poisson('points', 0)
            #ragnes = np.random.randint(years.min(),years.max(), sps)
            current_data = current[0]
            time = current[1]
            switchpoint = pm.DiscreteUniform('switchpoint', lower=time.min(), upper=time.max())

            # Priors for pre- and post-switch rates number of disasters
            early_rate = pm.Normal('early_rate', mu=0, sd=1000)
            late_rate = pm.Normal('late_rate', mu=0, sd=1000)

            # Allocate appropriate Poisson rates to years before and after current
            rate = pm.math.switch(switchpoint >= time, early_rate, late_rate)

            switch_points = pm.Normal('current', mu=rate, sd=70, observed=current_data)
            
            trace = pm.sample(sample_num) if sample_num < 5000 else pm.sample(5000)
                
        return [trace['switchpoint'].mean(), trace['switchpoint'].std(),
                trace['early_rate'].mean(), trace['early_rate'].std(),
                trace['late_rate'].mean(), trace['late_rate'].std()]
    ts = pd.read_table(current, names=['current'])
    tr = ts.rolling(window=100, center=True, min_periods=1)
    tss = tr.mean()[::10]
    cut_r = [[tss[i:i+2*window].values.T, np.array(tss[i:i+2*window].index)] for i in range(0, len(tss), window)]
    test_r = [switch_test(i) for i in cut_r]
    result = pd.DataFrame()
    for i in test_r:
        tmp = pd.DataFrame(dict(zip(['sp_m', 'sp_sd', 'er_m', 'er_sd', 'lr_m', 'lr_sd'],[[t] for t in i])))
        result = result.append(tmp, ignore_index=True)
    result.to_csv(output, index=False, sep='\t')

if __name__ == '__main__':
    event_dect()
    

