#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516340 "prTransaction Codes"
{
    DataCaptionFields = "Transaction Name";
    DrillDownPageID = "HR Leave Types Card";
    LookupPageID = "HR Leave Types Card";

    fields
    {
        field(1;"Transaction Code";Code[50])
        {
            Description = 'Unique Trans line code';
        }
        field(3;"Transaction Name";Text[100])
        {
            Description = 'Description';

            trigger OnValidate()
            begin

                TestNoEntriesExist(FieldCaption("Transaction Name"));
            end;
        }
        field(4;"Balance Type";Option)
        {
            Description = 'None,Increasing,Reducing';
            OptionMembers = "None",Increasing,Reducing;
        }
        field(5;"Transaction Type";Option)
        {
            Description = 'Income,Deduction';
            OptionMembers = Income,Deduction;
        }
        field(6;Frequency;Option)
        {
            Description = 'Fixed,Varied';
            OptionMembers = "Fixed",Varied;
        }
        field(7;"Is Cash";Boolean)
        {
            Description = 'Does staff receive cash for this transaction';
        }
        field(8;Taxable;Boolean)
        {
            Description = 'Is it taxable or not';
        }
        field(9;"Is Formula";Boolean)
        {
            Description = 'Is the transaction based on a formula';
        }
        field(10;Formula;Text[200])
        {
            Description = '[Formula] If the above field is "Yes", give the formula';
        }
        field(16;"Amount Preference";Option)
        {
            Description = 'Either (Posted Amount), (Take Higher) or (Take Lower)';
            OptionMembers = "Posted Amount","Take Higher","Take Lower ";
        }
        field(18;"Special Transactions";Option)
        {
            Description = 'Represents all Special Transactions';
            OptionCaption = 'Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,Owner Occupier Interest,Prescribed Benefit,Salary Arrears,StaffLoan,Value of Quarters,Morgage,staff loan';
            OptionMembers = Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears",StaffLoan,"Value of Quarters",Morgage,"staff loan";
        }
        field(21;"Deduct Premium";Boolean)
        {
            Description = '[Insurance] Should the Premium be treated as a payroll deduction?';
        }
        field(26;"Interest Rate";Decimal)
        {
            Description = '[Loan] If above is "Yes", give the interest rate';
        }
        field(28;"Repayment Method";Option)
        {
            Description = '[Loan] Reducing,Straight line,Amortized';
            OptionCaption = 'Reducing,Straight line,Amortized';
            OptionMembers = Reducing,"Straight line",Amortized;
        }
        field(29;"Fringe Benefit";Boolean)
        {
            Description = '[Loan] should the loan be treated as a Fringe Benefit?';
        }
        field(30;"Employer Deduction";Boolean)
        {
            Description = 'Caters for Employer Deductions';
        }
        field(31;isHouseAllowance;Boolean)
        {
            Description = 'Flags if its house allowance - Dennis';
        }
        field(32;"Include Employer Deduction";Boolean)
        {
            Description = 'Is the transaction to include the employer deduction? - Dennis';
        }
        field(33;"Is Formula for employer";Text[200])
        {
            Description = '[Is Formula for employer] If the above field is "Yes", give the Formula for employer Dennis';
        }
        field(34;"Transaction Code old";Code[50])
        {
            Description = 'Old Unique Trans line code - Dennis';
        }
        field(35;"GL Account";Code[50])
        {
            Description = 'to post to GL account - Dennis';
            TableRelation = "G/L Account"."No.";
        }
        field(36;"GL Employee Account";Code[50])
        {
            Description = 'to post to GLemployee  account - Dennis';
        }
        field(37;"coop parameters";Option)
        {
            Caption = 'Other Categorization';
            Description = 'to be able to report the different coop contributions -Dennis';
            OptionCaption = 'None,Shares,Loan,Loan Interest,Emergency Loan,Emergency Loan Interest,School Fees Loan,School Fees Loan Interest,Welfare,Pension,NSSF,Overtime,Security Fund,Risk Fund,NHIF';
            OptionMembers = "None",Shares,Loan,"Loan Interest","Emergency Loan","Emergency Loan Interest","School Fees Loan","School Fees Loan Interest",Welfare,Pension,NSSF,Overtime,"Security Fund","Risk Fund",NHIF;
        }
        field(38;"IsCoop/LnRep";Boolean)
        {
            Description = 'to be able to report the different coop contributions -Dennis';
        }
        field(39;"Deduct Mortgage";Boolean)
        {
        }
        field(40;Subledger;Option)
        {
            OptionMembers = " ",Customer,Vendor,Member,"G/L Account";
        }
        field(41;Welfare;Boolean)
        {
        }
        field(42;CustomerPostingGroup;Code[20])
        {
            TableRelation = "Customer Posting Group".Code;
        }
    }

    keys
    {
        key(Key1;"Transaction Code")
        {
            Clustered = true;
        }
        key(Key2;"Transaction Name")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Transaction Code","Transaction Name")
        {
        }
    }

    trigger OnDelete()
    begin
        TestNoEntriesExist(FieldCaption("Transaction Name"));
    end;

    trigger OnRename()
    begin
        TestNoEntriesExist(FieldCaption("Transaction Name"));
    end;

    var
        Text000: label 'Its not possible to change the transaction name once used in previous Payroll periods. Please Contact the systems Administrator.';


    procedure TestNoEntriesExist(CurrentFieldName: Text[100])
    var
        PeriodTrans: Record "prPension Details";
    begin
        /*
          //To prevent change of field
         PeriodTrans.SETCURRENTKEY(PeriodTrans."Transaction Name");
         PeriodTrans.SETRANGE(PeriodTrans."Transaction Name","Transaction Name");
        
        IF PeriodTrans.FIND('-') THEN
          ERROR(
          Text000,
           CurrentFieldName);
           */

    end;
}

