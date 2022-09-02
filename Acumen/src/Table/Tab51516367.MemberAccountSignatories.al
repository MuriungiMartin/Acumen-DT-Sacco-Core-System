#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516367 "Member Account Signatories"
{
    DrillDownPageID = "Member Account Signatory list";
    LookupPageID = "Member Account Signatory list";

    fields
    {
        field(1;"Account No";Code[20])
        {
            NotBlank = true;
        }
        field(2;Names;Text[50])
        {
            NotBlank = false;
        }
        field(3;"Date Of Birth";Date)
        {
        }
        field(4;"Staff/Payroll";Code[20])
        {
        }
        field(5;"ID No.";Code[50])
        {

            trigger OnValidate()
            begin
                CUST.Reset;
                CUST.SetRange(CUST."ID No.","ID No.");
                if CUST.Find('-')  then begin
                "BOSA No.":=CUST."No.";
                Modify;
                end;
            end;
        }
        field(6;Signatory;Boolean)
        {
        }
        field(7;"Must Sign";Boolean)
        {
        }
        field(8;"Must be Present";Boolean)
        {
        }
        field(9;Picture;Blob)
        {
            Caption = 'Picture';
        }
        field(10;Signature;Blob)
        {
            Caption = 'Signature';
        }
        field(11;"Expiry Date";Date)
        {
        }
        field(12;"Sections Code";Code[20])
        {
            TableRelation = "prTax Law".Field1;
        }
        field(13;"Company Code";Code[20])
        {
            TableRelation = "Sacco Employers".Code;
        }
        field(14;"BOSA No.";Code[30])
        {
            TableRelation = "Member Register"."No." where ("Group Account"=filter(false),
                                                           "Global Dimension 1 Code"=filter('MICRO'),
                                                           "Group Account No"=field("Account No"));

            trigger OnValidate()
            begin
                CUST.Reset;
                CUST.SetRange(CUST."No.","BOSA No.");
                if CUST.Find('-') then begin
                Names:=CUST.Name;
                "Mobile Phone No":=CUST."Mobile Phone No";
                "Date Of Birth":=CUST."Date of Birth";
                "Staff/Payroll":=CUST."Personal No";
                "ID No.":=CUST."ID No.";
                "Email Address":=CUST."E-Mail (Personal)";
                end;
            end;
        }
        field(15;"Email Address";Text[50])
        {
        }
        field(16;Designation;Code[20])
        {
        }
        field(17;"All To sign";Boolean)
        {
        }
        field(18;"Both To sign";Boolean)
        {
        }
        field(19;"Any To sign";Boolean)
        {
        }
        field(20;"Send SMS";Boolean)
        {
        }
        field(21;"Mobile Phone No";Code[20])
        {
        }
        field(22;Title;Option)
        {
            OptionCaption = 'Member,Chairperson,Secretary,Treasurer';
            OptionMembers = Member,Chairperson,Secretary,Treasurer;
        }
    }

    keys
    {
        key(Key1;"Account No",Names)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        Error('You cannot change the already entered signatory');
    end;

    trigger OnRename()
    begin
        Error('You cannot change the already entered signatory');
    end;

    var
        CUST: Record "Member Register";
}

