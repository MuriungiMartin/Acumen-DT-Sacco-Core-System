#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516549 "Funeral Expense Payment"
{

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Funeral Expense Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No."; Code[20])
        {
            TableRelation = Customer;

            trigger OnValidate()
            begin
                IntTotal := 0;
                LoanTotal := 0;

                /*//Restrict No of Withdrawals
                Closure.RESET;
                Closure.SETRANGE(Closure."Member No.","Member No.");
                Closure.SETRANGE(Closure.Posted,FALSE);
                IF Closure.FIND('-') THEN BEGIN
                ERROR('The Member has another withdrawal application Closure No %1',Closure."No.");
                END;
                //*/


                if Cust.Get("Member No.") then begin
                    "Member Name" := Cust.Name;
                    Cust.CalcFields(Cust."Current Savings", Cust."Risk Fund", Cust.Piccture, Cust.Signature);
                    "Member No." := Cust."No.";
                    //Picture:=Cust.Piccture;
                    //Signature:=Cust.Signature;
                    "Member ID No" := Cust."ID No.";
                    "Member Status" := Cust.Status;
                end;

            end;
        }
        field(3; "Member Name"; Text[50])
        {
        }
        field(4; "Closing Date"; Date)
        {
        }
        field(5; "Member Status"; Option)
        {
            OptionCaption = 'Active,Non-Active,Blocked,Dormant,Re-instated,Deceased,Withdrawn,Retired,Termination,Resigned,Ex-Company,Casuals,Family Member,Defaulter,Applicant,Rejected,New';
            OptionMembers = Active,"Non-Active",Blocked,Dormant,"Re-instated",Deceased,Withdrawn,Retired,Termination,Resigned,"Ex-Company",Casuals,"Family Member",Defaulter,Applicant,Rejected,New;
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; "Mode Of Disbursement"; Option)
        {
            OptionCaption = 'Cash,FOSA Transfer,Cheque,EFT';
            OptionMembers = Cash,"FOSA Transfer",Cheque,EFT;
        }
        field(8; "Paying Bank"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(9; "Cheque No."; Code[20])
        {
        }
        field(10; "FOSA Account No."; Code[20])
        {
        }
        field(11; Payee; Text[80])
        {
        }
        field(12; "Death Date"; Date)
        {
        }
        field(13; "Date Reported"; Date)
        {
        }
        field(14; "Reported By"; Code[50])
        {
        }
        field(15; "Reporter ID No."; Code[20])
        {
        }
        field(16; "Reporter Mobile No"; Code[20])
        {
        }
        field(17; "Reporter Address"; Code[20])
        {
        }
        field(18; "Relationship With Deceased"; Code[20])
        {
            TableRelation = "Relationship Types".code;
        }
        field(19; "Received Burial Permit"; Boolean)
        {
        }
        field(20; "Received Letter From Chief"; Boolean)
        {
        }
        field(21; Picture; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(22; "Member ID No"; Code[20])
        {
        }
        field(23; "Date Posted"; Date)
        {
        }
        field(24; "Time Posted"; Time)
        {
        }
        field(25; "Posted By"; Code[20])
        {
        }
        field(26; "No. Series"; Code[20])
        {
        }
        field(27; Signature; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(28; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Funeral Expense Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Funeral Expense Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Cust: Record Customer;
        Loans: Record "Loans Register";
        MemLed: Record "Cust. Ledger Entry";
        IntTotal: Decimal;
        LoanTotal: Decimal;
        GenSetup: Record "Sacco General Set-Up";
        IntTotalFOSA: Decimal;
        LoanTotalFOSA: Decimal;
}

