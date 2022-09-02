#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516708 "Dividends Register Flat Rate"
{

    fields
    {
        field(1;"Member No";Code[20])
        {
        }
        field(2;Date;Date)
        {
        }
        field(3;"Gross Dividends";Decimal)
        {
        }
        field(4;"Gross Rebates";Decimal)
        {
        }
        field(5;"Witholding Tax";Decimal)
        {
        }
        field(6;"Net Dividends/Rebates";Decimal)
        {
        }
        field(7;"Qualifying Shares";Decimal)
        {
        }
        field(8;Shares;Decimal)
        {
        }
        field(9;"Share Capital";Decimal)
        {
        }
        field(10;"Gross Dividend/Rebates";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Member No",Date)
        {
            Clustered = true;
            SumIndexFields = "Gross Dividends","Witholding Tax","Qualifying Shares","Net Dividends/Rebates","Gross Rebates";
        }
    }

    fieldgroups
    {
    }
}

