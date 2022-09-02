#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516405 "Checkoff Processing Lin(Block)"
{
    PageType = ListPart;
    SourceTable = "Checkoff Processing Lin(Block)";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Receipt Header No";"Receipt Header No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Staff/Payroll No";"Staff/Payroll No")
                {
                    ApplicationArea = Basic;
                    StyleExpr = CoveragePercentStyle;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code";"Employer Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        SetStyles();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        SetStyles();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetStyles();
    end;

    var
        CoveragePercentStyle: Text;

    local procedure SetStyles()
    begin
        CoveragePercentStyle:='Strong';
        if "Member No" ='' then
           CoveragePercentStyle := 'Unfavorable';
        if "Member No" <>'' then
            CoveragePercentStyle := 'Favorable';
    end;
}

