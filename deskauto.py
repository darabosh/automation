import pyautogui
import time
import gspread
from oauth2client.service_account import ServiceAccountCredentials
import pandas as pd
import re
from obicne import raspodelaObicne, lepljeniKartoniObicne
from visestruke import raspodelaVisestruke, lepljeniKartoniVisestruke
from datetime import datetime
import easygui


pyautogui.PAUSE = 0.25
pocetak_datum = "3/31/2022"
kraj_datum = "4/4/2022"

scope = ['https://www.googleapis.com/auth/spreadsheets', 'https://www.googleapis.com/auth/drive.file',
         'https://www.googleapis.com/auth/drive']
creds = ServiceAccountCredentials.from_json_keyfile_name('keys.json', scope)
client = gspread.authorize(creds)

PROIZVODNJA_DATA = {"document_name": "PROIZVODNJA DATA",
                    "worksheets": ["MAZANO", "KOMADNO", "SNITEVI", "OKRUGLE"]}
PRODAJA_DATA = {"document_name": "PRODAJA DATA",
                "worksheets": ["ULAZ KUJNA", "PICE INV"]}
OBICNE_DATA = {"document_name": "OBICNE",
                "worksheets": ["OBICNE"]}

def brain(document_name, worksheet_name, pocetak_datum, kraj_datum):
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
    ulaz = []
    for i in range(len(kolko.columns)):
        ulaz.append(0)
    for i in range(len(kolko.columns)):
        for j in range(len(kolko)):
            if isinstance(kolko.values[j, i], (int, float)):
                ulaz[i] = ulaz[i] + kolko.values[j, i]
    return ulaz


kujna = [28, 29, 283, 198, 199, 112, 559, 623, 288, 206, 142, 26, 293, 323, 200, 201, 329, 1254, 434, 435, 155, 146,
         321, 144, 145, 286, 593, 620, 356, 914, 425, 911, 1819, 1832, 213, 13, 87, 17, 18, 19, 24, 906, 912, 905, 904,
         915, 903, 907, 1855, 1366, 1365, 1368, 166, 167, 1130]
mazano = [1544, 1763, 1545, 1868, 1546, 1549, 1551, 1869, 1552, 1765, 1773, 1865, 1774, 1775, 1776, 1777, 1771, 1778,
          1779, 1770, 1780, 1866, 1781, 1867, 1783, 1769, 1785, 1786, 1772, 1789, 1864, 1790, 1791, 1792, 1793, 1794,
          1795, 1768, 1796, 1870, 1556, 1767, 1797, 1676, 1873, 1884, 1798, 1799, 1803, 1557, 1806, 1555, 1885, 1809, 1886, 1810, 1740,
          1812, 1871, 1766, 1816, 1762]
mazano_snit = [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1,
               0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0]
komadno = [165, 597, 508, 488, 453, 480, 489, 449, 227, 88, 510, 295, 477, 581, 445, 500, 49, 215, 139, 590, 191, 586,
           300, 622, 152, 47, 447, 504, 196, 564, 606, 51, 605, 934, 506, 149, 572, 197, 599, 613, 604, 214, 405, 153,
           345, 352, 40, 315, 431, 529, 367, 587, 603, 560, 610, 192, 185, 1541, 1241, 621, 52, 1246, 308, 292, 577,
           589, 608, 611, 3, 499, 45, 46, 310, 571, 48, 4]
snitevi = [56, 474, 582, 53, 62, 252, 57, 12, 585, 301, 297, 289, 60, 162, 156, 600, 254, 346, 353, 311, 370, 542, 461,
           14, 138, 1247, 588, 578, 58, 59, 253, 61]
okrugle = [509, 491, 455, 454, 481, 492, 451, 328, 296, 503, 290, 563, 505, 612, 570, 501, 1269, 260, 432, 433, 520, 65,
           1242, 332, 609, 519, 573]

kujnaUlaz = brain(PRODAJA_DATA["document_name"], PRODAJA_DATA['worksheets'][0], pocetak_datum, kraj_datum)
mazanoUlaz = brain(PROIZVODNJA_DATA["document_name"], PROIZVODNJA_DATA['worksheets'][0], pocetak_datum, kraj_datum)
for i in range(len(mazano)):
    if mazano_snit[i] == 1:
        mazanoUlaz[i+1] = mazanoUlaz[i+1]/4
komadnoUlaz = brain(PROIZVODNJA_DATA["document_name"], PROIZVODNJA_DATA['worksheets'][1], pocetak_datum, kraj_datum)
sniteviUlaz = brain(PROIZVODNJA_DATA["document_name"], PROIZVODNJA_DATA['worksheets'][2], pocetak_datum, kraj_datum)
okrugleUlaz = brain(PROIZVODNJA_DATA["document_name"], PROIZVODNJA_DATA['worksheets'][3], pocetak_datum, kraj_datum)
raspodela_obicne_ulaz, raspodela_obicne, placeno_karticom_pre_za_sad_obicne, placeno_karticom_sad_za_unapred_obicne, \
    opis_bool_raspodela = raspodelaObicne(pocetak_datum, kraj_datum)
lepljeni_kartoni_obicne_ulaz, lepljeni_kartoni_obicne, opis_bool_kartoni = \
    lepljeniKartoniObicne(pocetak_datum,kraj_datum)
raspodela_visestruke_ulaz, raspodela_visestruke, placeno_karticom_pre_za_sad_visestruke, placeno_karticom_sad_za_unapred_visestruke, \
    opis_bool_raspodela = raspodelaVisestruke(pocetak_datum, kraj_datum)
lepljeni_kartoni_visestruke_ulaz, lepljeni_kartoni_visestruke, opis_bool_kartoni = \
    lepljeniKartoniVisestruke(pocetak_datum,kraj_datum)
if opis_bool_raspodela or opis_bool_kartoni:
    easygui.msgbox("Morate uneti rucno tortu koja ima OPIS kao vrstu!", title="TORTA OPIS")

time.sleep(5)
for i in range(0, len(kujna)):
    if kujnaUlaz[i+1] != 0:
        pyautogui.write(f'{kujna[i]}')
        pyautogui.press('enter')
        pyautogui.press('enter')
        pyautogui.write(f'{kujnaUlaz[i + 1]}')
        pyautogui.press('enter')
        pyautogui.press('down')
        pyautogui.press('right')

time.sleep(5)
for i in range(0, len(mazano)):
    if mazanoUlaz[i+1] != 0:
        pyautogui.write(f'{mazano[i]}')
        pyautogui.press('enter')
        pyautogui.press('enter')
        pyautogui.write(f'{mazanoUlaz[i + 1]}')
        pyautogui.press('enter')
        pyautogui.press('down')
        pyautogui.press('right')

time.sleep(5)
for i in range(0, len(komadno)):
    if komadnoUlaz[i+1] != 0:
        pyautogui.write(f'{komadno[i]}')
        pyautogui.press('enter')
        pyautogui.press('enter')
        pyautogui.write(f'{komadnoUlaz[i + 1]}')
        pyautogui.press('enter')
        pyautogui.press('down')
        pyautogui.press('right')

time.sleep(5)
for i in range(0, len(snitevi)):
    if sniteviUlaz[i+1] != 0:
        pyautogui.write(f'{snitevi[i]}')
        pyautogui.press('enter')
        pyautogui.press('enter')
        pyautogui.write(f'{sniteviUlaz[i + 1]}')
        pyautogui.press('enter')
        pyautogui.press('down')
        pyautogui.press('right')

time.sleep(5)
for i in range(0, len(okrugle)):
    if okrugleUlaz[i+1] != 0:
        pyautogui.write(f'{okrugle[i]}')
        pyautogui.press('enter')
        pyautogui.press('enter')
        pyautogui.write(f'{okrugleUlaz[i + 1]}')
        pyautogui.press('enter')
        pyautogui.press('down')
        pyautogui.press('right')

time.sleep(5)
for i in range(0, len(lepljeni_kartoni_obicne)):
    pyautogui.write(f'{lepljeni_kartoni_obicne[i]}')
    pyautogui.press('enter')
    pyautogui.press('enter')
    pyautogui.write(f'{lepljeni_kartoni_obicne_ulaz[i]}')
    pyautogui.press('enter')
    pyautogui.press('down')
    pyautogui.press('right')

time.sleep(5)
for i in range(0, len(lepljeni_kartoni_visestruke)):
    pyautogui.write(f'{lepljeni_kartoni_visestruke[i]}')
    pyautogui.press('enter')
    pyautogui.press('enter')
    pyautogui.write(f'{lepljeni_kartoni_visestruke_ulaz[i]}')
    pyautogui.press('enter')
    pyautogui.press('down')
    pyautogui.press('right')

time.sleep(5)
for i in range(0, len(raspodela_obicne)):
    pyautogui.write(f'{raspodela_obicne[i]}')
    pyautogui.press('enter')
    pyautogui.press('enter')
    pyautogui.write(f'{raspodela_obicne_ulaz[i]}')
    pyautogui.press('enter')
    pyautogui.press('down')
    pyautogui.press('right')
    pyautogui.press('right')

time.sleep(5)
for i in range(0, len(raspodela_visestruke)):
    pyautogui.write(f'{raspodela_visestruke[i]}')
    pyautogui.press('enter')
    pyautogui.press('enter')
    pyautogui.write(f'{raspodela_visestruke_ulaz[i]}')
    pyautogui.press('enter')
    pyautogui.press('down')
    pyautogui.press('right')
    pyautogui.press('right')
