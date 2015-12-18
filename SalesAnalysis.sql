--Sap Business One - SQL Server 2008
---Sales Report -> (Wholesale)

--Tables
OINV	-- AR Invoice Header
INV1	-- AR Invoice Line Item
ORIN	-- AR Credit Note Header
RIN1	-- AR Credit line Item
OITM	-- Item Master Data
OCRD	-- Business Partner Master Data

-- Maybe add?
OACT	-- General Ledger Table
OJDT	-- Journal Header
JDT1	-- Journal Line item



/*
Notes
-Take into Account Discounts with Invoices
-Include COGS?(Gross Profit Base Price)
-
*/
select
S.[Type],
B.slpName,
S.[CardCode],
S.[CardName],
B.[AliasName],
S.[DocNum],
S.[Posting_Date],
S.[Document_Date],
S.[DocType],
S.[ItemCode],
I.ItemCode,
I.ItemName,
I.itmsGrpCod,
I.U_Type,
I.U_Style,
I.U_Gender,
I.U_Season,
I.U_SkewName,
I.U_Item_Group,
I.U_Item_Sizes,
I.U_Item_Range,
I.U_QtyPairsUnit,
I.U_PacksPairsRatio,
I.U_CurrentSeason,
I.U_FutureSeason,
S.[Dscription],
S.[Quantity],
S.[PriceBefDi],
S.[LineTotal],
S.[DiscPrcnt],
S.[Discount_Amount],
S.[Sales],
S.[Unit_COGS],
S.[Total_COGS],
S.[Net_Profit]


FROM

(
-- AR Invoice
Select
'INV' as Type,
T0.CardCode,
T0.CardName,
T0.DocNum,
T0.DocDate as 'Posting_Date',
T0.TaxDate as 'Document_Date',
T0.DocType,
T1.ItemCode,
T1.Dscription,
T1.Quantity,
T1.PriceBefDi,
T1.LineTotal,
T0.DiscPrcnt,
(T1.LineTotal * (T1.DiscPrcnt/100)) as 'Discount_Amount',
T1.LineTotal - (T1.LineTotal * (T0.DiscPrcnt/100)) as 'Sales',
T1.GrossBuyPr as 'Unit_COGS',
T1.[GPTtlBasPr] as 'Total_COGS',
T1.LineTotal - (T1.LineTotal * (T0.DiscPrcnt/100)) - T1.[GPTtlBasPr] as 'Net_Profit'


FROM OINV T0 INNER JOIN INV1 T1 ON T0.DocEntry = T1.DocEntry

WHERE T0.[CANCELED] = 'N' AND T0.DocDate >= '2014-07-01' AND T0.DocDate <= '2015-06-30'

UNION ALL


---Credit Note
Select
'CN' as Type,
T0.CardCode,
T0.CardName,
T0.DocNum,
T0.DocDate as 'Posting_Date',
T0.TaxDate as 'Document_Date',
T0.DocType,
T1.ItemCode,
T1.Dscription,
T1.Quantity,
T1.PriceBefDi,
-T1.LineTotal,
T0.DiscPrcnt,
(T1.LineTotal * (T1.DiscPrcnt/100)) as 'Discount_Amount',
-(T1.LineTotal - (T1.LineTotal * (T0.DiscPrcnt/100))) as 'Sales',
T1.GrossBuyPr as 'Unit_COGS',
T1.[GPTtlBasPr] as 'Total_COGS',
-(T1.LineTotal - (T1.LineTotal * (T0.DiscPrcnt/100)) - T1.[GPTtlBasPr]) as 'Net_Profit'


FROM ORIN T0 INNER JOIN RIN1 T1 ON T0.DocEntry = T1.DocEntry

WHERE T0.[CANCELED] = 'N' AND T0.DocDate >= '2014-07-01' AND T0.DocDate <= '2015-06-30'
)S

LEFT JOIN

(
-- Business Partner
select
T1.CardCode,
T1.AliasName,
T2.slpName,
T1.CardType,
T1.GroupCode

From OCRD T1 
INNER JOIN OSLP T2 ON T1.slpcode = T2.slpcode 
INNER JOIN OCRG T3 ON T1.GroupCode = T3.GroupCode

) B ON S.CardCode = B.CardCode


LEFT JOIN
(
---- Item Master Data 
SELECT 

ItemCode,
ItemName,
itmsGrpCod,
U_Type,
U_Style,
U_Gender,
U_Season,
U_SkewName,
U_Item_Group,
U_Item_Sizes,
U_Item_Range,
U_QtyPairsUnit,
U_PacksPairsRatio,
U_CurrentSeason,
U_FutureSeason

FROM oitm

)I ON S.ItemCode = I.ItemCode

where B.CardType = 'C' and B.GroupCode = '104'
