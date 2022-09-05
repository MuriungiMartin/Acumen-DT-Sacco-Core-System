#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516901 "Savings Main Control Buffer"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Transaction Description"; Code[60])
        {
        }
        field(6; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(7; "Debit Amount"; Decimal)
        {
            // CalcFormula = sum("Detailed Vendor Ledg. Entry"."Debit Amount" where (=field("Transaction Type"),
            //                                                                       "Posting Date"=field("Date Filter")));
            // FieldClass = FlowField;
        }
        field(8; "Credit Amount"; Decimal)
        {
            // CalcFormula = sum("Detailed Vendor Ledg. Entry"."Credit Amount" where (Field51516001=field("Transaction Type"),
            //                                                                        "Posting Date"=field("Date Filter")));
            // FieldClass = FlowField;
        }
        field(9; "Transaction Type"; Option)
        {
            OptionCaption = ' ,CashWithdrawal,CashDeposit,ChequeDeposit,CashWithdrawalCommission,ChequeDepositComission,InternalTransfers,BOSALoanPayment,BOSAPayout,LoansIssued,ATMTransactions,ATMCharges,StandingOrders,ExciseDuty,StampDuty,POSTransactions,POSTransactionCharges,MobileTransactions,MobileTransactionCharges,BankersCheques,BankersChequeCommission,SalaryProcessing,SalaryProcessingFee,SMS,ChequeWithdrawal,ChequeWithdrawalCommission';
            OptionMembers = " ",CashWithdrawal,CashDeposit,ChequeDeposit,CashWithdrawalCommission,ChequeDepositComission,InternalTransfers,BOSALoanPayment,BOSAPayout,LoansIssued,ATMTransactions,ATMCharges,StandingOrders,ExciseDuty,StampDuty,POSTransactions,POSTransactionCharges,MobileTransactions,MobileTransactionCharges,BankersCheques,BankersChequeCommission,SalaryProcessing,SalaryProcessingFee,SMS,ChequeWithdrawal,ChequeWithdrawalCommission;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

