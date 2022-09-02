#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516598 "CloudPESA MPESA C2B Change"
{
    CardPageID = "CloudPESA MPESA Change Card";
    PageType = List;
    SourceTable = "CloudPESA MPESA Change";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(idx;idx)
                {
                    ApplicationArea = Basic;
                }
                field("Document No";"Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date";"Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Document Time";"Document Time")
                {
                    ApplicationArea = Basic;
                }
                field("Original Account No";"Original Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Document Change Date";"Document Change Date")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Telephone;Telephone)
                {
                    ApplicationArea = Basic;
                }
                field("Changed By";"Changed By")
                {
                    ApplicationArea = Basic;
                }
                field("Change Status";"Change Status")
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

