import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker

df = pd.read_excel('bbg_global_liquidity.xlsx', sheet_name='Sheet1')


date_range = pd.date_range(start='2015-01-01', end='2026-02-01', freq='D')
result = pd.DataFrame({'date_range': date_range})

all_columns = df.columns.tolist()
indicator_cols = all_columns[1::2]

print(indicator_cols)

for i, indicator in enumerate(indicator_cols, 1):
    date_col = all_columns[(i - 1) * 2]

    data = df[[date_col, indicator]].copy()
    data.columns = ['date', indicator]
    data = data.dropna()
    data['date'] = pd.to_datetime(data['date'])
    data = data.drop_duplicates('date', keep='last').set_index('date')

    result = result.merge(
        data,
        left_on='date_range',
        right_index=True,
        how='left'
    )

result = result.ffill()
result = result.set_index('date_range')
result = result.loc['2019-12-30':]
result.to_excel('calculate_liquidity.xlsx', index=True)

sr_EUR = result['ECMSM2 Index']*1000000*result['EUR BGN Curncy']
sr_CNM = result['CNMSM2 Index']*1000000000/result['CNY REGN Curncy']
sr_M2NS = result['M2NS Index']*1000000000
sr_JMN = result['JMNSM2 Index']*1000000000000/result['JPY BGN Curncy']
sr_KOM = result['KOMSM2 Index']*1000000000/result['KRW REGN Curncy']
sr_MSC = result['MSCAM2 Index']*100000/result['CAD BGN Curncy']
sr_TW = result['TWMSM2 Index']*1000000000/result['TWD REGN Curncy']
sr_BZ = result['BZMS2 Index']*1000000000/result['BRL REGN Curncy']
sr_SZ = result['SZMSM2 Index']*1000000/result['CHF BGN Curncy']
sr_AU = result['AUM3 Index']*1000000000*result['AUD BGN Curncy']
sr_MX = result['MXMSM2 Index']*1000000000/result['MXN BGN Curncy']
sr_RU = result['RUMSM2 Index']*1000000000*result['RUBUSD BGN Curncy']
sr_ECO = result['ECORUKN Index']*1000000000

sr_country = sr_EUR + sr_CNM + sr_M2NS + sr_JMN + sr_KOM + sr_MSC + sr_TW + sr_BZ + sr_SZ + sr_AU + sr_MX + sr_RU + sr_ECO

sr_FAR = result['FARBAST Index']
sr_B11 = result['B111B56A Index']*result['GBP BFIX Curncy']
sr_BOC = result['BOC2LICA Index']/result['CAD BFIX Curncy']

sr_EBB = result['EBBSTOTA Index']*result['EUR BGN Curncy']
sr_BJA = result['BJACTOTL Index']/result['JPY BFIX Curncy']
sr_CNB = result['CNBMTTAS Index']/result['CNH BGN Curncy']

sr_CentralBank = ( sr_FAR + sr_B11 + sr_BOC )/( 1000 + sr_EBB + sr_BJA + sr_CNB )

sr_global_liquidity = ( sr_country + sr_CentralBank )/1000000000000 #trillion dollar

print(sr_global_liquidity)
sr_global_liquidity.to_excel('output_series.xlsx', sheet_name='My_Data')