#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516634 "Loan Insurance Accrual Periods"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Loan Insurance Accrual Period";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Insurance Due Date";"Insurance Due Date")
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("New Fiscal Year";"New Fiscal Year")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Closed;Closed)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Date Locked";"Date Locked")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Closed by User";"Closed by User")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Closing Date Time";"Closing Date Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Insurance Calcuation Date";"Insurance Calcuation Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            separator(Action15)
            {
            }
            action("Create Period")
            {
                ApplicationArea = Basic;
                Image = AccountingPeriods;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Report.Run(51516917)
                end;
            }
        }
    }

    var
        InvtPeriod: Record "Inventory Period";
        date: DateFormula;
        InterestPeriod: Record "Loan Insurance Accrual Period";
}

