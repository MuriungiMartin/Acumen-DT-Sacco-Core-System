#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516472 "Transaction Type - List"
{
    ApplicationArea = Basic;
    CardPageID = "Transaction Type Card";
    Editable = false;
    PageType = List;
    SourceTable = "Transaction Types";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Category";"Transaction Category")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field("Account Type";"Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

