#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516643 "Un Allocated Funds List"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Member Register";
    SourceTableView = where("Un-allocated Funds"=filter(>0));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Contribution";"FOSA Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Un-allocated Funds";"Un-allocated Funds")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control7;"Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                SubPageLink = "No."=field("No.");
                Visible = true;
            }
        }
    }

    actions
    {
    }
}

