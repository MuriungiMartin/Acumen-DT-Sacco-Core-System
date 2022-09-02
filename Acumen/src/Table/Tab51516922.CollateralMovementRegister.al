#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516922 "Collateral Movement Register"
{
    DrillDownPageID = "Collateral Movement Register";
    LookupPageID = "Collateral Movement Register";

    fields
    {
        field(1;"Entry No";Code[20])
        {
        }
        field(2;"Document No";Code[20])
        {
        }
        field(3;"Current Location";Option)
        {
            OptionCaption = ' ,Receive at HQ,Lodge to Strong Room,Retrieve From Strong Room,Issue to Lawyer,Issue to Insurance Agent,Release to Member,Dispatch to Branch,Receive at Branch,Receive From Lawyer,Issue to Auctioneer,Booked to Safe Custody';
            OptionMembers = " ","Receive at HQ","Lodge to Strong Room","Retrieve From Strong Room","Issue to Lawyer","Issue to Insurance Agent","Release to Member","Dispatch to Branch","Receive at Branch","Receive From Lawyer","Issue to Auctioneer","Booked to Safe Custody";
        }
        field(4;"Date Actioned";Date)
        {
        }
        field(5;"Action By";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

