import gspread
from oauth2client.service_account import ServiceAccountCredentials
import pandas as pd
import time
from obicne import raspodelaObicne, lepljeniKartoniObicne
from visestruke import raspodelaVisestruke, lepljeniKartoniVisestruke
from datetime import datetime

pocetak_datum = "3/30/2022"
kraj_datum = "4/8/2022"

scope = ['https://www.googleapis.com/auth/spreadsheets', 'https://www.googleapis.com/auth/drive.file',
         'https://www.googleapis.com/auth/drive']
creds = ServiceAccountCredentials.from_json_keyfile_name('keys.json', scope)
client = gspread.authorize(creds)

PRODAJA_DATA = {"document_name": "PRODAJA DATA",
                "worksheets": ["ULAZ KUJNA", 'HRANA INV', "PICE INV", 'OKRUGLE INV', 'SNITEVI INV',
                               'KOMADNO INV']}

PROIZVODNJA_DATA = {"document_name": "PROIZVODNJA DATA",
                    "worksheets": ["MAZANO", 'MAZANO OTPIS', "KOMADNO", "SNITEVI", "OKRUGLE", 'INVENTAR',
                                   'KOMADNO INV', 'OKRUGLE INV', 'SNITEVI INV', 'KOMADNO IZ OTPISA']}

def get_data(document_name, worksheet_name, pocetak_datum, kraj_datum):
    sheet = client.open(document_name).worksheet(worksheet_name)
    dataframe = pd.DataFrame(sheet.get_all_records())
    for i in range(len(dataframe['DATUM'])):
        datum = datetime.date(datetime.strptime(dataframe['DATUM'][i], '%m/%d/%Y'))
        dataframe['DATUM'][i] = datum
    strp_poc_datum = datetime.date(datetime.strptime(pocetak_datum, '%m/%d/%Y'))
    strp_kraj_datum = datetime.date(datetime.strptime(kraj_datum, '%m/%d/%Y'))
    podaci_posle_pocetnog_datuma = dataframe["DATUM"] >= strp_poc_datum
    podaci_pre_krajnjeg_datuma = dataframe["DATUM"] <= strp_kraj_datum
    kolko = dataframe[podaci_posle_pocetnog_datuma & podaci_pre_krajnjeg_datuma]
    return kolko.T

# def stanje(document_name, worksheet_name, pocetak_datum, kraj_datum):
#     sheet = client.open(document_name).worksheet(worksheet_name)
#     dataframe = pd.DataFrame(sheet.get_all_records())
#     try:
#         pocetak = sheet.find(pocetak_datum).row - 2
#         kraj = sheet.find(kraj_datum).row - 1
#         kolko = dataframe[pocetak:kraj]
#         kolko = kolko.T
#     except:
#         kolko = []
#     return kolko

proizvodnja_mazano = get_data(PROIZVODNJA_DATA["document_name"], PROIZVODNJA_DATA['worksheets'][0], pocetak_datum, kraj_datum)
proizvodnja_mazano_otpis = get_data(PROIZVODNJA_DATA["document_name"], PROIZVODNJA_DATA['worksheets'][1], pocetak_datum, kraj_datum)
proizvodnja_komadno = get_data(PROIZVODNJA_DATA["document_name"], PROIZVODNJA_DATA['worksheets'][2], pocetak_datum, kraj_datum)
proizvodnja_snitevi = get_data(PROIZVODNJA_DATA["document_name"], PROIZVODNJA_DATA['worksheets'][3], pocetak_datum, kraj_datum)
proizvodnja_okrugle = get_data(PROIZVODNJA_DATA["document_name"], PROIZVODNJA_DATA['worksheets'][4], pocetak_datum, kraj_datum)
proizvodnja_inventar = get_data(PROIZVODNJA_DATA["document_name"], PROIZVODNJA_DATA['worksheets'][5], pocetak_datum, kraj_datum)
proizvodnja_inv_komadno = get_data(PROIZVODNJA_DATA["document_name"], PROIZVODNJA_DATA['worksheets'][6], pocetak_datum, kraj_datum)
proizvodnja_inv_okrugle = get_data(PROIZVODNJA_DATA["document_name"], PROIZVODNJA_DATA['worksheets'][7], pocetak_datum, kraj_datum)
proizvodnja_inv_snitevi = get_data(PROIZVODNJA_DATA["document_name"], PROIZVODNJA_DATA['worksheets'][8], pocetak_datum, kraj_datum)
proizvodnja_komadno_otpis = get_data(PROIZVODNJA_DATA["document_name"], PROIZVODNJA_DATA['worksheets'][9], pocetak_datum, kraj_datum)

time.sleep(60)

prodaja_ulaz_kujna = get_data(PRODAJA_DATA["document_name"], PRODAJA_DATA['worksheets'][0], pocetak_datum, kraj_datum)
prodaja_pice_inv_zaListuSamo = get_data(PRODAJA_DATA["document_name"], PRODAJA_DATA['worksheets'][2], pocetak_datum, kraj_datum)
prodaja_pice_inv_zaListuSamo = prodaja_pice_inv_zaListuSamo.drop(['CAJ DOMACI KESICA', 'CAJ MILFORD KESICA', 'CAJ DELUXE',
        'CEDEVITA KESICA', 'ESPRESSO BROJCANIK', 'ESPRESSO KG', 'JOGURT KRAVICA 0.5', 'KAFA TURSKA KESICA', 'KAPUCINO KESICA',
'LIMUNADA APARAT', 'NESKAFA KG', 'SOK LIMUNOV', 'TOPLA COKOLADA KESICA', 'ZOVANADA'])
prodaja_pice_inv = get_data(PRODAJA_DATA["document_name"], PRODAJA_DATA['worksheets'][2], pocetak_datum, kraj_datum)
prodaja_hrana_inv = get_data(PRODAJA_DATA["document_name"], PRODAJA_DATA['worksheets'][1], pocetak_datum, kraj_datum)
prodaja_okrugle_inv = get_data(PRODAJA_DATA["document_name"], PRODAJA_DATA['worksheets'][3], pocetak_datum, kraj_datum)
prodaja_snitevi_inv = get_data(PRODAJA_DATA["document_name"], PRODAJA_DATA['worksheets'][4], pocetak_datum, kraj_datum)
prodaja_komadno_inv = get_data(PRODAJA_DATA["document_name"], PRODAJA_DATA['worksheets'][5], pocetak_datum, kraj_datum)

placeno_karticom_pre_za_sad_OBICNE, placeno_karticom_sad_za_unapred_OBICNE, torte_zavrsene_OBICNE \
    = raspodelaObicne(pocetak_datum, kraj_datum)
placeno_karticom_pre_za_sad_VISESTRUKE, placeno_karticom_sad_za_unapred_VISESTRUKE, torte_zavrsene_VISESTRUKE\
    = raspodelaVisestruke(pocetak_datum, kraj_datum)
torte_lepljeni_kartoni_OBICNE = lepljeniKartoniObicne(pocetak_datum, kraj_datum)
torte_lepljeni_kartoni_VISESTRUKE = lepljeniKartoniVisestruke(pocetak_datum, kraj_datum)

ukup_vrst_zav = [torte_zavrsene_OBICNE['TORTE'], torte_zavrsene_VISESTRUKE['TORTE']]
ukup_vrst_lep = [torte_lepljeni_kartoni_OBICNE['TORTE'], torte_lepljeni_kartoni_VISESTRUKE['TORTE']]
ukup_vrst_zav = [vrsta for item in ukup_vrst_zav for vrsta in item]
ukup_vrst_lep = [vrsta for item in ukup_vrst_lep for vrsta in item]
ukup_kolko_zav = [torte_zavrsene_OBICNE['KOLICINA'], torte_zavrsene_VISESTRUKE['KOLICINA']]
ukup_kolko_lep = [torte_lepljeni_kartoni_OBICNE['KOLICINA'], torte_lepljeni_kartoni_VISESTRUKE['KOLICINA']]
ukup_kolko_zav = [vrsta for item in ukup_kolko_zav for vrsta in item]
ukup_kolko_lep = [vrsta for item in ukup_kolko_lep for vrsta in item]
ukup_vrst_zav_uniq = []
ukup_kolko_zav_uniq = []
for i in range(len(ukup_vrst_zav)):
    if ukup_vrst_zav[i] not in ukup_vrst_zav_uniq:
        ukup_vrst_zav_uniq.append(ukup_vrst_zav[i])
        ukup_kolko_zav_uniq.append(ukup_kolko_zav[i])
    else:
        brojac = 0
        for vrsta in ukup_vrst_zav_uniq:
            if vrsta == ukup_vrst_zav[i]:
                ukup_kolko_zav_uniq[brojac] = ukup_kolko_zav_uniq[brojac] + ukup_kolko_zav[i]
            brojac = brojac + 1

ukup_vrst_lep_uniq = []
ukup_kolko_lep_uniq = []
for i in range(len(ukup_vrst_lep)):
    if ukup_vrst_lep[i] not in ukup_vrst_lep_uniq:
        ukup_vrst_lep_uniq.append(ukup_vrst_lep[i])
        ukup_kolko_lep_uniq.append(ukup_kolko_lep[i])
    else:
        brojac = 0
        for vrsta in ukup_vrst_lep_uniq:
            if vrsta == ukup_vrst_lep[i]:
                ukup_kolko_lep_uniq[brojac] = ukup_kolko_lep_uniq[brojac] + ukup_kolko_lep[i]
            brojac = brojac + 1

torte_zavrsene_UKUPNO = {'TORTE': ukup_vrst_zav_uniq, "KOLICINA": ukup_kolko_zav_uniq}
torte_lepljeni_kartoni_UKUPNO = {'TORTE': ukup_vrst_lep_uniq, "KOLICINA": ukup_kolko_lep_uniq}
torte_zavrsene_UKUPNO = pd.DataFrame(torte_zavrsene_UKUPNO).sort_values(['TORTE'])
torte_zavrsene_OBICNE = pd.DataFrame(torte_zavrsene_OBICNE).sort_values(['TORTE'])
torte_zavrsene_VISESTRUKE = pd.DataFrame(torte_zavrsene_VISESTRUKE).sort_values(['TORTE'])
torte_lepljeni_kartoni_UKUPNO = pd.DataFrame(torte_lepljeni_kartoni_UKUPNO).sort_values(['TORTE'])
torte_lepljeni_kartoni_OBICNE = pd.DataFrame(torte_lepljeni_kartoni_OBICNE).sort_values(['TORTE'])
torte_lepljeni_kartoni_VISESTRUKE = pd.DataFrame(torte_lepljeni_kartoni_VISESTRUKE).sort_values(['TORTE'])

