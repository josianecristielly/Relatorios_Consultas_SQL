SELECT 
		 T0.DocEntry
		,T0.SERIAL AS 'N� NOTA'
		,T1.ItemCode
		,T1.TaxCode
		,T1.CFOPCODE
		,CAST((T1.PRICE * T1.QUANTITY)AS DECIMAL(10,2))AS 'PRE�O'
	 FROM OINV T0
    INNER JOIN INV1 T1 ON T0.DocEntry = T1.DocEntry
	WHERE T0.DocDate BETWEEN [%0] AND [%1]
		AND (T1.CFOPCODE = [%2] OR T1.CFOPCODE =[%3])

