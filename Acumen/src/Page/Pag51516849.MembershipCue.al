#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516849 "Membership Cue"
{
    PageType = CardPart;
    SourceTable = "Membership Cue";

    layout
    {
        area(content)
        {
            cuegroup(Members)
            {
                field("Active Members";"Active Members")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Dormant Members";"Dormant Members")
                {
                    ApplicationArea = Basic;
                    Image = PEople;
                }
                field("Non-Active Members";"Non-Active Members")
                {
                    ApplicationArea = Basic;
                    Image = PEople;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Deceased Members";"Deceased Members")
                {
                    ApplicationArea = Basic;
                    Image = People;
                }
                field("Withdrawn Members";"Withdrawn Members")
                {
                    ApplicationArea = Basic;
                    Image = People;
                }
            }
            cuegroup("Account Categories")
            {
                field("Female Members";"Female Members")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Male Members";"Male Members")
                {
                    ApplicationArea = Basic;
                    Image = Library;
                    Style = Ambiguous;
                    StyleExpr = true;
                }
            }
            cuegroup(Loans)
            {
                Caption = 'Back Office Loans';
                field("Normal Loan";"Normal Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Normal Loans';
                    Image = "None";
                }
                field(EMERGENCY;EMERGENCY)
                {
                    ApplicationArea = Basic;
                    Caption = 'Emergency Loans';
                    Image = Chart;
                }
                field(SCHOOL;SCHOOL)
                {
                    ApplicationArea = Basic;
                    Caption = 'School Fees Loans';
                    Image = Chart;
                }
            }
            cuegroup("Front Office Loans")
            {
                Caption = 'Front Office Loans';
                field(ADVANCE1A;ADVANCE1A)
                {
                    ApplicationArea = Basic;
                    Caption = 'Advance 1A';
                }
                field(ADVANCE1B;ADVANCE1B)
                {
                    ApplicationArea = Basic;
                    Caption = 'Advance 1B';
                }
                field(ADVANCE1C;ADVANCE1C)
                {
                    ApplicationArea = Basic;
                    Caption = 'Advance 1C';
                }
                field(SALARYADVANCE;SALARYADVANCE)
                {
                    ApplicationArea = Basic;
                    Caption = 'Salary in Advance';
                }
                field(FOSALOAN;FOSALOAN)
                {
                    ApplicationArea = Basic;
                    Caption = 'Fosa Loan';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        if not Get (UserId) then begin
          Init;
          "User ID" := UserId;
          Insert;
        end;
    end;
}

