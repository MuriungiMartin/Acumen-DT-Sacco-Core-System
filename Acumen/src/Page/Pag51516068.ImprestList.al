#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516068 "Imprest List"
{
    ApplicationArea = Basic;
    Caption = 'Staff Travel  List';
    CardPageID = "Imprest Request";
    Editable = false;
    PageType = List;
    SourceTable = "Imprest Header";
    SourceTableView = where(Posted=const(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field(Date;Date)
                {
                    ApplicationArea = Basic;
                }
                field("Account No.";"Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Payee;Payee)
                {
                    ApplicationArea = Basic;
                }
                field("Total Net Amount";"Total Net Amount")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Print/Preview")
            {
                ApplicationArea = Basic;
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ImprestHeader.Reset;
                    ImprestHeader.SetRange(ImprestHeader."No.","No.");
                    Report.Run(51516130,true,false, ImprestHeader);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetRange(Cashier,UserId );
    end;

    var
        ImprestHeader: Record "Imprest Header";
}

