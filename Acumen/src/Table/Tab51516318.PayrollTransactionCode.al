#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516318 "Payroll Transaction Code."
{
    DrillDownPageID = "Payroll Transaction List.";
    LookupPageID = "Payroll Transaction List.";

    fields
    {
        field(10;"Transaction Code";Code[30])
        {
            Editable = true;
        }
        field(11;"Transaction Name";Text[100])
        {
        }
        field(12;"Transaction Type";Option)
        {
            OptionCaption = 'Income,Deduction';
            OptionMembers = Income,Deduction;
        }
        field(13;"Balance Type";Option)
        {
            OptionCaption = 'None,Increasing,Reducing';
            OptionMembers = "None",Increasing,Reducing;
        }
        field(14;Frequency;Option)
        {
            OptionCaption = 'Fixed,Varied';
            OptionMembers = "Fixed",Varied;
        }
        field(15;Taxable;Boolean)
        {
        }
        field(16;"Is Cash";Boolean)
        {
        }
        field(17;"Is Formulae";Boolean)
        {
        }
        field(18;Formulae;Code[50])
        {
        }
        field(19;"Special Transaction";Option)
        {
            OptionCaption = 'Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters,Morgage';
            OptionMembers = Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage;
        }
        field(20;"Amount Preference";Option)
        {
            OptionCaption = 'Posted Amount,Take Higher,Take Lower ';
            OptionMembers = "Posted Amount","Take Higher","Take Lower ";
        }
        field(21;"Deduct Premium";Boolean)
        {
        }
        field(22;"Interest Rate";Decimal)
        {
        }
        field(23;"Repayment Method";Option)
        {
            OptionCaption = 'Reducing,Straight line,Amortized';
            OptionMembers = Reducing,"Straight line",Amortized;
        }
        field(24;"Fringe Benefit";Boolean)
        {
        }
        field(25;"Employer Deduction";Boolean)
        {
        }
        field(26;IsHouseAllowance;Boolean)
        {
        }
        field(27;"Include Employer Deduction";Boolean)
        {
        }
        field(28;"Formulae for Employer";Code[50])
        {
        }
        field(29;"G/L Account";Code[20])
        {
            TableRelation = "G/L Account"."No.";

            trigger OnValidate()
            begin
                  GLAcc.Reset;
                  GLAcc.SetRange(GLAcc."No.","G/L Account");
                  if GLAcc.FindFirst then begin
                    "G/L Account Name":=GLAcc.Name;
                  end;
            end;
        }
        field(30;"G/L Account Name";Text[50])
        {
            Editable = false;
        }
        field(31;"Co-Op Parameters";Option)
        {
            OptionCaption = 'None,Shares,Loan,Loan Interest,Emergency Loan,Emergency Loan Interest,School Fees Loan,School Fees Loan Interest,Welfare,Pension,NSSF,Overtime';
            OptionMembers = "None",Shares,Loan,"Loan Interest","Emergency Loan","Emergency Loan Interest","School Fees Loan","School Fees Loan Interest",Welfare,Pension,NSSF,Overtime;
        }
        field(32;"IsCo-Op/LnRep";Boolean)
        {
        }
        field(33;"Deduct Mortgage";Boolean)
        {
        }
        field(34;SubLedger;Option)
        {
            OptionCaption = ' ,Customer,Vendor';
            OptionMembers = " ",Customer,Vendor;
        }
        field(35;Welfare;Boolean)
        {
        }
        field(36;"Customer Posting Group";Code[20])
        {
        }
        field(37;"Previous Month Filter";Date)
        {
        }
        field(38;"Current Month Filter";Date)
        {
        }
        field(39;"Previous Amount";Decimal)
        {
        }
        field(40;"Current Amount";Decimal)
        {
        }
        field(41;"Previous Amount(LCY)";Decimal)
        {
        }
        field(42;"Current Amount(LCY)";Decimal)
        {
        }
        field(43;"Transaction Category";Option)
        {
            OptionCaption = ' ,Housing,Transport,Other Allowances,NHF,Pension,Company Loan,Housing Deduction,Personal Loan,Inconvinience,Bonus Special,Other Deductions,Overtime,Entertainment,Leave,Utility,Other Co-deductions,Car Loan,Call Duty,Co-op,Lunch,Compassionate Loan';
            OptionMembers = " ",Housing,Transport,"Other Allowances",NHF,Pension,"Company Loan","Housing Deduction","Personal Loan",Inconvinience,"Bonus Special","Other Deductions",Overtime,Entertainment,Leave,Utility,"Other Co-deductions","Car Loan","Call Duty","Co-op",Lunch,"Compassionate Loan";
        }
        field(44;"Employee Code Filter";Code[20])
        {
        }
        field(45;"No. Series";Code[10])
        {
        }
        field(46;Blocked;Boolean)
        {
        }
        field(47;"Exclude in NSSF";Boolean)
        {
        }
        field(48;"Exclude in NHIF";Boolean)
        {
        }
        field(49;"Formula for Management Prov";Code[50])
        {
        }
        field(50;"Transaction Specification";Option)
        {
            OptionCaption = ' ,Leave Allowance,Acting Allowance';
            OptionMembers = " ","Leave Allowance","Acting Allowance";
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
        fieldgroup("FieldGroup";"Transaction Code","Transaction Name")
        {
        }
        fieldgroup(DropDown;"Transaction Code","Transaction Name")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Transaction Code" = '' then begin
         if "Transaction Type"="transaction type"::Income then begin
          Setup.Get;
          Setup.TestField(Setup."Earnings No");
          NoSeriesMgt.InitSeries(Setup."Earnings No",xRec."No. Series",0D,"Transaction Code","No. Series");
         end;
         if "Transaction Type"="transaction type"::Deduction then begin
          Setup.Get;
          Setup.TestField(Setup."Deductions No");
          NoSeriesMgt.InitSeries(Setup."Deductions No",xRec."No. Series",0D,"Transaction Code","No. Series");
         end;
        end;
    end;

    var
        Setup: Record "Payroll General Setup.";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GLAcc: Record "G/L Account";
}

