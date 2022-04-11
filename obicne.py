from oauth2client.service_account import ServiceAccountCredentials
import gspread
import pandas as pd
from datetime import datetime
from difflib import SequenceMatcher
import re


def raspodelaObicne(pocetakDatum, krajDatum):
    scope = ["https://www.googleapis.com/auth/spreadsheets", "https://www.googleapis.com/auth/drive.file",
             "https://www.googleapis.com/auth/drive"]
    creds = ServiceAccountCredentials.from_json_keyfile_name("keys.json", scope)
    client = gspread.authorize(creds)

    python_test = client.open("OBICNE").worksheet("OBICNE")
    data = pd.DataFrame(python_test.get_all_records())

    for i in range(len(data['ZA DATUM'])):
        zadatum = datetime.date(datetime.strptime(data['ZA DATUM'][i], '%d/%b/%Y %H:%M:'))
        data['ZA DATUM'][i] = zadatum
        timestamp = datetime.date(datetime.strptime(data['Timestamp'][i], '%d/%m/%Y %H:%M:%S'))
        data['Timestamp'][i] = timestamp

    strp_poc_datum = datetime.date(datetime.strptime(pocetakDatum, '%m/%d/%Y'))
    strp_kraj_datum = datetime.date(datetime.strptime(krajDatum, '%m/%d/%Y'))
    torat = []
    torte_pre_krajnjeg_datuma = data["ZA DATUM"] <= strp_kraj_datum
    torte_posle_pocetnog_datuma = data["ZA DATUM"] >= strp_poc_datum
    torat = data[torte_posle_pocetnog_datuma & torte_pre_krajnjeg_datuma]

    data_za_karticom_posle = data[torte_posle_pocetnog_datuma]
    karticom_posle = data_za_karticom_posle["KARTICOM"] == "DA"
    timestamp_posle = data_za_karticom_posle["Timestamp"] <= strp_kraj_datum
    timestamp_veciilijednak_pocetnogdatuma = data_za_karticom_posle["Timestamp"] >= strp_poc_datum
    za_datum_posle_krajnjeg = data_za_karticom_posle["ZA DATUM"] > strp_kraj_datum
    placeno_karticom_sad_za_unapred = \
        data_za_karticom_posle[karticom_posle & timestamp_posle &
                               timestamp_veciilijednak_pocetnogdatuma & za_datum_posle_krajnjeg]

    karticom_pre = torat["KARTICOM"] == "DA"
    timestamp_pre = torat["Timestamp"] < strp_poc_datum
    placeno_karticom_pre_za_sad = torat[karticom_pre & timestamp_pre]

    vrste = [vrsta for vrsta in torat['VRSTA']]
    velicine = [velicina for velicina in torat['VELICINA']]
    spajanje = []
    opis_bool = False
    for i in range(len(vrste)):
        criteria_re = re.compile(r'OPIS*')
        if re.search(criteria_re, vrste[i]):
            opis_bool = True
            continue
        spajanje.append(vrste[i] + " " + velicine[i])
    torte = []

    for spoj in spajanje:
        if spoj not in torte:
            torte.append(spoj)


    sifre_ulaza = [0 for x in range(len(torte))]
    sve_sifre = pd.read_csv("sifre.csv", header=None)
    ratio = [0 for x in range(len(torte))]
    for i in range(len(torte)):
        for j in range(len(sve_sifre)):
            s = SequenceMatcher(None, torte[i], sve_sifre[1][j])
            if ratio[i] < s.ratio():
                ratio[i] = s.ratio()
                sifre_ulaza[i] = sve_sifre[0][j]


    torteUlaz = [0 for x in range(len(torte))]
    for j in range(len(torte)):
        for i in range(len(spajanje)):
            if torte[j] == spajanje[i]:
                torteUlaz[j] += 1

    return torteUlaz, sifre_ulaza, placeno_karticom_pre_za_sad, placeno_karticom_sad_za_unapred, opis_bool


def lepljeniKartoniObicne(pocetakDatum, krajDatum):
    scope = ["https://www.googleapis.com/auth/spreadsheets", "https://www.googleapis.com/auth/drive.file",
             "https://www.googleapis.com/auth/drive"]
    creds = ServiceAccountCredentials.from_json_keyfile_name("keys.json", scope)
    client = gspread.authorize(creds)

    python_test = client.open("OBICNE").worksheet("OBICNE")
    data = pd.DataFrame(python_test.get_all_records())

    for i in range(len(data['LEPLJEN KARTON'])):
        zadatum = datetime.date(datetime.strptime(data['ZA DATUM'][i], '%d/%b/%Y %H:%M:'))
        data['ZA DATUM'][i] = zadatum
        if data['LEPLJEN KARTON'][i] == '':
            data['LEPLJEN KARTON'][i] = datetime.date(datetime.strptime('01/01/1911', '%d/%m/%Y'))
        else:
            lepljen_karton = datetime.date(datetime.strptime(data['LEPLJEN KARTON'][i], '%d/%m/%Y'))
            data['LEPLJEN KARTON'][i] = lepljen_karton
        timestamp = datetime.date(datetime.strptime(data['Timestamp'][i], '%d/%m/%Y %H:%M:%S'))
        data['Timestamp'][i] = timestamp

    strp_poc_datum = datetime.date(datetime.strptime(pocetakDatum, '%m/%d/%Y'))
    strp_kraj_datum = datetime.date(datetime.strptime(krajDatum, '%m/%d/%Y'))
    torat = []
    torte_pre_krajnjeg_datuma = data["LEPLJEN KARTON"] <= strp_kraj_datum
    torte_posle_pocetnog_datuma = data["LEPLJEN KARTON"] >= strp_poc_datum
    torat = data[torte_posle_pocetnog_datuma & torte_pre_krajnjeg_datuma]

    vrste = [vrsta for vrsta in torat['VRSTA']]
    velicine = [velicina for velicina in torat['VELICINA']]
    spajanje = []
    opis_bool = False
    for i in range(len(vrste)):
        criteria_re = re.compile(r'OPIS*')
        if re.search(criteria_re, vrste[i]):
            opis_bool = True
            continue
        spajanje.append(vrste[i] + " " + velicine[i])
    torte = []

    for spoj in spajanje:
        if spoj not in torte:
            torte.append(spoj)

    sifre_ulaza = [0 for x in range(len(torte))]
    sve_sifre = pd.read_csv("sifre.csv", header=None)
    ratio = [0 for x in range(len(torte))]
    for i in range(len(torte)):
        for j in range(len(sve_sifre)):
            s = SequenceMatcher(None, torte[i], sve_sifre[1][j])
            if ratio[i] < s.ratio():
                ratio[i] = s.ratio()
                sifre_ulaza[i] = sve_sifre[0][j]

    torteUlaz = [0 for x in range(len(torte))]
    for j in range(len(torte)):
        for i in range(len(spajanje)):
            if torte[j] == spajanje[i]:
                torteUlaz[j] += 1

    return torteUlaz, sifre_ulaza, opis_bool


# def obicne_get(document_name, worksheet_name):
#     sheet = client.open("OBICNE").worksheet("OBICNE")
#     criteria_re = re.compile(r'24/Dec/2021.*')
#     search = sheet.findall(criteria_re)
#     redovi = [search[red].row for red in range(len(search))]
#     dataframe = pd.DataFrame(sheet.get_all_records())
#     izabrano = dataframe.loc[redovi]
#     return izabrano
