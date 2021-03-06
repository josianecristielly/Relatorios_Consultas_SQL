-----criação tabela aux--------------


	CREATE TABLE PRODUTOS_GENIOS (
		 PG_ID INT IDENTITY(1,1) PRIMARY KEY
		,PG_NOME_CLIENTE NVARCHAR (250)
		,PG_NOMEF_CLIENTE NVARCHAR (250)
		,PG_CARDCODE NVARCHAR(30)
		,PG_CNPJ NVARCHAR(20)
		,PG_LOG NVARCHAR(100)
		,PG_RUA NVARCHAR (100)
		,PG_NUMERO NVARCHAR(100)
		,PG_BAIRRO NVARCHAR(100)
		,PG_CIDADE NVARCHAR(100)
		,PG_ESTADO NVARCHAR(100)
		,PG_CEP NVARCHAR(100)
		,PG_EMAIL NVARCHAR(100)
		,PG_DATA_NOTA DATE
		,PG_NUMERO_NOTA INT
		,PG_NUMERO_DOC INT
		,PG_NUMERO_DOC_BASE INT
		,PG_SERIE NVARCHAR(25)
		,PG_CODIGO_ITEM NVARCHAR (50)
		,PG_DESC_ITEM NVARCHAR(60)
		,PG_ABV_ITEM NVARCHAR(15)
		,PG_QTD_VENDA INT
		,PG_QTD_DEV INT
		,PG_QTD_CONF INT
		,PG_STATUS INT
		,PG_CANCELED NVARCHAR(2)
)
 

SELECT * FROM PRODUTOS_GENIOS

DROP TABLE PRODUTOS_GENIOS


		

------------------------------------procedure nota saida-----------------------------------------------

if @object_type = '13' and @transaction_type ='A'
BEGIN
DECLARE 
		 @PG_NOME_CLIENTE NVARCHAR (255)
		,@PG_NOMEF_CLIENTE NVARCHAR (255)
		,@PG_CARDCODE NVARCHAR(255)
		,@PG_CNPJ NVARCHAR(255)
		,@PG_LOG NVARCHAR(255)
		,@PG_RUA NVARCHAR (255)
		,@PG_NUMERO NVARCHAR(255)
		,@PG_BAIRRO NVARCHAR(255)
		,@PG_CIDADE NVARCHAR(255)
		,@PG_ESTADO NVARCHAR(255)
		,@PG_CEP NVARCHAR(255)
		,@PG_EMAIL NVARCHAR(255)
		,@PG_DATA_NOTA DATE
		,@PG_NUMERO_NOTA INT
		,@PG_NUMERO_DOC INT
		,@PG_NUMERO_DOC_BASE INT
		,@PG_SERIE NVARCHAR (255)
		,@PG_CODIGO_ITEM NVARCHAR (255)
		,@PG_DESC_ITEM NVARCHAR(255)
		,@PG_ABV_ITEM NVARCHAR(255)
		,@PG_QTD_VENDA INT
		,@PG_QTD_DEV INT
		,@PG_STATUS INT
		,@PG_CANCELED NVARCHAR(255)
		,@CONT INT
		,@LineNum INT
		,@CONSULTOR NVARCHAR(255)
		,@PROPRIO NVARCHAR(255)

		SET @CONT = (SELECT COUNT(1) FROM INV1 WHERE DOCENTRY = @list_of_cols_val_tab_del)
		SET @LineNum = 0
		SET @CONSULTOR = (SELECT CL.QryGroup48 FROM OCRD CL WHERE CL.CARDCODE =  @list_of_cols_val_tab_del)
		SET @PROPRIO =   (SELECT CL.QryGroup64 FROM OCRD CL WHERE CL.CARDCODE =  @list_of_cols_val_tab_del)
		
		IF (@CONSULTOR = 'N' OR @PROPRIO = 'N')
		BEGIN

		WHILE @LineNum < @CONT
		BEGIN
				SELECT @PG_NOME_CLIENTE = T1.CARDNAME
					 , @PG_NOMEF_CLIENTE =(SELECT CARDFNAME FROM OCRD OC WHERE OC.CARDCODE = T1.CARDCODE)
					 , @PG_CARDCODE = T1.CARDCODE
					 , @PG_LOG = (SELECT ADDRTYPE FROM CRD1 C1 WHERE C1.CARDCODE = T1.CARDCODE and C1.adresType = 'S')
					 , @PG_RUA = (SELECT STREET FROM CRD1 C1 WHERE C1.CARDCODE = T1.CARDCODE and C1.adresType = 'S')
					 , @PG_NUMERO = (SELECT STREETNO FROM CRD1 C1 WHERE C1.CARDCODE = T1.CARDCODE and C1.adresType = 'S')
					 , @PG_BAIRRO = (SELECT Block FROM CRD1 C1 WHERE C1.CARDCODE = T1.CARDCODE and C1.adresType = 'S')
					 , @PG_CIDADE = (SELECT CITY FROM CRD1 C1 WHERE C1.CARDCODE = T1.CARDCODE and C1.adresType = 'S')
					 , @PG_ESTADO = (SELECT STATE FROM CRD1 C1 WHERE C1.CARDCODE = T1.CARDCODE and C1.adresType = 'S')
					 , @PG_CEP = (SELECT ZipCode FROM CRD1 C1 WHERE C1.CARDCODE = T1.CARDCODE and C1.adresType = 'S')
					 , @PG_EMAIL = (SELECT E_MAIL FROM OCRD CD WHERE CD.CARDCODE = T1.CARDCODE)
					 , @PG_CNPJ = T1.LicTradNUm
					 , @PG_DATA_NOTA = T1.DOCDATE
					 , @PG_NUMERO_NOTA =  T1.SERIAL
					 , @PG_NUMERO_DOC = T1.DOCNUM
					 , @PG_NUMERO_DOC_BASE = T0.BaseEntry
					 , @PG_CODIGO_ITEM  = T0.ITEMCODE
					 , @PG_DESC_ITEM    = T0.DSCRIPTION
					 , @PG_ABV_ITEM = (SELECT FRGNNAME FROM OITM WHERE ITEMCODE = T0.ITEMCODE)
					 , @PG_QTD_VENDA = T0.QUANTITY
					 , @PG_CANCELED = T1.CANCELED
					 			 

					 FROM INV1  T0
					  INNER JOIN OINV T1 ON T0.DOCENTRY = T1.DOCENTRY 
					  INNER JOIN OITM T2 ON T0.ITEMCODE = T2.ITEMCODE
					  WHERE T1.DocEntry = @list_of_cols_val_tab_del
					  and LineNum = @LineNum
					
					IF @PG_CODIGO_ITEM = (SELECT ITEMCODE FROM OITM WHERE ITEMCODE = @PG_CODIGO_ITEM AND QryGroup25 ='Y')
						BEGIN
							SET @PG_STATUS = 1;

							DECLARE 
									@QryGroup2 NVARCHAR(1),@QryGroup3 NVARCHAR(1),@QryGroup4 NVARCHAR(1), @QryGroup5 NVARCHAR(1),@QryGroup6 NVARCHAR(1),
									@QryGroup7 NVARCHAR(1),	@QryGroup8 NVARCHAR(1),	@QryGroup9 NVARCHAR(1),@QryGroup10 NVARCHAR(1),
									@QryGroup11 NVARCHAR(1),@QryGroup12 NVARCHAR(1),@QryGroup13 NVARCHAR(1),@QryGroup14 NVARCHAR(1)

		
								  SELECT @QryGroup2 = QryGroup2,@QryGroup3 = QryGroup3,@QryGroup4 = QryGroup4,@QryGroup5 =QryGroup5,@QryGroup6 =QryGroup6,@QryGroup7 =QryGroup7,
										 @QryGroup8 = QryGroup8,@QryGroup9 = QryGroup9,@QryGroup10 = QryGroup10,@QryGroup11 = QryGroup11,@QryGroup12 =QryGroup12,
										 @QryGroup13 =QryGroup13,@QryGroup14 =QryGroup14
										 FROM OITM where ItemCode = @PG_CODIGO_ITEM

										   IF (@QryGroup2 = 'Y') BEGIN SET @PG_SERIE ='2EI'   END 
										   IF (@QryGroup3 = 'Y') BEGIN SET @PG_SERIE ='1EF'   END 
										   IF (@QryGroup4 = 'Y') BEGIN SET @PG_SERIE ='2EF'   END 
										   IF (@QryGroup5 = 'Y') BEGIN SET @PG_SERIE ='3EF'   END 
										   IF (@QryGroup6 = 'Y') BEGIN SET @PG_SERIE ='4EF'   END 
										   IF (@QryGroup7 = 'Y') BEGIN SET @PG_SERIE ='5EF'   END 
										   IF (@QryGroup8 = 'Y') BEGIN SET @PG_SERIE ='6EF'   END 
										   IF (@QryGroup9 = 'Y') BEGIN SET @PG_SERIE ='7EF'   END 
										   IF (@QryGroup10 = 'Y') BEGIN SET @PG_SERIE ='8EF'  END 
										   IF (@QryGroup11 = 'Y') BEGIN SET @PG_SERIE ='9EF'  END 
										   IF (@QryGroup12 = 'Y') BEGIN SET @PG_SERIE ='1EM'  END 
										   IF (@QryGroup13 = 'Y') BEGIN SET @PG_SERIE ='2EM'  END 
										   IF (@QryGroup14 = 'Y') BEGIN SET @PG_SERIE ='3EM'  END 

							     		    INSERT INTO PRODUTOS_GENIOS (PG_NOME_CLIENTE,PG_NOMEF_CLIENTE,PG_CARDCODE,PG_CNPJ,PG_LOG,PG_RUA,PG_NUMERO,PG_BAIRRO,PG_CIDADE,PG_ESTADO,PG_CEP,PG_EMAIL,PG_DATA_NOTA,PG_NUMERO_NOTA,PG_NUMERO_DOC,PG_NUMERO_DOC_BASE,PG_SERIE,PG_CODIGO_ITEM, PG_DESC_ITEM,PG_ABV_ITEM,PG_QTD_VENDA,PG_QTD_DEV,PG_QTD_CONF,PG_STATUS,PG_CANCELED) 
									        VALUES (@PG_NOME_CLIENTE,@PG_NOMEF_CLIENTE,@PG_CARDCODE,@PG_CNPJ,@PG_LOG ,@PG_RUA,@PG_NUMERO,@PG_BAIRRO,@PG_CIDADE,@PG_ESTADO,@PG_CEP,@PG_EMAIL,@PG_DATA_NOTA,@PG_NUMERO_NOTA,@PG_NUMERO_DOC,@PG_NUMERO_DOC_BASE,@PG_SERIE,@PG_CODIGO_ITEM,@PG_DESC_ITEM,@PG_ABV_ITEM,@PG_QTD_VENDA,0,@PG_QTD_VENDA,@PG_STATUS,@PG_CANCELED);
											
								END
										SET @LineNum = @LineNum +1;
							 END	
			END
		END

----------------------------------procedure nota dev-----------------------------------------------


if @object_type = '14' and @transaction_type ='A'
BEGIN

		SET @CONT = (SELECT COUNT(1) FROM RIN1 WHERE DOCENTRY =  @list_of_cols_val_tab_del)
		SET @LineNum = 0
		SET @CONSULTOR = (SELECT CL.QryGroup48 FROM OCRD CL WHERE CL.CARDCODE =  @list_of_cols_val_tab_del)
		SET @PROPRIO =   (SELECT CL.QryGroup64 FROM OCRD CL WHERE CL.CARDCODE =  @list_of_cols_val_tab_del)
		
		IF (@CONSULTOR = 'N' OR @PROPRIO = 'N')
		BEGIN


		WHILE @LineNum < @CONT
		BEGIN
				SELECT @PG_NOME_CLIENTE = T1.CARDNAME
					 , @PG_NOMEF_CLIENTE =(SELECT CARDFNAME FROM OCRD OC WHERE OC.CARDCODE = T1.CARDCODE)
					 , @PG_CARDCODE = T1.CARDCODE
					 , @PG_LOG = (SELECT ADDRTYPE FROM CRD1 C1 WHERE C1.CARDCODE = T1.CARDCODE and C1.adresType = 'S')
					 , @PG_RUA = (SELECT STREET FROM CRD1 C1 WHERE C1.CARDCODE = T1.CARDCODE and C1.adresType = 'S')
					 , @PG_NUMERO = (SELECT STREETNO FROM CRD1 C1 WHERE C1.CARDCODE = T1.CARDCODE and C1.adresType = 'S')
					 , @PG_BAIRRO = (SELECT Block FROM CRD1 C1 WHERE C1.CARDCODE = T1.CARDCODE and C1.adresType = 'S')
					 , @PG_CIDADE = (SELECT CITY FROM CRD1 C1 WHERE C1.CARDCODE = T1.CARDCODE and C1.adresType = 'S')
					 , @PG_ESTADO = (SELECT STATE FROM CRD1 C1 WHERE C1.CARDCODE = T1.CARDCODE and C1.adresType = 'S')
					 , @PG_CEP = (SELECT ZipCode FROM CRD1 C1 WHERE C1.CARDCODE = T1.CARDCODE and C1.adresType = 'S')
					 , @PG_EMAIL = (SELECT E_MAIL FROM OCRD CD WHERE CD.CARDCODE = T1.CARDCODE)
					 , @PG_CNPJ = T1.LicTradNUm
					 , @PG_DATA_NOTA = T1.DOCDATE
					 , @PG_NUMERO_NOTA =  T1.SERIAL
					 , @PG_NUMERO_DOC = T1.DOCNUM
					 , @PG_NUMERO_DOC_BASE = T0.BaseEntry
					 , @PG_CODIGO_ITEM  = T0.ITEMCODE
					 , @PG_DESC_ITEM    = T0.DSCRIPTION
					 , @PG_ABV_ITEM = (SELECT FRGNNAME FROM OITM WHERE ITEMCODE = T0.ITEMCODE)
					 , @PG_QTD_DEV = T0.QUANTITY
					 , @PG_CANCELED = T1.CANCELED
			 

					 FROM RIN1  T0
					  INNER JOIN ORIN T1 ON T0.DOCENTRY = T1.DOCENTRY 
					  INNER JOIN OITM T2 ON T0.ITEMCODE = T2.ITEMCODE
					  WHERE T1.DocEntry =  @list_of_cols_val_tab_del
					  and LineNum = @LineNum
					
					IF @PG_CODIGO_ITEM = (SELECT ITEMCODE FROM OITM WHERE ITEMCODE = @PG_CODIGO_ITEM AND QryGroup25 ='Y')
						BEGIN
							SET @PG_STATUS = 2;

								
								  SELECT @QryGroup2 = QryGroup2,@QryGroup3 = QryGroup3,@QryGroup4 = QryGroup4,@QryGroup5 =QryGroup5,@QryGroup6 =QryGroup6,@QryGroup7 =QryGroup7,
										 @QryGroup8 = QryGroup8,@QryGroup9 = QryGroup9,@QryGroup10 = QryGroup10,@QryGroup11 = QryGroup11,@QryGroup12 =QryGroup12,
										 @QryGroup13 =QryGroup13,@QryGroup14 =QryGroup14
										 FROM OITM where ItemCode = @PG_CODIGO_ITEM

										   IF (@QryGroup2 = 'Y') BEGIN SET @PG_SERIE ='2EI'   END 
										   IF (@QryGroup3 = 'Y') BEGIN SET @PG_SERIE ='1EF'   END 
										   IF (@QryGroup4 = 'Y') BEGIN SET @PG_SERIE ='2EF'   END 
										   IF (@QryGroup5 = 'Y') BEGIN SET @PG_SERIE ='3EF'   END 
										   IF (@QryGroup6 = 'Y') BEGIN SET @PG_SERIE ='4EF'   END 
										   IF (@QryGroup7 = 'Y') BEGIN SET @PG_SERIE ='5EF'   END 
										   IF (@QryGroup8 = 'Y') BEGIN SET @PG_SERIE ='6EF'   END 
										   IF (@QryGroup9 = 'Y') BEGIN SET @PG_SERIE ='7EF'   END 
										   IF (@QryGroup10 = 'Y') BEGIN SET @PG_SERIE ='8EF'  END 
										   IF (@QryGroup11 = 'Y') BEGIN SET @PG_SERIE ='9EF'  END 
										   IF (@QryGroup12 = 'Y') BEGIN SET @PG_SERIE ='1EM'  END 
										   IF (@QryGroup13 = 'Y') BEGIN SET @PG_SERIE ='2EM'  END 
										   IF (@QryGroup14 = 'Y') BEGIN SET @PG_SERIE ='3EM'  END 

										    INSERT INTO PRODUTOS_GENIOS (PG_NOME_CLIENTE,PG_NOMEF_CLIENTE,PG_CARDCODE,PG_CNPJ,PG_LOG,PG_RUA,PG_NUMERO,PG_BAIRRO,PG_CIDADE,PG_ESTADO,PG_CEP,PG_EMAIL,PG_DATA_NOTA,PG_NUMERO_NOTA,PG_NUMERO_DOC,PG_NUMERO_DOC_BASE,PG_SERIE, PG_CODIGO_ITEM, PG_DESC_ITEM,PG_ABV_ITEM,PG_QTD_VENDA,PG_QTD_DEV,PG_QTD_CONF,PG_STATUS,PG_CANCELED) 
									        VALUES (@PG_NOME_CLIENTE,@PG_NOMEF_CLIENTE,@PG_CARDCODE,@PG_CNPJ,@PG_LOG ,@PG_RUA,@PG_NUMERO,@PG_BAIRRO,@PG_CIDADE,@PG_ESTADO,@PG_CEP,@PG_EMAIL,@PG_DATA_NOTA,@PG_NUMERO_NOTA,@PG_NUMERO_DOC,@PG_NUMERO_DOC_BASE,@PG_SERIE,@PG_CODIGO_ITEM,@PG_DESC_ITEM,@PG_ABV_ITEM,0,@PG_QTD_DEV,@PG_QTD_DEV,@PG_STATUS,@PG_CANCELED);
										

								END
										SET @LineNum = @LineNum +1;
							END	
					END
		END