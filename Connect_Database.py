
--Connect to SQL Server 2008 for Pandas Python

--"fill" replace with ID and Password
import pypyodbc
import pandas as pd
conn = pypyodbc.connect('DRIVER={SQL Server};SERVER=AQUSYDDB02;DATABASE=AQUEON;UID=fill;PWD=fill')

-- Example access of Database using a query
waitstats = pd.read_sql('SELECT CardCode FROM OCRD', conn)



--Connect Database to Excel Spreadsheet

--Connection String
DRIVER=SQL Server;SERVER=AQUSYDDB02;UID=fill;PWD=fill;APP=Microsoft Office 2003;WSID=TONY;DATABASE=AQUEON
