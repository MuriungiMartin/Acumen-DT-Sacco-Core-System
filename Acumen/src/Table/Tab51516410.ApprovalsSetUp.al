#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516410 "Approvals Set Up"
{

    fields
    {
        field(1;"Approval Type";Option)
        {
            OptionMembers = Loans,"Bridging Loans","Personal Loans",Refunds,"Funeral Expenses","Withdrawals - Resignation","Withdrawals - Death","Branch Loans",Journals,"File Movement","Appeal Loans","Bosa Loan Approval";
        }
        field(2;Stage;Integer)
        {
        }
        field(3;Description;Text[50])
        {
        }
        field(4;Station;Code[50])
        {
        }
        field(5;"Duration (Hr)";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Approval Type",Stage,Station)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

