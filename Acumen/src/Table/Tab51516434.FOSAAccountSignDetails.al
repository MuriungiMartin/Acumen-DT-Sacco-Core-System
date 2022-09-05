#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516434 "FOSA Account Sign. Details"
{

    fields
    {
        field(1; "Account No"; Code[20])
        {
            NotBlank = true;
            TableRelation = Vendor."No.";
        }
        field(2; Names; Code[50])
        {
            NotBlank = true;
        }
        field(3; "Date Of Birth"; Date)
        {
        }
        field(4; "Staff/Payroll"; Code[20])
        {
        }
        field(5; "ID No."; Code[50])
        {

            trigger OnValidate()
            begin
                CUST.Reset;
                CUST.SetRange(CUST."ID No.", "ID No.");
                if CUST.Find('-') then begin
                    "BOSA No." := CUST."No.";
                    Modify;
                end;
            end;
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
        field(12; "Sections Code"; Code[20])
        {
        }
        field(13; "Company Code"; Code[20])
        {
            TableRelation = "HR Asset Transfer Header"."No.";
        }
        field(14; "BOSA No."; Code[30])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                ObjMembers.Reset;
                ObjMembers.SetRange(ObjMembers."No.", "BOSA No.");
                if ObjMembers.Find('-') then begin
                    Names := ObjMembers.Name;
                    "Mobile No" := ObjMembers."Mobile Phone No";
                    "Date Of Birth" := ObjMembers."Date of Birth";
                    "Staff/Payroll" := ObjMembers."Personal No";
                    "ID No." := ObjMembers."ID No.";
                end;
            end;
        }
        field(15; "Email Address"; Text[50])
        {
        }
        field(16; "Mobile No"; Code[20])
        {
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
        CUST: Record Customer;
        ObjMembers: Record Customer;
}

