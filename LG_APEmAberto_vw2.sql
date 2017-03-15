USE [SBOPRODEI]
GO

/****** Object:  View [dbo].[LG_APEmAberto_vw2]    Script Date: 14/03/2017 15:33:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER view  [dbo].[LG_APEmAberto_vw2]
AS

/*  

--------------------------------------------------------------------------------    

  Duplicatas    

--------------------------------------------------------------------------------    

*/   

SELECT DISTINCT
	   'TipoDoc'    = 'Duplicata',  

	   'Doc'        = T0.DocNum,   

	   'DocEntry'   = T0.DocEntry,   

       'NroNota'    = T0.Serial,   

       'Install'    = T1.InstlmntID,   

       'DocDate'    = T0.DocDate,   

       'Vencimento' = T1.DueDate,   

       'Prorrogacao'= Convert(Datetime,null),

       'CardCode'   = T0.CardCode,   

       'Nome'       = T0.CardName,   

       'NroAtCard'  = T0.NumAtCard,   

       'PayRef'     = T0.PaymentRef,   

       'Total'      = T1.InsTotal,  

	   'TotalLinha' = t2.LineTotal,
	   
	   'ContaContabil'= t2.AcctCode,

	   'Regra Distr' = T2.OcrCode,

       'Pago'       = T1.PaidToDate,  

       'Posted'     = T0.Posted,  

       'Obs'        = T0.Comments,  

       'NroParcela' = T0.Installmnt,  

       'DocType'    = T0.DocType,   

       'Cancelado'  = T0.CANCELED,   

       'Status'     = T1.Status,

       'BPLId'      = T0.BPLId,

	   'BPLName'    = (select AX.BPLName from OBPL AX where AX.BPLId = T0.BPLid),

	   'DocTotal'   = T0.DocTotal  

  FROM  OPCH T0    

   JOIN PCH6 T1 ON T1.DocEntry = T0.DocEntry     
   JOIN PCH1 T2 ON T2.DOCENTRY = T1.DOCENTRY	

WHERE T0.CardCode like '%'  

  AND T1.TotalBlck <> T1.InsTotal  

  AND T1.Status = 'O'  


  

UNION





/*  

--------------------------------------------------------------------------------    

	Adiantamento contas a Pagar "ODPO"--  

--------------------------------------------------------------------------------    

*/   

SELECT DISTINCT
	   'TipoDoc'    = 'Adiantamento',  

	   'Doc'        = T0.DocNum,   

	   'DocEntry'   = T0.DocEntry,   

       'NroNota'    = T0.Serial,   

       'Install'    = T1.InstlmntID,   

       'DocDate'    = T0.DocDate,   

       'Vencimento' = T1.DueDate,   

       'Prorrogacao'= Convert(Datetime,null),

       'CardCode'   = T0.CardCode,   

       'Nome'       = T0.CardName,   

       'NroAtCard'  = T0.NumAtCard,  

       'PayRef'     = T0.PaymentRef,   

       'Total'      = T1.InsTotal,  

	   'TotalLinha' = T2.LineTotal,

	   'ContaContabil'= t2.AcctCode,

	   'Regra Distr' = T2.OcrCode,

       'Pago'       = T1.PaidToDate,  

       'Posted'     = T0.Posted,  

       'Obs'        = T0.Comments,  

       'NroParcela' = T0.Installmnt,  

       'DocType'    = T0.DocType,   

       'Cancelado'  = T0.CANCELED,   

       'Status'     = T1.Status,

       'BPLId'      = T0.BPLId,

	   'BPLName'    = (select AX.BPLName from OBPL AX where AX.BPLId = T0.BPLid),

	   'DocTotal'   = T0.DocTotal      

 FROM ODPO T0    

      JOIN DPO6 T1  ON  T1.DocEntry = T0.DocEntry    
	  JOIN DPO1 T2  ON  T2.DOCENTRY = T1.DOCENTRY

WHERE T0.CardCode like '%' 

  AND T1.TotalBlck <> T1.InsTotal 

  AND T1.Status = 'O'     



UNION  





/*  

--------------------------------------------------------------------------------    

  Devolu��es    

--------------------------------------------------------------------------------    

*/    

 SELECT DISTINCT
	   'TipoDoc'    = 'Devolucao',  

	   'Doc'        = T0.DocNum,   

	   'DocEntry'   = T0.DocEntry,   

       'NroNota'    = T0.Serial,   

       'Install'    = T1.InstlmntID,   

       'DocDate'    = T0.DocDate,   

       'Vencimento' = T1.DueDate,

       'Prorrogacao'= Convert(Datetime,null),

       'CardCode'   = T0.CardCode,   

       'Nome'       = T0.CardName,   

       'NroAtCard'  = T0.NumAtCard,  

       'PayRef'     = T0.PaymentRef,   

       'Total'      = T1.InsTotal,  

	   'TotalLinha' = T2.LineTotal,

	   'ContaContabil'= t2.AcctCode,

	   'Regra Distr' = T2.OcrCode,


       'Pago'       = T1.PaidToDate,  

       'Posted'     = T0.Posted,  

       'Obs'        = T0.Comments,  

       'NroParcela' = T0.Installmnt,  

       'DocType'    = T0.DocType,   

       'Cancelado'  = T0.CANCELED,   

       'Status'     = T1.Status,

       'BPLId'      = T0.BPLId,

	   'BPLName'    = (select AX.BPLName from OBPL AX where AX.BPLId = T0.BPLid),

	   'DocTotal'   = T0.DocTotal     

 FROM ORPC T0    

 JOIN RPC6 T1 ON T1.DocEntry = T0.DocEntry     
 JOIN RPC1 T2 ON T2.DocEntry = T1.DocEntry

WHERE T0.CardCode like '%'  

  AND T1.TotalBlck <> T1.InsTotal 

  AND T1.Status = 'O' 

  AND NOT EXISTS (SELECT U0.DocEntry FROM RPC1 U0    

                   WHERE (T0.DocEntry = U0.DocEntry AND (U0.BaseType = 18  OR  U0.BaseType = 204)))    

  AND NOT EXISTS (SELECT U0.DocEntry FROM  dbo.RPC3 U0   

				   WHERE (T0.DocEntry = U0.DocEntry AND (U0.BaseType = 18  OR U0.BaseType = 204)))    





UNION

  

/*    

--------------------------------------------------------------------------------    

  LCM  

--------------------------------------------------------------------------------    

*/    

SELECT DISTINCT
	   'TipoDoc'		= 'LCM',  

	   'Doc'			= T0.TransID ,   

	   'DocEntry'		= T0.TransID ,   

       'NroNota'		= T0.TransID ,   

       'Install'		= 1, 

       'DocDate'		= T0.RefDate ,     

       'Vencimento'		= T0.DueDate,  

       'Prorrogacao'	= Convert(Datetime,null),

       'CardCode'		= T0.ShortName ,   

       'Nome'			= T1.CardName,   

       'NroAtCard'		= '', 

       'PayRef'			= '',

       'Total'			= (T0.Credit-T0.Debit) ,  

	   'TotalLina'      = (T0.Credit-T0.Debit), --Convert(NUMERIC(10,2),NULL),

	   'ContaContabil'= t2.Account,

	   'Regra Distr' = '',

       'Pago'			= 0,

       'Posted'			= '',

       'Obs'			= T0.LineMemo,

       'NroParcela'		= 1 ,  

       'DocType'		= T0.Transtype ,   

       'Cancelado'		= 'N',

       'Status'			= 'O',

       'BPLId'			= T0.BPLId,

	   'BPLName'    = (select AX.BPLName from OBPL AX where AX.BPLId = T0.BPLid),

	   'DocTotalTotal'  = (T0.Credit-T0.Debit)     

     FROM JDT1 T0    

     join OCRD T1 on t0.ShortName = T1.CardCode  

           and T1.CardType = 'S'  

Left join ITR1 T2 on T0.TransId = T2.TransId         

left join OITR T3 on T3.ReconNum = T2.ReconNum 

 WHERE ((T0.TransType <> '18' AND T0.TransType <> '204' AND T0.TransType <> '-2' AND T0.TransType <> '24' AND        

         T0.TransType <> '46' AND T0.TransType <> '19'  AND T0.TransType <> '182') OR T0.BatchNum > 0) 

         AND T0.ShortName like '%'  

         AND T0.Closed = 'N'

         AND T0.IntrnMatch = 0 AND (T0.Debit <> 0 OR T0.Credit <> 0)

         AND (T0.SourceLine <> -14 OR T0.SourceLine IS NULL AND (T0.CREDIT > 0)) 

         AND (T0.BalDueCred <> 0 OR T0.BalDueDeb <> 0)         

		 AND isnull(T3.ReconType,0) <> 5 -- Reconcilia��o interna do tipo Anula��o

  

  

  

  

  

UNION  





/*    

--------------------------------------------------------------------------------    

  Boletos    

--------------------------------------------------------------------------------    

*/    

select DISTINCT
	   'TipoDoc'    = 'Boleto',  

       'Doc'        = T0.BoeNum,   

       'DocEntry'   = T3.DocEntry,   

       'NroNota'    = T3.Serial,   

       'Install'    = T2.InstID,   

       'DocDate'    = T3.DocDate,   

       'Vencimento' = T0.DueDate,

       'Prorrogacao'= Convert(Datetime,null),

       'CardCode'   = T0.CardCode,   

       'Nome'       = T0.CardName,   

       'NroAtCard'  = T3.NumAtCard,   

       'PayRef'     = T1.PaymentRef,   

       'Total'      = isnull(T2.SumApplied,T0.BoeSum),  

	   'TotalLinha' = T4.LineTotal,
	 
	   'ContaContabil'= t4.acctcode,

	   'Regra Distr' = isnull(t2.ocrcode,t4.ocrcode),

       'Pago'       = 0,  

       'Posted'     = 'S',  

       'Obs'        = T0.Comments,  

       'NroParcela' = 1,  

       'DocType'    = 'B',   

       'Cancelado'  = '',   

       'Status'     = T0.BoeStatus,

       'BPLId'      = T1.BPLId,

	   'BPLName'    = (select AX.BPLName from OBPL AX where AX.BPLId = T1.BPLid),

	   'DocTotal'   = T0.BoeSum   

	 from OBOE T0    

	 join OVPM T1 on T1.DocEntry = T0.PmntNum   /* Contas a pagar */    

left join VPM2 T2 on T2.DocNum   = T0.PmntNum    

                and T2.InvType  = 18         /* Somente contas a pagar originadas de notas fiscais */    

left join OPCH T3 on T3.DocEntry = T2.DocEntry /* Nota Fiscal */    
left join pch1 t4 on t4.DocEntry = t3.DocEntry
where T0.BoeStatus = 'G'  

  and T0.BoeType = 'O'  
  



GO


