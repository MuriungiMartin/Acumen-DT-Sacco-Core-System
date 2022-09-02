#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516463 "Account Types List"
{
    ApplicationArea = Basic;
    CardPageID = "Account Types Card";
    Editable = false;
    PageType = List;
    SourceTable = "Account Types-Saving Products";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field("Dormancy Period (M)";"Dormancy Period (M)")
                {
                    ApplicationArea = Basic;
                }
                field("Entered By";"Entered By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Entered";"Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field("Time Entered";"Time Entered")
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified";"Last Date Modified")
                {
                    ApplicationArea = Basic;
                }
                field("Modified By";"Modified By")
                {
                    ApplicationArea = Basic;
                }
                field("Default Account";"Default Account")
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

