#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516448 "Standing Order Register"
{
    ApplicationArea = Basic;
    Editable = false;
    PageType = Card;
    SourceTable = "Standing Order Register";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Register No.";"Register No.")
                {
                    ApplicationArea = Basic;
                }
                field(Date;Date)
                {
                    ApplicationArea = Basic;
                }
                field("Source Account No.";"Source Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Type";"Destination Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account No.";"Destination Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Name";"Destination Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Don't Allow Partial Deduction";"Don't Allow Partial Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("Deduction Status";"Deduction Status")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Amount Deducted";"Amount Deducted")
                {
                    ApplicationArea = Basic;
                }
                field("Amount-""Amount Deducted""";Amount-"Amount Deducted")
                {
                    ApplicationArea = Basic;
                    Caption = 'Balance';
                }
                field(Remarks;Remarks)
                {
                    ApplicationArea = Basic;
                }
                field(EFT;EFT)
                {
                    ApplicationArea = Basic;
                }
                field("Transfered to EFT";"Transfered to EFT")
                {
                    ApplicationArea = Basic;
                }
                field("Standing Order No.";"Standing Order No.")
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
            action(Statement)
            {
                ApplicationArea = Basic;
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //REPORT.RUN(,TRUE,TRUE)
                end;
            }
        }
    }
}

