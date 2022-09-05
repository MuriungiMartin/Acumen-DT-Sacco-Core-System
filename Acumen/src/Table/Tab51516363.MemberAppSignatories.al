#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516363 "Member App Signatories"
{
    DrillDownPageID = "Membership App Signatories";
    LookupPageID = "Membership App Signatories";

    fields
    {
        field(1; "Account No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Membership Applications"."No.";
        }
        field(2; Names; Text[50])
        {
        }
        field(3; "Date Of Birth"; Date)
        {
        }
        field(4; "Staff/Payroll"; Code[20])
        {
        }
        field(5; "ID No."; Code[50])
        {
            NotBlank = true;
        }
        field(6; Signatory; Boolean)
        {
        }
        field(7; "Must Sign"; Boolean)
        {
        }
        field(8; "Must be Present"; Boolean)
        {
        }
        field(9; Picture; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(10; Signature; Blob)
        {
            Caption = 'Signature';
            SubType = Bitmap;
        }
        field(11; "Expiry Date"; Date)
        {
        }
        field(12; "BOSA No."; Code[30])
        {
            TableRelation = Customer;

            trigger OnValidate()
            begin
                if Cust.Get("BOSA No.") then begin
                    //Cust.CALCFIELDS(Cust.Picture,Cust.Signature);
                    Names := Cust.Name;
                    "ID No." := Cust."ID No.";
                    "Email Address" := Cust."E-Mail (Personal)";
                    "Date Of Birth" := Cust."Date of Birth";
                    "Staff/Payroll" := Cust."Personal No";
                    //Picture:=Cust.Picture;
                    //Signature:=Cust.Signature;
                    "Mobile No." := Cust."Mobile Phone No";
                end;
            end;
        }
        field(13; "Email Address"; Text[50])
        {
        }
        field(14; Designation; Code[20])
        {
            NotBlank = true;
        }
        field(15; "Mobile No."; Code[20])
        {
            NotBlank = true;
        }
        field(16; "Maximum Withdrawal"; Decimal)
        {
        }
        field(17; Title; Option)
        {
            OptionCaption = 'Member,Chairperson,Secretary,Treasurer';
            OptionMembers = Member,Chairperson,Secretary,Treasurer;
        }
        field(18; self; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin


                if App.Get("Account No") then begin
                    if self = true then begin

                        Names := App.Name;
                        "ID No." := App."ID No.";
                        "Email Address" := App."E-Mail (Personal)";
                        "Date Of Birth" := App."Date of Birth";
                        "Staff/Payroll" := App."Payroll No";
                        //Picture:=Cust.Picture;
                        //Signature:=Cust.Signature;
                        "Mobile No." := App."Mobile Phone No";

                    end;
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "Account No", Names)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Customer;
        App: Record "Membership Applications";
}

