#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516986 "CRM Trainees"
{
    PageType = List;
    SourceTable = "CRM Traineees";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";"Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Member ID No";"Member ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Phone No";"Member Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("Member House Group";"Member House Group")
                {
                    ApplicationArea = Basic;
                }
                field("Member House Group Name";"Member House Group Name")
                {
                    ApplicationArea = Basic;
                }
                field(Attended;Attended)
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

