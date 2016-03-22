

--Balance Sheet based on date range

SELECT T1.FormatCode,T1.AcctName,SUM(T0.Debit)-Sum(T0.Credit) 'Balance as of the day'
FROM 
JDT1 T0
JOIN OACT T1 ON T1.AcctCode=T0.Account
JOIN OJDT T2 ON T2.TransID=T0.TransID
WHERE T1.FormatCode <= '350000' AND T2.RefDate <='2016-01-31'
GROUP BY T1.FormatCode,T1.AcctName
