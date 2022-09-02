#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516655 "Checkoff Processing Linesx"
{
    DelayedInsert = false;
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Checkoff Lines-Distributedx";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Checkoff No";"Checkoff No")
                {
                    ApplicationArea = Basic;
                    StyleExpr = CoveragePercentStyle;
                }
                field("Staff/Payroll No";"Staff/Payroll No")
                {
                    ApplicationArea = Basic;
                }
                field("Account No.";"Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TOTAL_DISTRIBUTED;TOTAL_DISTRIBUTED)
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Amount';
                    Editable = false;
                }
                field("No Repayment";"No Repayment")
                {
                    ApplicationArea = Basic;
                }
                field("Staff Not Found";"Staff Not Found")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Date Filter";"Date Filter")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Car Loan";"Car Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Development;Development)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Sambamba;Sambamba)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Emergency;Emergency)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("School Fees";"School Fees")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Benevolent;Benevolent)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Deposit Contribution";"Deposit Contribution")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Defaulter;Defaulter)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Not Found";"Account Not Found")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Okoa Jahazi";"Okoa Jahazi")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Vuka Special";"Vuka Special")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("40 Years";"40 Years")
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
        //SetStyles();
    end;

    var
        CoveragePercentStyle: Text;

    local procedure SetStyles()
    begin
        /*CoveragePercentStyle:='Strong';
        IF "No Repayment" ='' THEN
           CoveragePercentStyle := 'Unfavorable';
        IF "No Repayment" <>'' THEN
            CoveragePercentStyle := 'Favorable';*/

    end;
}

