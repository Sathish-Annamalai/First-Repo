*-----------------------------------------------------------------------------
* <Rating>0</Rating>
*-------------------------
* Description
*
* This enquiry routine will accept the Info Pay Type and if it is UNC, add
* corresponding INFO.PR.AMT
*
*-----------------------------------------------------------------------------
*** <region name= Modification History>
*** <desc>Changes done in the sub-routine</desc>
* Modification History
*
*
* 19/04/12 -  Defect : 365444
*              Task : 368399
*          System does not display UNC amount during projection of AA.PAYOFF.BY.PROPERTY enquiry
*
***</region>
*---------------------------------------------------------------------------------
    $PACKAGE AA.ModelBank
    SUBROUTINE E.AA.GET.BILL.UNC.AMT
    
    $USING AA.PaymentSchedule
    $USING EB.Reports
    

    PAY.TYPE = EB.Reports.getOData()
    CONVERT ' ' TO @VM IN PAY.TYPE
    UNCPROPERTY = 'PAYOFF$UNC'
    IF 'PAYOFF$UNC' MATCHES PAY.TYPE THEN
        LOCATE UNCPROPERTY IN EB.Reports.getRRecord()<AA.PaymentSchedule.BillDetails.BdInfoPayType,1> SETTING PAY.POS THEN
            PAY.AMT = EB.Reports.getRRecord()<AA.PaymentSchedule.BillDetails.BdInfoPrAmt,PAY.POS>
            PAY.AMT = SUM(PAY.AMT)
        END
    END

    EB.Reports.setOData(PAY.AMT)
*
    RETURN
