#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516412 "Interest Due Periods"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Interest Due Period";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Interest Due Date";"Interest Due Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                field("Interest Calcuation Date";"Interest Calcuation Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                    //InterestPeriod.RESET;
                    //InterestPeriod.SETRANGE(BOSARcpt."Transaction No.","Transaction No.");
                    //IF InterestPeriod.FIND('-') THEN
                    Report.Run(51516501)
                end;
            }
        }
    }

    var
        InvtPeriod: Record "Inventory Period";
        date: DateFormula;
        InterestPeriod: Record "Interest Due Period";
}

