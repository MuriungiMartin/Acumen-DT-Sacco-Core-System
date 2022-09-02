#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516188 "HR Leave Batches"
{
    PageType = List;
    SourceTable = "HR Leave Journal Batch";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Description";"Posting Description")
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

