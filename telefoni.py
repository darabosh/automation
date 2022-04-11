import gspread
from oauth2client.service_account import ServiceAccountCredentials
import pandas as pd

scope = ['https://www.googleapis.com/auth/spreadsheets', 'https://www.googleapis.com/auth/drive.file',
         'https://www.googleapis.com/auth/drive']
creds = ServiceAccountCredentials.from_json_keyfile_name('keys.json', scope)
client = gspread.authorize(creds)

obicne = client.open("OBICNE").worksheet("OBICNE")
obicnedata = pd.DataFrame(obicne.get_all_records())
telefoniOBICNE = pd.DataFrame(obicnedata, columns=["IME I PREZIME", "ZA DATUM", "VRSTA", "VELICINA", "TELEFON"])

visestruke = client.open("VISESTRUKE I FONDANI").worksheet("VISESTRUKE I FONDANI")
visestrukedata = pd.DataFrame(visestruke.get_all_records())
telefoniVISESTRUKE = pd.DataFrame(visestrukedata, columns=["IME I PREZIME", "ZA DATUM", "TELEFON"])
