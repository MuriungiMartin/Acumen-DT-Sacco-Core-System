#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516288 "HR Medical Scheme Members List"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "HR Insurance Scheme Members";
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
                field("Employee No";"Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("First Name";"First Name")
                {
                    ApplicationArea = Basic;
                }
                field("Last Name";"Last Name")
                {
                    ApplicationArea = Basic;
                }
                field(Designation;Designation)
                {
                    ApplicationArea = Basic;
                }
                field(Department;Department)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Scheme Join Date";"Scheme Join Date")
                {
                    ApplicationArea = Basic;
                }
                field("Out-Patient Limit";"Out-Patient Limit")
                {
                    ApplicationArea = Basic;
                }
                field("In-patient Limit";"In-patient Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Cover";"Maximum Cover")
                {
                    ApplicationArea = Basic;
                }
                field("Cumm.Amount Spent";"Cumm.Amount Spent")
                {
                    ApplicationArea = Basic;
                }
                field("No Of Dependants";"No Of Dependants")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action(Dependants)
            {
                ApplicationArea = Basic;
                Caption = 'Dependants';
                Image = Relatives;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "HR Employee Kin";
                RunPageLink = "No."=field("Employee No");
            }
        }
    }
}

