#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516168 "HR Appraisal Assignment List"
{
    PageType = List;
    SourceTable = "HR Appraisal Assignment";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Code";"Employee Code")
                {
                    ApplicationArea = Basic;
                }
                field("Categorize As";"Categorize As")
                {
                    ApplicationArea = Basic;
                }
                field(No;No)
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

