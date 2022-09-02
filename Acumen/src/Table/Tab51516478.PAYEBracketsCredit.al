#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516478 "PAYE Brackets Credit"
{

    fields
    {
        field(1;"Tax Band";Code[10])
        {
            NotBlank = true;
        }
        field(2;Description;Text[30])
        {
        }
        field(3;"Table Code";Code[10])
        {
        }
        field(4;"Lower Limit";Decimal)
        {
        }
        field(5;"Upper Limit";Decimal)
        {
        }
        field(6;Amount;Decimal)
        {
        }
        field(7;Percentage;Decimal)
        {
        }
        field(8;"From Date";Date)
        {
        }
        field(9;"End Date";Date)
        {
        }
        field(10;"Pay period";Date)
        {
        }
        field(11;"Taxable Amount";Decimal)
        {
        }
        field(12;"Total taxable";Decimal)
        {
        }
        field(13;"Factor Without Housing";Decimal)
        {
            DecimalPlaces = 2:;
        }
        field(14;"Factor With Housing";Decimal)
        {
            DecimalPlaces = 2:;
        }
    }

    keys
    {
        key(Key1;"Tax Band")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

