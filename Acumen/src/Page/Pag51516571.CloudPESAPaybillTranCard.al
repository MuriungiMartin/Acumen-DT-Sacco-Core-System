#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516571 "CloudPESA Paybill Tran Card"
{
    PageType = Card;
    SourceTable = "CloudPESA MPESA Trans";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No";"Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Date";"Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Key Word";"Key Word")
                {
                    ApplicationArea = Basic;
                }
                field(Telephone;Telephone)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Needs Manual Posting";"Needs Manual Posting")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date";"Document Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

