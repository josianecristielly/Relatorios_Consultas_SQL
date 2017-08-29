
SELECT 
	 T0.ITEMCODE
	,T0.ITEMNAME
	,CAST(T1.PRICE AS DECIMAL(10,2)) AS PRECO_UNITARIO
	,CAST(T1.QUANTITY AS INT) AS QUANTIDADE 
	--,(T1.PRICE/T1.Quantity) VALOR_AQUI
	,T1.DocEntry

FROM  OITM T0
LEFT JOIN PCH1 T1 ON T0.ITEMCODE = T1.ITEMCODE
WHERE T0.Series in (61)

ORDER BY T0.ITEMCODE