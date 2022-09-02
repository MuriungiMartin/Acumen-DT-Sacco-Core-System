#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516859 "Fixed Deposit Placement"
{
    ApplicationArea = Basic;
    CardPageID = "Fixed Deposit Placement Card";
    Editable = false;
    PageType = List;
    SourceTable = "Fixed Deposit Placement";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No";"Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";"Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Fixed Deposit Account No";"Fixed Deposit Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date";"Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Fixed Deposit Type";"Fixed Deposit Type")
                {
                    ApplicationArea = Basic;
                }
                field("FD Maturity Date";"FD Maturity Date")
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

