import pandas as pd
from datetime import datetime
import statistics


data = pd.read_csv('Dokumenti.csv', delimiter=";", encoding = "ISO-8859-1")

datumi_za_data = []
for row in data['datum']:
    datumi_za_data.append(datetime.date(datetime.strptime(row, '%m/%d/%Y %I:%M:%S %p')))
data.loc[:, 'datum'] = datumi_za_data

weekdays = []
for row in range(len(data)):
    weekdays.append(data['datum'][row].weekday())
data['weekdays'] = weekdays

datumi = {}
for row in data['datum']:
    if row not in datumi:
        datumi[row] = {}
datumi = sorted(datumi)


vrste = {}
for row in data['naziv']:
    if row not in vrste:
        vrste[row] = {}
vrste = sorted(vrste)

dani = {}
for k in range(7):
    dani[k] = {}
    for i in range(len(datumi)):
        if datumi[i].weekday() == k:
            dani[k][datumi[i]] = {}
            for j in range(len(vrste)):
                dani[k][datumi[i]][vrste[j]] = 0

for k in range(7):
    for i in range(len(data)):
        if weekdays[i] == k:
            dani[k][data['datum'][i]][data['naziv'][i]] = dani[k][data['datum'][i]][data['naziv'][i]] + data['izlaz'][i]

prosecna_prodaja = {}

for k in dani:
    prosecna_prodaja[k] = {}
    for datum in datumi:
        if datum in dani[k]:
            for vrsta in vrste:
                if vrsta in dani[k][datum]:
                    prosecna_prodaja[k][vrsta] = []

for k in dani:
    for datum in datumi:
        if datum in dani[k]:
            for vrsta in vrste:
                if vrsta in dani[k][datum]:
                    prosecna_prodaja[k][vrsta].append(dani[k][datum][vrsta])

for k in prosecna_prodaja:
    for vrsta in vrste:
            prosecna_prodaja[k][vrsta] = statistics.mean(prosecna_prodaja[k][vrsta])

dataframe = pd.DataFrame(prosecna_prodaja)