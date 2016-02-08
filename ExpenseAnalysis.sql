---- Expense Analysis

-----Combined Query

SET NOCOUNT ON 
DECLARE @fromdate as datetime
DECLARE @todate as datetime

DECLARE @fromglcode as INT
DECLARE @toglcode as INT

SET @fromdate  = '2015-07-01'
SET @todate  = '2016-06-30'

SET @fromglcode = '100000'
SET @toglcode = '900000'

----AP Invoice
SELECT 
T2.[FormatCode] as 'G/L Code', 
T2.[AcctName] as 'Account Name', 
T0.[DocDate] as 'Posting Date',
T0.[DocNum] as 'Transaction Number',

CASE
WHEN T0.[ObjType] = '13' THEN 'A/R Invoice'
WHEN T0.[ObjType] = '14' THEN 'A/R Credit Memo'
WHEN T0.[ObjType] = '18' THEN 'A/P Invoice'
WHEN T0.[ObjType] = '19' THEN 'A/P Credit Memo'
WHEN T0.[ObjType] = '30' THEN 'Journal Entry'
WHEN T0.[ObjType] = '15' THEN 'Delivery Doc'
ELSE 'ERROR'
END AS 'Document Type',
  
T0.[CardName] as 'Customer/Supplier Name',

T1.[Dscription] as 'Description', 

T1.[LineTotal] as 'Amount', 
T1.[OcrCode] as 'Distribution Rule', 
T1.[Project]  as 'Project Code'


FROM OPCH T0  INNER JOIN PCH1 T1 ON T0.DocEntry = T1.DocEntry INNER JOIN OACT T2 ON T1.AcctCode = T2.AcctCode 

WHERE T2.[FormatCode] >= @fromglcode AND T2.[FormatCode] <= @toglcode and T0.[CANCELED] = 'N' and  T0.[DocDate] >= @fromdate and  T0.[DocDate] <= @todate


UNION ALL



------Journals
SELECT
T1.[FormatCode] as 'G/L Code',
T1.[AcctName] as 'Account Name', 
T2.[RefDate] as 'Posting Date',
T2.[TransId] as 'Transaction Number',

CASE
WHEN T2.[TransType] = '13' THEN 'A/R Invoice'
WHEN T2.[TransType] = '14' THEN 'A/R Credit Memo'
WHEN T2.[TransType] = '18' THEN 'A/P Invoice'
WHEN T2.[TransType] = '19' THEN 'A/P Credit Memo'
WHEN T2.[TransType] = '30' THEN 'Journal Entry'
WHEN T2.[TransType] = '15' THEN 'Delivery Doc'
ELSE 'ERROR'
END AS 'Document Type',

T2.[Memo] as 'Customer/Supplier Name',


T0.[LineMemo] as 'Description',

T0.[Debit] - T0.[Credit] as 'Amount',
T0.[ProfitCode] as 'Distribution Rule',
T0.[Project] as 'Project Code'



FROM JDT1 T0  INNER JOIN OACT T1 ON T0.Account = T1.AcctCode INNER JOIN OJDT T2 ON T0.TransId = T2.TransId


WHERE T1.FormatCode >= @fromglcode AND T1.FormatCode <= @toglcode AND T2.RefDate >= @fromdate  AND  T2.RefDate <=@todate
AND (T2.[TransType] <> 14 AND T2.[TransType] <> 18 AND T2.[TransType] <> 13 AND T2.[TransType] <> 19)






UNION ALL




------AP Credit Note
SELECT 
T2.[FormatCode] as 'G/L Code', 
T2.[AcctName] as 'Account Name', 
T0.[DocDate] as 'Posting Date',
T0.[DocNum] as 'Transaction Number',

CASE
WHEN T0.[ObjType] = '13' THEN 'A/R Invoice'
WHEN T0.[ObjType] = '14' THEN 'A/R Credit Memo'
WHEN T0.[ObjType] = '18' THEN 'A/P Invoice'
WHEN T0.[ObjType] = '19' THEN 'A/P Credit Memo'
WHEN T0.[ObjType] = '30' THEN 'Journal Entry'
WHEN T0.[ObjType] = '15' THEN 'Delivery Doc'
ELSE 'ERROR'
END AS 'Document Type',
  
T0.[CardName] as 'Customer/Supplier Name',

 
T1.[Dscription] as 'Description', 

-T1.[LineTotal] as 'Amount',
T1.[OcrCode] as 'Distribution Rule', 
T1.[Project]  as 'Project Code'


FROM ORPC T0  INNER JOIN RPC1 T1 ON T0.DocEntry = T1.DocEntry INNER JOIN OACT T2 ON T1.AcctCode = T2.AcctCode 

WHERE T2.[FormatCode] >= @fromglcode AND T2.[FormatCode] <= @toglcode and T0.[CANCELED] = 'N' and  T0.[DocDate] >= @fromdate and  T0.[DocDate] <= @todate


UNION ALL




--------AR Credit Note
SELECT 
T2.[FormatCode] as 'G/L Code', 
T2.[AcctName] as 'Account Name', 
T0.[DocDate] as 'Posting Date',
T0.[DocNum] as 'Transaction Number',

CASE
WHEN T0.[ObjType] = '13' THEN 'A/R Invoice'
WHEN T0.[ObjType] = '14' THEN 'A/R Credit Memo'
WHEN T0.[ObjType] = '18' THEN 'A/P Invoice'
WHEN T0.[ObjType] = '19' THEN 'A/P Credit Memo'
WHEN T0.[ObjType] = '30' THEN 'Journal Entry'
WHEN T0.[ObjType] = '15' THEN 'Delivery Doc'
ELSE 'ERROR'
END AS 'Document Type',
  
T0.[CardName] as 'Customer/Supplier Name',

 
T1.[Dscription] as 'Description', 

T1.[LineTotal] as 'Amount',
T1.[OcrCode] as 'Distribution Rule', 
T1.[Project]  as 'Project Code'


FROM ORIN T0  INNER JOIN RIN1 T1 ON T0.DocEntry = T1.DocEntry INNER JOIN OACT T2 ON T1.AcctCode = T2.AcctCode 

WHERE T2.[FormatCode] >= @fromglcode AND T2.[FormatCode] <= @toglcode and T0.[CANCELED] = 'N' and  T0.[DocDate] >= @fromdate and  T0.[DocDate] <= @todate




UNION ALL



-----------AR Invoice
SELECT 
T2.[FormatCode] as 'G/L Code', 
T2.[AcctName] as 'Account Name', 
T0.[DocDate] as 'Posting Date',
T0.[DocNum] as 'Transaction Number',

CASE
WHEN T0.[ObjType] = '13' THEN 'A/R Invoice'
WHEN T0.[ObjType] = '14' THEN 'A/R Credit Memo'
WHEN T0.[ObjType] = '18' THEN 'A/P Invoice'
WHEN T0.[ObjType] = '19' THEN 'A/P Credit Memo'
WHEN T0.[ObjType] = '30' THEN 'Journal Entry'
WHEN T0.[ObjType] = '15' THEN 'Delivery Doc'
ELSE 'ERROR'
END AS 'Document Type',
  
T0.[CardName] as 'Customer/Supplier Name',

 
T1.[Dscription] as 'Description', 

T1.[LineTotal] as 'Amount',
T1.[OcrCode] as 'Distribution Rule', 
T1.[Project]  as 'Project Code'


FROM OINV T0  INNER JOIN INV1 T1 ON T0.DocEntry = T1.DocEntry INNER JOIN OACT T2 ON T1.AcctCode = T2.AcctCode 

WHERE T2.[FormatCode] >= @fromglcode AND T2.[FormatCode] <= @toglcode and T0.[CANCELED] = 'N' and  T0.[DocDate] >= @fromdate and  T0.[DocDate] <= @todate


UNION ALL


--------- ADDING MISSING Data due to the flow of internal transactions e.g Marketing Samples (Need to find better solution)


SELECT
T1.[FormatCode] as 'G/L Code',
T1.[AcctName] as 'Account Name', 
T2.[RefDate] as 'Posting Date',
T2.[TransId] as 'Transaction Number',

CASE
WHEN T2.[TransType] = '13' THEN 'A/R Invoice'
WHEN T2.[TransType] = '14' THEN 'A/R Credit Memo'
WHEN T2.[TransType] = '18' THEN 'A/P Invoice'
WHEN T2.[TransType] = '19' THEN 'A/P Credit Memo'
WHEN T2.[TransType] = '30' THEN 'Journal Entry'
WHEN T2.[TransType] = '15' THEN 'Delivery Doc'
ELSE 'ERROR'
END AS 'Document Type',

T2.[Memo] as 'Customer/Supplier Name',


T0.[LineMemo] as 'Description',

T0.[Debit] - T0.[Credit] as 'Amount',
T0.[ProfitCode] as 'Distribution Rule',
T0.[Project] as 'Project Code'



FROM JDT1 T0  INNER JOIN OACT T1 ON T0.Account = T1.AcctCode INNER JOIN OJDT T2 ON T0.TransId = T2.TransId 


WHERE T1.FormatCode = '613200' AND T2.RefDate >= @fromdate  AND  T2.RefDate <=@todate
AND (T2.[TransType] <> 18 AND T2.[TransType] <> 30 AND T2.[TransType] <> 15)
