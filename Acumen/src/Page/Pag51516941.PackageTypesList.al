#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516941 "Package Types List"
{
    CardPageID = "Package Types Card";
    Editable = false;
    PageType = List;
    SourceTable = "Package Types";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field("Package Description";"Package Description")
                {
                    ApplicationArea = Basic;
                }
                field("Package Charge";"Package Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Package Charge Account";"Package Charge Account")
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

