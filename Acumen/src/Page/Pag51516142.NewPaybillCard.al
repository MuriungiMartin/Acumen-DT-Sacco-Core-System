#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516142 "New Paybill Card"
{
    PageType = Card;
    SourceTable = "File Movement Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("File Number"; "File Number")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("File Name"; "File Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Responsiblity Center"; "Responsiblity Center")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Issuing File Location"; "Issuing File Location")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Return Date"; "Expected Return Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Duration Requested"; "Duration Requested")
                {
                    ApplicationArea = Basic;
                }
                field("File Location"; "File Location")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieved By"; "Retrieved By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control1000000025; "New Paybill Lines")
            {
                SubPageLink = "Document No." = field("No.");
            }
        }
    }

    actions
    {
        /*
        area(processing)
        {
            group(Posting)
            {
                Caption = 'Posting';
                action(Post)
                {
                    ApplicationArea = Basic;
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Status <> Status::"2" then
                            Error('Document Must Be Released Before Posting');

                        if FundsUSer.Get(UserId) then begin
                            Jtemplate := FundsUSer."Payment Journal Template";
                            Jbatch := FundsUSer."Payment Journal Batch";
                        end;
                        if "Date Requested" = true then
                            Error('This Shedule is already posted');
                        TestField("Responsiblity Center");

                        if Confirm('Are you sure you want to transfer schedule?', false) = true then begin

                            //IF Approved=FALSE THEN
                            //ERROR('This schedule is not approved');


                            // DELETE ANY LINE ITEM THAT MAY BE PRESENT
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", Jtemplate);
                            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", Jbatch);
                            GenJournalLine.DeleteAll;




                            //POSTING MAIN TRANSACTION

                            //window.OPEN('Posting:,#1######################');






                            // UPDATE Source Account
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := Jbatch;
                            GenJournalLine."Document No." := "No.";
                            GenJournalLine."Line No." := GenJournalLine."Line No." + 10000;
                            if "Expected Return Date" = "expected return date"::"0" then begin
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                GenJournalLine."Transaction Type" := "Date Returned";
                                GenJournalLine."Account No." := "Duration Requested";
                                GenJournalLine."Loan No" := "Current File Location";
                            end else
                                if "Expected Return Date" = "expected return date"::"4" then begin
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                                    GenJournalLine."Transaction Type" := "Date Returned";
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := BTRANS."Issuing File Location";
                                    GenJournalLine."Account No." := "Duration Requested";
                                    GenJournalLine."Loan No" := "Current File Location";
                                end else

                                    if "Expected Return Date" = "expected return date"::"1" then begin
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        GenJournalLine."Shortcut Dimension 1 Code" := 'fOSA';
                                        GenJournalLine."Shortcut Dimension 2 Code" := BTRANS."Issuing File Location";
                                        GenJournalLine."Account No." := "Duration Requested";
                                    end else
                                        if "Expected Return Date" = "expected return date"::"3" then begin
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                            GenJournalLine."Transaction Type" := "Date Returned";
                                            GenJournalLine."Shortcut Dimension 2 Code" := BTRANS."Issuing File Location";
                                            GenJournalLine."Account No." := "Duration Requested";
                                        end else
                                            if "Expected Return Date" = "expected return date"::"2" then begin
                                                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                                GenJournalLine."Shortcut Dimension 2 Code" := BTRANS."Issuing File Location";
                                                GenJournalLine."Account No." := "Duration Requested";
                                            end;
                            GenJournalLine."Posting Date" := "File Number";
                            GenJournalLine.Description := "Responsiblity Center";
                            CalcFields("File Name");
                            GenJournalLine.Amount := "File Name";
                            //GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine.Insert;




                            BSched.Reset;
                            BSched.SetRange(BSched."Document No.", "No.");
                            if BSched.Find('-') then begin
                                repeat

                                    GenJournalLine.Init;

                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                    GenJournalLine."Document No." := "No.";
                                    GenJournalLine."Line No." := GenJournalLine."Line No." + 10000;

                                    if BSched."Account No." = BSched."account no."::"3" then begin
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                                        GenJournalLine."Transaction Type" := BSched."Purpose/Description";
                                        GenJournalLine."Account No." := BSched."File Type";
                                        GenJournalLine."Shortcut Dimension 2 Code" := BSched."Global Dimension 2 Code";
                                    end else

                                        if BSched."Account No." = BSched."account no."::"0" then begin
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                            GenJournalLine."Transaction Type" := BSched."Purpose/Description";
                                            GenJournalLine."Account No." := BSched."File Type";
                                            GenJournalLine."Shortcut Dimension 2 Code" := BSched."Global Dimension 2 Code";
                                        end else
                                            if BSched."Account No." = BSched."account no."::"2" then begin
                                                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                                GenJournalLine."Account No." := BSched."File Type";
                                                GenJournalLine."Shortcut Dimension 2 Code" := '01';

                                            end else
                                                if BSched."Account No." = BSched."account no."::"1" then begin
                                                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                                                    GenJournalLine."Account No." := BSched."File Type";
                                                    GenJournalLine."Shortcut Dimension 2 Code" := BSched."Global Dimension 2 Code";
                                                end;
                                    GenJournalLine."Loan No" := BSched."Global Dimension 1 Code";
                                    GenJournalLine.Validate(GenJournalLine."Loan No");
                                    //GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := "File Number";
                                    GenJournalLine.Description := "Responsiblity Center";
                                    GenJournalLine.Amount := -BSched."Global Dimension 2 Code";
                                    //GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                    GenJournalLine.Insert;
                                until BSched.Next = 0;
                            end;


                            /*
                            //Post
                            GenJournalLine.RESET;
                            GenJournalLine.SETRANGE("Journal Template Name",Jtemplate);
                            GenJournalLine.SETRANGE("Journal Batch Name",Jbatch);
                            IF GenJournalLine.FIND('-') THEN BEGIN
                            //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch",GenJournalLine);
                            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJournalLine);
                            END;

                            //Post
                            Posted:=TRUE;
                            MODIFY;
                           

                        end;

                    end;
                }
                action(Print)
                {
                    ApplicationArea = Basic;
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        BTRANS.Reset;
                        BTRANS.SetRange(BTRANS."No.", "No.");
                        if BTRANS.Find('-') then begin
                            Report.Run(51516140, true, true, BTRANS);
                        end;
                    end;
                }
                action(Release)
                {
                    ApplicationArea = Basic;
                    Image = ReceiveLoaner;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Status = Status::"2" then Error('Document Already Released');

                        Status := Status::"2";
                        Modify;

                        Message('Document Released Successfully');
                    end;
                }
            }
        }
        */
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //  "Expected Return Date" := "expected return date"::"2";
    end;

    var
        users: Record User;
        GenJournalLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        BSched: Record "File Movement Line";
        BTRANS: Record "File Movement Header";
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        FundsUSer: Record "Funds User Setup";
        Jtemplate: Code[10];
        Jbatch: Code[10];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers;
        SourceAccountNoEditbale: Boolean;
        SourceAccountNameEditable: Boolean;
        SourceAccountTypeEditable: Boolean;
        SourceTransactionType: Boolean;
        SourceLoanNoEditable: Boolean;
        RemarkEditable: Boolean;
        TransactionDateEditable: Boolean;
        ApprovalsMgmt: Codeunit WorkflowIntegration;
}

