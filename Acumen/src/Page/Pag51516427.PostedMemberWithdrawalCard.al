#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516427 "Posted Member Withdrawal Card"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption';
    SourceTable = "Membership Exit";
    SourceTableView = where(Posted=filter(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No.";"Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = MNoEditable;
                }
                field("Member Name";"Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Closing Date";"Closing Date")
                {
                    ApplicationArea = Basic;
                    Editable = ClosingDateEditable;
                }
                field("Posting Date";"Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date";"Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Date Approved";"Date Approved")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Posting Date";"Expected Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Closure Type";"Closure Type")
                {
                    ApplicationArea = Basic;
                    Editable = ClosureTypeEditable;
                }
                field("Sell Share Capital";"Sell Share Capital")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Total Loan";"Total Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Loan BOSA';
                    Editable = false;
                }
                field("Total Interest";"Total Interest")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Interest Due BOSA';
                    Editable = false;
                }
                field("Total Loans FOSA";"Total Loans FOSA")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Oustanding Int FOSA";"Total Oustanding Int FOSA")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Interest Due FOSA';
                    Editable = false;
                }
                field("Member Deposits";"Member Deposits")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Share Capital";"Share Capital")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Refundable Share Capital";"Refundable Share Capital")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Share Capital to Sell";"Share Capital to Sell")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Risk Fund";"Risk Fund")
                {
                    ApplicationArea = Basic;
                    Caption = 'Net Refund';
                    Editable = false;
                    Visible = false;
                }
                field("Risk Fund Arrears";"Risk Fund Arrears")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Risk Beneficiary";"Risk Beneficiary")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Mode Of Disbursement";"Mode Of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Paying Bank";"Paying Bank")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Cheque No.";"Cheque No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("FOSA Account No.";"FOSA Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Payee;Payee)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("User ID";"User ID")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType:=Documenttype::"Member Closure";
                        ApprovalEntries.Setfilters(Database::"HR Leave Register",DocumentType,"No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Print Cheque")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        /*
                        ClosureR.RESET;
                        ClosureR.SETRANGE(ClosureR."Member No.","Member No.");
                        IF ClosureR.FIND('-') THEN
                        REPORT.RUN(,TRUE,FALSE,ClosureR);
                        */

                    end;
                }
                action("Account closure Slip")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        cust.Reset;
                        cust.SetRange(cust."No.","Member No.");
                        if cust.Find('-') then
                        Report.Run(51516474,true,false,cust);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
    end;

    var
        Closure: Integer;
        Text001: label 'Not Approved';
        cust: Record "Member Register";
        UBFRefund: Decimal;
        Generalsetup: Record "Sacco General Set-Up";
        Totalavailable: Decimal;
        UnpaidDividends: Decimal;
        TotalOustanding: Decimal;
        Vend: Record Vendor;
        value2: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        Totalrecovered: Decimal;
        Advice: Boolean;
        TotalDefaulterR: Decimal;
        AvailableShares: Decimal;
        Loans: Record "Loans Register";
        Value1: Decimal;
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        Vendno: Code[20];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff;
        MNoEditable: Boolean;
        ClosingDateEditable: Boolean;
        ClosureTypeEditable: Boolean;
        TotalFOSALoan: Decimal;
        TotalInsuarance: Decimal;
        DActivity: Code[30];
        DBranch: Code[30];
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        "Remaining Amount": Decimal;
        LoansR: Record "Loans Register";
        "AMOUNTTO BE RECOVERED": Decimal;
        PrincipInt: Decimal;
        TotalLoansOut: Decimal;
        ClosureR: Record "Membership Exit";


    procedure UpdateControl()
    begin
        if Status=Status::Open then begin
        MNoEditable:=true;
        ClosingDateEditable:=false;
        ClosureTypeEditable:=true;
        end;

        if Status=Status::Pending then begin
        MNoEditable:=false;
        ClosingDateEditable:=false;
        ClosureTypeEditable:=false
        end;

        if Status=Status::Rejected then begin
        MNoEditable:=false;
        ClosingDateEditable:=false;
        ClosureTypeEditable:=false;
        end;

        if Status=Status::Approved then begin
        MNoEditable:=false;
        ClosingDateEditable:=true;
        ClosureTypeEditable:=false;
        end;
    end;
}

