#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516546 "Interest Buffer Savings"
{
    // DrillDownPageID = UnknownPage50001;TODO
    // LookupPageID = UnknownPage50001;

    fields
    {
        field(1;No;Integer)
        {
            AutoIncrement = false;
        }
        field(2;"Account No";Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(3;"Account Type";Code[20])
        {
        }
        field(4;"Interest Date";Date)
        {
        }
        field(5;"Interest Amount";Decimal)
        {
        }
        field(6;"User ID";Code[20])
        {
        }
        field(8;"Account Matured";Boolean)
        {
        }
        field(9;"No. Series";Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(10;"Late Interest";Boolean)
        {
        }
        field(11;Transferred;Boolean)
        {
        }
        field(12;"Mark For Deletion";Boolean)
        {
        }
    }

    keys
    {
        key(Key1;No,"Account No")
        {
            Clustered = true;
        }
        key(Key2;"Account No",Transferred)
        {
            SumIndexFields = "Interest Amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*
          IF No = '' THEN BEGIN
          NoSetup.GET(0);
          NoSetup.TESTFIELD(NoSetup."Interest Buffer No");
          NoSeriesMgt.InitSeries(NoSetup."Interest Buffer No",xRec."No. Series",0D,No,"No. Series");
          END;
        */

    end;

    var
        NoSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

