#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516506 "BOSA Transfer"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "BOSA Transfers";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No;No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Date";"Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Approved By";"Approved By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Remarks;Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Schedule Total";"Schedule Total")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Approved;Approved)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control1102760014;"BOSA Transfer Sched")
            {
                SubPageLink = "No."=field(No);
            }
        }
    }

    actions
    {
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
                        /*IF UsersID.GET(USERID) THEN BEGIN
                        //PKKSUsersID.TESTFIELD(UsersID.Branch);
                        //DActivity:='FOSA';
                        DBranch:=UsersID.Branch;
                        END;*/
                        if FundsUSer.Get(UserId) then begin
                        Jtemplate:=FundsUSer."Payment Journal Template";
                        Jbatch:=FundsUSer."Payment Journal Batch";
                        end;
                        if Posted = true then
                        Error('This Shedule is already posted');
                        TestField(Remarks);
                        
                        if Confirm('Are you sure you want to transfer schedule?',false)=true then begin
                        
                        //IF Approved=FALSE THEN
                        //ERROR('This schedule is not approved');
                        
                        
                        // DELETE ANY LINE ITEM THAT MAY BE PRESENT
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange(GenJournalLine."Journal Template Name",Jtemplate);
                        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name",Jbatch);
                        GenJournalLine.DeleteAll;
                        
                        
                        
                        
                        //POSTING MAIN TRANSACTION
                        
                        //window.OPEN('Posting:,#1######################');
                        
                        
                        
                        BSched.Reset;
                        BSched.SetRange(BSched."No.",No);
                        if BSched.Find('-') then begin
                        repeat
                        
                        
                        // UPDATE Source Account
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":=Jtemplate;
                        GenJournalLine."Journal Batch Name":=Jbatch;
                        GenJournalLine."Document No.":=No;
                        GenJournalLine."Line No.":=GenJournalLine."Line No."+10000;
                        if BSched."Source Type"=BSched."source type"::Customer then begin
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Customer;
                        GenJournalLine."Transaction Type":=BSched."Transaction Type";
                        GenJournalLine."Account No.":=BSched."Source Account No.";
                        GenJournalLine."Loan No":=BSched.Loan;
                        end else
                        if BSched."Source Type"=BSched."source type"::MEMBER   then begin
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Employee;
                        GenJournalLine."Transaction Type":=BSched."Transaction Type";
                        GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                        GenJournalLine."Account No.":=BSched."Source Account No.";
                        GenJournalLine."Loan No":=BSched.Loan;
                        end else
                        
                        if BSched."Source Type"=BSched."source type"::Vendor then begin
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Transaction Type":=BSched."Transaction Type";
                        GenJournalLine."Shortcut Dimension 1 Code":='fOSA';
                        GenJournalLine."Account No.":=BSched."Source Account No.";
                        end else
                        if BSched."Source Type"=BSched."source type"::"G/L ACCOUNT" then begin
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Transaction Type":=BSched."Transaction Type";
                        GenJournalLine."Account No.":=BSched."Source Account No.";
                        end else
                        if BSched."Source Type"=BSched."source type"::Bank then begin
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
                        GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                        GenJournalLine."Account No.":=BSched."Source Account No.";
                        end;
                        GenJournalLine."Posting Date":="Transaction Date";
                        GenJournalLine.Description:=Remarks;
                        GenJournalLine.Amount:=BSched.Amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine.Insert;
                        GenJournalLine.Init;
                        
                        
                        GenJournalLine."Journal Template Name":=Jtemplate;
                        GenJournalLine."Journal Batch Name":=Jbatch;
                        GenJournalLine."Document No.":=No;
                        GenJournalLine."Line No.":=GenJournalLine."Line No."+10000;
                        /*
                        IF BSched."Destination Account Type"=BSched."Destination Account Type"::CUSTOMER THEN BEGIN
                        GenJournalLine."Account Type":=GenJournalLine."Account Type"::Customer;
                        GenJournalLine."Transaction Type":=BSched."Transaction Type";
                        GenJournalLine."Account No.":=BSched."Destination Account No.";
                        END ELSE
                        */
                        if BSched."Destination Account Type"=BSched."destination account type"::MEMBER then begin
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Employee;
                        GenJournalLine."Transaction Type":=BSched."Destination Type";
                        GenJournalLine."Account No.":=BSched."Destination Account No.";
                        end else
                        
                        if BSched."Destination Account Type"=BSched."destination account type"::FOSA then begin
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Transaction Type":=BSched."Transaction Type";
                        GenJournalLine."Account No.":=BSched."Destination Account No.";
                        end else
                        if BSched."Destination Account Type"=BSched."destination account type"::"G/L ACCOUNT" then begin
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=BSched."Destination Account No.";
                        
                        end else
                        if BSched."Destination Account Type"=BSched."destination account type"::BANK then begin
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
                        GenJournalLine."Account No.":=BSched."Destination Account No.";
                        end;
                        GenJournalLine."Loan No":=BSched."Destination Loan";
                        GenJournalLine.Validate(GenJournalLine."Loan No");
                        //GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":="Transaction Date";
                        GenJournalLine.Description:=Remarks;
                        GenJournalLine.Amount:=-BSched.Amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine.Insert;
                        until BSched.Next=0;
                        end;
                        
                        
                        
                        //Post
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",Jtemplate);
                        GenJournalLine.SetRange("Journal Batch Name",Jbatch);
                        if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch",GenJournalLine);
                        end;
                        
                        //Post
                        Posted:=true;
                        Modify;
                        
                        
                        
                        end;

                    end;
                }
                action(Print)
                {
                    ApplicationArea = Basic;
                    Caption = 'Print';
                    Image = Print;

                    trigger OnAction()
                    begin
                         BTRANS.Reset;
                         BTRANS.SetRange(BTRANS.No,No);
                         if BTRANS.Find('-') then begin
                         Report.Run(51516442,true,true,BTRANS);
                         end;
                    end;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        Error('Not Allowed!');
    end;

    var
        users: Record User;
        GenJournalLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        BSched: Record "BOSA TransferS Schedule";
        BTRANS: Record "BOSA Transfers";
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        FundsUSer: Record "Funds User Setup";
        Jtemplate: Code[10];
        Jbatch: Code[10];
}

