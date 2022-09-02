#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516446 "Cheque Types"
{

    fields
    {
        field(1;"Code";Code[20])
        {
            NotBlank = true;
        }
        field(2;Description;Text[50])
        {
        }
        field(3;"Clearing Days";DateFormula)
        {
        }
        field(4;"Clearing Charges";Decimal)
        {
        }
        field(5;"Special Clearing Days";DateFormula)
        {
        }
        field(6;"Special Clearing Charges";Decimal)
        {
        }
        field(7;"Bounced Charges";Decimal)
        {
        }
        field(8;"Clearing Bank Account";Code[20])
        {
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                if Banks.Get("Clearing Bank Account") then begin
                "Bank Name":=Banks.Name;
                end;
            end;
        }
        field(9;"Bank Name";Text[150])
        {
        }
        field(10;"Bounced Charges GL Account";Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(11;"Clearing Charges GL Account";Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(12;"Clearing  Days";Integer)
        {
        }
        field(13;Percentage;Decimal)
        {
        }
        field(14;"Clearing Charge Code";Code[20])
        {
            TableRelation = "HR E-Mail Parameters";
        }
        field(15;Type;Option)
        {
            OptionCaption = 'Local,Inhouse,Upcountry';
            OptionMembers = "Local",Inhouse,Upcountry;
        }
        field(16;"Use %";Boolean)
        {
        }
        field(17;"% Of Amount";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Banks: Record "Bank Account";
}

