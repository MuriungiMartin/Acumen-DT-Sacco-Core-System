#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516267 "prEmployee Transactions"
{

    fields
    {
        field(1;"Employee Code";Code[30])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(2;"Transaction Code";Code[30])
        {
            TableRelation = "Payroll Transaction Code."."Transaction Code";

            trigger OnValidate()
            begin


                blnIsLoan:=false;
                if objTransCodes.Get("Transaction Code") then
                  "Transaction Name":=objTransCodes."Transaction Name";
                  "Payroll Period":=SelectedPeriod;
                  "Period Month":=PeriodMonth;
                  "Period Year":=PeriodYear;
                  if objTransCodes."Special Transactions"=8 then blnIsLoan:=true;
            end;
        }
        field(3;"Transaction Name";Text[100])
        {
        }
        field(4;Amount;Decimal)
        {
        }
        field(5;Balance;Decimal)
        {
        }
        field(6;"Original Amount";Decimal)
        {
        }
        field(7;"Period Month";Integer)
        {
        }
        field(8;"Period Year";Integer)
        {
        }
        field(9;"Payroll Period";Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(10;"#of Repayments";Integer)
        {
        }
        field(11;Membership;Code[20])
        {
        }
        field(12;"Reference No";Text[100])
        {
        }
        field(13;integera;Integer)
        {
        }
        field(14;"Employer Amount";Decimal)
        {
        }
        field(15;"Employer Balance";Decimal)
        {
        }
        field(16;"Stop for Next Period";Boolean)
        {
        }
        field(17;"Amortized Loan Total Repay Amt";Decimal)
        {
        }
        field(18;"Start Date";Date)
        {
        }
        field(19;"End Date";Date)
        {
        }
        field(20;"Loan Number";Code[16])
        {
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(21;"Payroll Code";Code[20])
        {
            TableRelation = "prPayroll Type";
        }
        field(22;"No of Units";Decimal)
        {
        }
        field(23;Suspended;Boolean)
        {
        }
        field(24;"Transaction Type";Option)
        {
            OptionCaption = ' ,Registration Fee,Loan,Repayment,Withdrawal,Interest Due,Interest Paid,Benevolent Fund,Deposit Contribution,Loan Penalty,Application Fee,Appraisal Fee,Investment,Unallocated Funds,Share Capital,Loan Adjustment,Dividend,Withholding Tax,Administration Fee,Welfare Contribution 2,Prepayment,Withdrawable Deposits,Domant Share Capital,Interest ADJ';
            OptionMembers = " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Loan Penalty","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Share Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Welfare Contribution 2",Prepayment,"Withdrawable Deposits","Domant Share Capital","Interest ADJ";
        }
        field(25;"Loan Account No";Code[30])
        {
        }
        field(26;"Emp Count";Integer)
        {
            CalcFormula = count("HR Employees" where ("No."=field("Employee Code"),
                                                      Status=filter(Active)));
            FieldClass = FlowField;
        }
        field(27;"PV Filter";Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(28;"Emp Status";Option)
        {
            CalcFormula = lookup("HR Employees".Status where ("No."=field("Employee Code")));
            FieldClass = FlowField;
            OptionCaption = 'Normal,Resigned,Discharged,Retrenched,Pension,Disabled';
            OptionMembers = Normal,Resigned,Discharged,Retrenched,Pension,Disabled;
        }
    }

    keys
    {
        key(Key1;"Employee Code","Transaction Code","Period Month","Period Year","Payroll Period","Reference No")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
        key(Key2;"Employee Code","Transaction Code","Period Month","Period Year",Suspended)
        {
        }
    }

    fieldgroups
    {
    }

    var
        Transcode: Record "prTransaction Codes";
        objTransCodes: Record "prTransaction Codes";
        SelectedPeriod: Date;
        objPeriod: Record "prPayroll Periods";
        PeriodName: Text[30];
        PeriodTrans: Record "prPeriod Transactions";
        PeriodMonth: Integer;
        PeriodYear: Integer;
        blnIsLoan: Boolean;
        objEmpTrans: Record "prEmployee Transactions";
        transType: Text[30];
        objOcx: Codeunit prPayrollProcessingXX;
        strExtractedFrml: Text[30];
        curTransAmount: Decimal;
        empCode: Text[30];
}

