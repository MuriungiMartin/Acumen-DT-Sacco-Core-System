#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516950 "ATM Card Receipt Batch List"
{
    ApplicationArea = Basic;
    CardPageID = "ATM Card Receipt Batch Card";
    Editable = false;
    PageType = List;
    SourceTable = "ATM Card Receipt Batch";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Batch No.";"Batch No.")
                {
                    ApplicationArea = Basic;
                }
                field("Description/Remarks";"Description/Remarks")
                {
                    ApplicationArea = Basic;
                }
                field(Requested;Requested)
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("Date Created";"Date Created")
                {
                    ApplicationArea = Basic;
                }
                field("Date Requested";"Date Requested")
                {
                    ApplicationArea = Basic;
                }
                field("Requested By";"Requested By")
                {
                    ApplicationArea = Basic;
                }
                field("Prepared By";"Prepared By")
                {
                    ApplicationArea = Basic;
                }
                field(Date;Date)
                {
                    ApplicationArea = Basic;
                }
                field("No. Series";"No. Series")
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

