#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516481 "SaccoLinkCharges"
{

    fields
    {
        field(1;idx;Integer)
        {
            AutoIncrement = true;
            Editable = true;
            //This property is currently not supported
            //TestTableRelation = true;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;
        }
        field(2;Channel;Text[30])
        {
        }
        field(3;ChannelDescription;Text[50])
        {
        }
        field(4;OriginatiorInstitutionID;Text[50])
        {
        }
        field(5;TransactionTypeCode;Text[30])
        {
        }
        field(6;TransactionTypeDescription;Text[30])
        {
        }
        field(7;MinAmount;Decimal)
        {
        }
        field(8;MaxAmount;Decimal)
        {
        }
        field(9;TotalCharges;Decimal)
        {
        }
        field(10;SaccoChargeRate;Decimal)
        {
        }
        field(11;BankChargeRate;Decimal)
        {
        }
        field(12;SaccoCharge;Decimal)
        {
        }
        field(13;BankCharge;Decimal)
        {
        }
        field(14;SaccoExciseDuty;Decimal)
        {
        }
        field(15;BankExciseDuty;Decimal)
        {
        }
        field(16;SaccoCommAccount;Text[30])
        {
        }
        field(17;BankCommAccount;Text[30])
        {
        }
        field(18;AtmSettlementAccount;Text[30])
        {
        }
        field(19;VisaSettlementAccount;Text[30])
        {
        }
    }

    keys
    {
        key(Key1;idx)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

