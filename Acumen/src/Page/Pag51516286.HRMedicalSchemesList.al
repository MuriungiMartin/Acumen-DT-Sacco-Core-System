#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516286 "HR Medical Schemes List"
{
    ApplicationArea = Basic;
    CardPageID = "HR Medical Schemes Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "HR Medical Schemes";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Scheme No";"Scheme No")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Insurer";"Medical Insurer")
                {
                    ApplicationArea = Basic;
                }
                field("Scheme Name";"Scheme Name")
                {
                    ApplicationArea = Basic;
                }
                field("In-patient limit";"In-patient limit")
                {
                    ApplicationArea = Basic;
                }
                field("Out-patient limit";"Out-patient limit")
                {
                    ApplicationArea = Basic;
                }
                field("Area Covered";"Area Covered")
                {
                    ApplicationArea = Basic;
                }
                field("Dependants Included";"Dependants Included")
                {
                    ApplicationArea = Basic;
                }
                field(Comments;Comments)
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

