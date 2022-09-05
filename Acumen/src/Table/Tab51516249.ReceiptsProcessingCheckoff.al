#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516249 "ReceiptsProcessing. Checkoff"
{

    fields
    {
        field(1; "Staff/Payroll No"; Code[20])
        {
        }
        field(2; Amount; Decimal)
        {
        }
        field(3; "No Repayment"; Boolean)
        {
        }
        field(4; "Staff Not Found"; Boolean)
        {
        }
        field(5; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(6; "Transaction Date"; Date)
        {
        }
        field(8; Generated; Boolean)
        {
        }
        field(9; "Payment No"; Integer)
        {
        }
        field(10; Posted; Boolean)
        {
        }
        field(11; "Multiple Receipts"; Boolean)
        {
        }
        field(12; Name; Text[200])
        {
        }
        field(13; "Early Remitances"; Boolean)
        {
        }
        field(14; "Early Remitance Amount"; Decimal)
        {
        }
        field(15; "Trans Type"; Option)
        {
            OptionCaption = ' ,sShare,sLoan,sDeposits,sInterest,sInsurance,sBenevolent,sUnallocated';
            OptionMembers = " ",sShare,sLoan,sDeposits,sInterest,sInsurance,sBenevolent,sUallocated;
        }
        field(16; Description; Text[60])
        {
        }
        field(17; "Member Found"; Boolean)
        {
        }
        field(18; "Search Index"; Code[20])
        {
        }
        field(19; "Loan Found"; Boolean)
        {
        }
        field(20; "Loan No"; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Member No"),
                                                                Posted = const(true));

            trigger OnValidate()
            begin
                memb.Reset;
                memb.SetRange(memb."No.", "Member No");
                if memb.Find('-') then begin
                    loans.Reset;
                    loans.SetRange(loans."Loan  No.", "Loan No");
                    if loans.Find('-') then begin
                        if "Trans Type" = "trans type"::sInsurance then begin
                            Amount := 100;
                        end else
                            if "Trans Type" = "trans type"::sDeposits then begin
                                loans.CalcFields(loans."Interest Due", loans."Outstanding Balance");
                                /// IF loans."Interest Due">0 THEN
                                // Amount:=loans."Interest Due";
                                Amount := 0.01 * loans."Outstanding Balance";
                            end else
                                if "Trans Type" = "trans type"::sLoan then begin
                                    Amount := loans.Repayment;
                                end;
                    end;
                end;
            end;
        }
        field(21; User; Code[20])
        {
        }
        field(22; "Member Moved"; Boolean)
        {
        }
        field(23; "Employer Code"; Code[20])
        {
        }
        field(24; "Batch No."; Code[30])
        {
            TableRelation = "Loan Disburesment-Batching"."Batch No.";
        }
        field(25; "Member No"; Code[20])
        {
            TableRelation = Customer."No." where("No." = field("Member No"));

            trigger OnValidate()
            begin
                memb.Reset;
                memb.SetRange(memb."No.", "Member No");
                if memb.Find('-') then begin
                    "Staff/Payroll No" := memb."Personal No";
                    "ID No." := memb."ID No.";
                    Name := memb.Name;
                    "Employer Code" := memb."Employer Code";
                    if "Trans Type" = "trans type"::sShare then begin
                        Amount := memb."Monthly Contribution"
                    end else
                        if "Trans Type" = "trans type"::sInterest then begin
                            Amount := 200
                        end else
                            if "Trans Type" = "trans type"::sInsurance then begin
                                Amount := 100
                            end else
                                if "Trans Type" = "trans type"::sBenevolent then begin
                                    //memb.CALCFIELDS(memb."KMA Withdrawable Savings");
                                    //Amount:=memb."KMA Withdrawable Savings"*-1;
                                end else
                                    if "Trans Type" = "trans type"::sUallocated then begin
                                        //memb.CALCFIELDS(memb."Children Savings");
                                        //Amount:=memb."Children Savings"*-1;
                                    end;
                    //  else if "Trans Type"="trans type"::"8" then begin
                    // //memb.CALCFIELDS(memb."CIC Fixed Deposits");
                    // //Amount:=memb."CIC Fixed Deposits"*-1;
                    // end else if "Trans Type"="trans type"::"9" then begin
                    //memb.CALCFIELDS(memb."UAP Premiums");
                    //Amount:=memb."UAP Premiums"*-1;




                    //end;
                end;
            end;
        }
        field(26; "ID No."; Code[20])
        {
        }
        field(27; "Receipt Header No"; Code[20])
        {
            TableRelation = "Receipts.Processing Checkoff".No where(No = field("Receipt Header No"));
        }
        field(28; "Receipt Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(29; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Member,None,Staff';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,"None",Staff;
        }
        field(30; "Entry No"; Integer)
        {
        }
        field(31; "FOSA Account"; Code[15])
        {
        }
        field(32; "Xmas Account"; Code[15])
        {
        }
        field(33; "Xmas Contribution"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Receipt Header No", "Receipt Line No")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
        key(Key2; "Receipt Line No")
        {
        }
        key(Key3; "Staff/Payroll No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Posted = true then
            Error('You cannot delete a Posted Check Off');
    end;

    trigger OnModify()
    begin
        if Posted = true then
            Error('You cannot modify a Posted Check Off');
    end;

    trigger OnRename()
    begin
        if Posted = true then
            Error('You cannot rename a Posted Check Off');
    end;

    var
        memb: Record Customer;
        loans: Record "Loans Register";
}

