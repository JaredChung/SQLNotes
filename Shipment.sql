
/* Tracking Invoices which have not yet arrived to the expected arrival date

Query Below matches Goods Invoiced Not Yet received with the appropriate Invoice

*/

SELECT 
T1.[RefDate], 
T1.[BaseRef], 
T1.[Ref2] as 'SPASA INV#', 
T1.[ContraAct], 
T1.[LineMemo],
T1.[Debit], 
T1.[Credit], 
T1.[FCDebit], 
T1.[FCCredit], 
T1.[BalDueDeb], 
T1.[BalFcDeb],
A.[ShipDate]

FROM OJDT T0  INNER JOIN JDT1 T1 ON T0.TransId = T1.TransId INNER JOIN OACT T2 ON T1.Account = T2.AcctCode 

LEFT JOIN

(SELECT T0.[CardCode], T0.[CardName],T0.[NumAtCard],  T1.[ShipDate], T0.[DocNum] 
FROM OPCH T0  INNER JOIN PCH1 T1 ON T0.DocEntry = T1.DocEntry 

WHERE T0.[CardCode] = 'SPASA' 
GROUP BY T0.[CardCode], T0.[CardName],T0.[NumAtCard],  T1.[ShipDate], T0.[DocNum])A ON A.[DocNum] = T1.[BaseRef]

WHERE T2.[AcctCode] = '_SYS00000000119'  AND BalDueDeb - BalDueCred != 0
