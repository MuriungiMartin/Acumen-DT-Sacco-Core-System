#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516248 "HR Non Working Days & Dates"
{
    PageType = List;
    SourceTable = "HR Non Working Days & Dates";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Non Working Days";"Non Working Days")
                {
                    ApplicationArea = Basic;
                }
                field("Non Working Dates";"Non Working Dates")
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

