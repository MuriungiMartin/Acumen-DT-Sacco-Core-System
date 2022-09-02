#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516231 "HR Applicant Hobbies"
{
    PageType = List;
    SourceTable = "HR Applicant Hobbies";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Hobby;Hobby)
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

