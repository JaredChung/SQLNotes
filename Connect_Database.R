
myconn <-odbcDriverConnect('driver={SQL Server};server=AQUSYDDB02;database=AQUEON;uid=sa;pwd=D1g1tu5')

pundat <- sqlQuery(myconn, "select * from OCRD")
