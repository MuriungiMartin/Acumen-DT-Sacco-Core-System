#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516182 "HR Job Qualifications"
{
    ApplicationArea = Basic;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Qualifications';
    SourceTable = "HR Job Qualifications";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Qualification Type";"Qualification Type")
                {
                    ApplicationArea = Basic;
                }
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Qualification)
            {
                Caption = 'Qualification';
                action("Q&ualification Overview")
                {
                    ApplicationArea = Basic;
                    Caption = 'Q&ualification Overview';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Qualification Overview";
                }
            }
        }
    }
}

