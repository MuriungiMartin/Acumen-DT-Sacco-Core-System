#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516588 "Loan PayOff Card"
{
    PageType = Card;
    SourceTable = "Loan PayOff";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("FOSA Account No"; "FOSA Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Requested PayOff Amount"; "Requested PayOff Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Approved PayOff Amount"; "Approved PayOff Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Total PayOut Amount"; "Total PayOut Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By"; "Posted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control1000000009; "Loan PayOff Details")
            {
                SubPageLink = "Document No" = field("Document No"),
                              "Member No" = field("Member No");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Post PayOff")
            {
                ApplicationArea = Basic;
                Enabled = EnablePosting;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CalcFields("Total PayOut Amount");
                    if "Total PayOut Amount" <> "Approved PayOff Amount" then begin
                        Error('Cummulative PayOffs on the lines must be equal to Total PayOffs')
                    end else

                        if Confirm('Are You Sure you Want to Post this PayOff?', false) = true then begin


                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                            GenJournalLine.SetRange("Journal Batch Name", 'PayOff');
                            if GenJournalLine.Find('-') then begin
                                GenJournalLine.DeleteAll;
                            end;



                            PayOffDetails.Reset;
                            PayOffDetails.SetRange(PayOffDetails."Document No", "Document No");
                            if PayOffDetails.Find('-') then begin
                                repeat

                                    GenJournalLine.Init;
                                    LineNo := LineNo + 10000;
                                    //Principle
                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                    GenJournalLine."Journal Batch Name" := 'PayOff';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Document No." := "Document No";
                                    GenJournalLine."Posting Date" := Today;
                                    //GenJournalLine."External Document No.":=MultipleCheque."Cheque No";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                    if PayOffDetails.Source = PayOffDetails.Source::BOSA then begin
                                        GenJournalLine."Account No." := "Member No"
                                    end else
                                        if PayOffDetails.Source = PayOffDetails.Source::FOSA then begin
                                            LoansRec.Reset;
                                            LoansRec.SetRange(LoansRec."Loan  No.", PayOffDetails."Loan to PayOff");
                                            if LoansRec.Find('-') then begin
                                                if LoansRec."Issued Date" < 20160511D then begin
                                                    GenJournalLine."Account No." := "Member No"
                                                end else
                                                    GenJournalLine."Account No." := LoansRec."Account No";
                                            end;
                                        end;
                                    //GenJournalLine."Account No.":="Member No";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                    GenJournalLine.Description := 'Loan PayOff- ' + PayOffDetails."Loan to PayOff" + '-' + PayOffDetails."Loan Type";
                                    GenJournalLine.Amount := PayOffDetails."Principle PayOff" * -1;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Loan No" := PayOffDetails."Loan to PayOff";
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                                    //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                    //GenJournalLine."Bal. Account No.":="FOSA Account No";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    /*GenJournalLine.INIT;
                                    LineNo:=LineNo+10000;
                                    //Principle
                                    GenJournalLine."Journal Template Name":='PAYMENTS';
                                    GenJournalLine."Journal Batch Name":='PayOff';
                                    GenJournalLine."Line No.":=LineNo;
                                    GenJournalLine."Document No.":="Document No";
                                    GenJournalLine."Posting Date":=TODAY;
                                    //GenJournalLine."External Document No.":=MultipleCheque."Cheque No";
                                    GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
                                    GenJournalLine."Account No.":="FOSA Account No";
                                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                    //GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Repayment;
                                    GenJournalLine.Description:='Loan PayOff- ' +PayOffDetails."Loan to PayOff"+'-'+PayOffDetails."Loan Type";
                                    GenJournalLine.Amount:=PayOffDetails."Principle PayOff";
                                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                    ///GenJournalLine."Loan No":=PayOffDetails."Loan to PayOff";
                                    GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code":="Global Dimension 2 Code";
                                    //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                    //GenJournalLine."Bal. Account No.":="FOSA Account No";
                                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                    IF GenJournalLine.Amount<>0 THEN
                                    GenJournalLine.INSERT;*/

                                    //Interest OutStanding
                                    GenJournalLine.Init;
                                    LineNo := LineNo + 10000;
                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                    GenJournalLine."Journal Batch Name" := 'PayOff';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Document No." := "Document No";
                                    GenJournalLine."Posting Date" := Today;
                                    //GenJournalLine."External Document No.":=MultipleCheque."Cheque No";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                    if PayOffDetails.Source = PayOffDetails.Source::BOSA then begin
                                        GenJournalLine."Account No." := "Member No"
                                    end else
                                        GenJournalLine."Account No." := "Member No";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Insurance Contribution";
                                    GenJournalLine.Description := 'Outstanding Interest- ' + PayOffDetails."Loan to PayOff" + '-' + PayOffDetails."Loan Type";
                                    GenJournalLine.Amount := PayOffDetails."Interest On PayOff" * -1;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Loan No" := PayOffDetails."Loan to PayOff";
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                                    //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                    //GenJournalLine."Bal. Account No.":="FOSA Account No";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    GenJournalLine.Init;
                                    LineNo := LineNo + 10000;
                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                    GenJournalLine."Journal Batch Name" := 'PayOff';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Document No." := "Document No";
                                    GenJournalLine."Posting Date" := Today;
                                    //GenJournalLine."External Document No.":=MultipleCheque."Cheque No";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := "FOSA Account No";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    //GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Interest Paid";
                                    GenJournalLine.Description := 'Outstanding Interest PayOff- ' + PayOffDetails."Loan to PayOff" + '-' + PayOffDetails."Loan Type";
                                    GenJournalLine.Amount := PayOffDetails."Loan Outstanding";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Loan No" := PayOffDetails."Loan to PayOff";
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                                    //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                    //GenJournalLine."Bal. Account No.":="FOSA Account No";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    //Comission
                                    GenJournalLine.Init;
                                    LineNo := LineNo + 10000;
                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                    GenJournalLine."Journal Batch Name" := 'PayOff';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Document No." := "Document No";
                                    GenJournalLine."Posting Date" := Today;
                                    //GenJournalLine."External Document No.":=MultipleCheque."Cheque No";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                    if LoanType.Get(PayOffDetails."Loan Type") then begin
                                        GenJournalLine."Account No." := LoanType."Loan PayOff Fee Account";
                                    end;
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    //GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Interest Paid";
                                    GenJournalLine.Description := 'Comission on PayOff- ' + PayOffDetails."Loan to PayOff" + '-' + PayOffDetails."Loan Type";
                                    GenJournalLine.Amount := PayOffDetails."Commision on PayOff" * -1;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Loan No" := PayOffDetails."Loan to PayOff";
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                                    //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                    //GenJournalLine."Bal. Account No.":="FOSA Account No";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    GenJournalLine.Init;
                                    LineNo := LineNo + 10000;
                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                    GenJournalLine."Journal Batch Name" := 'PayOff';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Document No." := "Document No";
                                    GenJournalLine."Posting Date" := Today;
                                    //GenJournalLine."External Document No.":=MultipleCheque."Cheque No";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := "FOSA Account No";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    //GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Interest Paid";
                                    GenJournalLine.Description := 'Comission On PayOff- ' + PayOffDetails."Loan to PayOff" + '-' + PayOffDetails."Loan Type";
                                    GenJournalLine.Amount := PayOffDetails."Commision on PayOff";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    //GenJournalLine."Loan No":=PayOffDetails."Loan to PayOff";
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                                    //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                    //GenJournalLine."Bal. Account No.":="FOSA Account No";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                until PayOffDetails.Next = 0;
                            end;
                        end;

                    //Post
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                    GenJournalLine.SetRange("Journal Batch Name", 'PayOff');
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                    end;
                    Posted := true;
                    "Posting Date" := Today;
                    "Posted By" := UserId;
                    Modify;
                    //Post New
                    Message('PayOff Posted Succesfuly');

                    PayOffDetails.Reset;
                    PayOffDetails.SetRange(PayOffDetails."Document No", "Document No");
                    if PayOffDetails.Find('-') then begin
                        repeat
                            PayOffDetails.Posted := true;
                            PayOffDetails."Posting Date" := Today;
                            PayOffDetails.Modify;
                        until PayOffDetails.Next = 0;

                    end;

                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send Approval Request';
                Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    Text001: label 'This request is already pending approval';
                    ApprovalsMgmt: Codeunit WorkflowIntegration;
                begin

                    if ApprovalsMgmt.CheckLoanPayOffApprovalsWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnSendLoanPayOffForApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Request';
                Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    Approvalmgt: Codeunit WorkflowIntegration;
                begin
                    if Confirm('Are you sure you want to cancel this approval request', false) = true then
                        ApprovalsMgmt.OnCancelLoanPayOffApprovalRequest(Rec);
                    Status := Status::Open;
                    Modify;
                end;
            }
            action(Approval)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                begin
                    DocumentType := Documenttype::LoanPayOff;
                    ApprovalEntries.Setfilters(Database::"Loan PayOff", DocumentType, "Document No");
                    ApprovalEntries.Run;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CalcFields("Total PayOut Amount");
        "Requested PayOff Amount" := "Total PayOut Amount";
        "Approved PayOff Amount" := "Total PayOut Amount";

        EnablePosting := false;
        OpenApprovalEntriesExist := Approv.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := Approv.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Status::Approved)) then
            EnablePosting := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Created By" := UserId;
        "Application Date" := Today;
    end;

    trigger OnOpenPage()
    begin
        EnablePosting := false;
        OpenApprovalEntriesExist := Approv.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := Approv.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Status::Approved)) then
            EnablePosting := true;
    end;

    var
        PayOffDetails: Record "Loans PayOff Details";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        LoanType: Record "Loan Products Setup";
        LoansRec: Record "Loans Register";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff;
        EnablePosting: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit WorkflowIntegration;
        EnabledApprovalWorkflowsExist: Boolean;
        GenBatch: Record "Gen. Journal Batch";
        Approv: Codeunit "Approvals Mgmt.";
}

