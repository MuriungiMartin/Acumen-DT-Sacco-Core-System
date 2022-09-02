#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516201 "HR Company Activities Factbox"
{
    PageType = CardPart;
    SourceTable = "HR Company Activities";

    layout
    {
        area(content)
        {
            group(Control1102755018)
            {
                label(Control1102755019)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text1;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(Date;Date)
                {
                    ApplicationArea = Basic;
                }
                field(Venue;Venue)
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name";"Employee Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee Responsible';
                }
                field("Email Message";"Email Message")
                {
                    ApplicationArea = Basic;
                }
                label(Control1102755020)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text2;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(Costs;Costs)
                {
                    ApplicationArea = Basic;
                }
                field("Contribution Amount (If Any)";"Contribution Amount (If Any)")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account No";"G/L Account No")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account Name";"G/L Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bal. Account Type";"Bal. Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Bal. Account No";"Bal. Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                }
                label(Control1102755012)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text3;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(Closed;Closed)
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        Text1: label 'Activity Description';
        Text2: label 'Activity Cost';
        Text3: label 'Activity Status';
}

