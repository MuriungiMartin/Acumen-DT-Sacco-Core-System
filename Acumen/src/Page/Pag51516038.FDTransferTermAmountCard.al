#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516038 "FD Transfer Term Amount Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "FD Processing";
    SourceTableView = where(Posted=const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Editable;
                field("Document No.";"Document No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Document No.';
                }
                field("Savings Account No.";"Savings Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Current Account No';
                }
                field("BOSA Account No";"BOSA Account No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No';
                    Visible = false;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Name';
                }
                field("Personal No.";"Personal No.")
                {
                    ApplicationArea = Basic;
                }
                field("ID No.";"ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone No";"Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date";"Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        if "Application Date" <> Today then Error('Application day must be equql to today!');
                    end;
                }
                field("Global Dimension 1 Code";"Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 2 Code";"Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("FDR Deposit Status Type";"FDR Deposit Status Type")
                {
                    ApplicationArea = Basic;
                }
                field("Date Posted";"Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type";"Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Current Account Balance";"Current Account Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account";"Destination Account")
                {
                    ApplicationArea = Basic;
                }
                field("Call Deposit";"Call Deposit")
                {
                    ApplicationArea = Basic;
                }
                field("User ID";"User ID")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                }
            }
            group("Term Deposit Details")
            {
                Caption = 'Term Deposit Details';
                Editable = Editable;
                Visible = true;
                field("Fixed Deposit Status";"Fixed Deposit Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Fixed Deposit Start Date";"Fixed Deposit Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Fixed Deposit Type";"Fixed Deposit Type")
                {
                    ApplicationArea = Basic;
                }
                field("Fixed Duration";"Fixed Duration")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Earned";"Interest Earned")
                {
                    ApplicationArea = Basic;
                }
                field("Untranfered Interest";"Untranfered Interest")
                {
                    ApplicationArea = Basic;
                }
                field("FD Maturity Date";"FD Maturity Date")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Maturity Date";"Expected Maturity Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Amount to Transfer";"Amount to Transfer")
                {
                    ApplicationArea = Basic;
                }
                field("Interest rate";"Interest rate")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Last Interest Earned Date";"Last Interest Earned Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Interest On Term Dep";"Expected Interest On Term Dep")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("On Term Deposit Maturity";"On Term Deposit Maturity")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Previous Term Deposits")
            {
                Caption = 'Previous Term Deposits';
                Editable = Editable;
                field("Prevous Fixed Deposit Type";"Prevous Fixed Deposit Type")
                {
                    ApplicationArea = Basic;
                }
                field("Prevous FD Start Date";"Prevous FD Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Prevous Fixed Duration";"Prevous Fixed Duration")
                {
                    ApplicationArea = Basic;
                }
                field("Prevous Expected Int On FD";"Prevous Expected Int On FD")
                {
                    ApplicationArea = Basic;
                }
                field("Prevous FD Maturity Date";"Prevous FD Maturity Date")
                {
                    ApplicationArea = Basic;
                }
                field("Prevous FD Deposit Status Type";"Prevous FD Deposit Status Type")
                {
                    ApplicationArea = Basic;
                }
                field("Prevous Interest Rate FD";"Prevous Interest Rate FD")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Approval)
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
                    /*DocumentType:=DocumentType::"Account Opening";
                    ApprovalEntries.Setfilters(DATABASE::"Membership Applications",DocumentType,"No.");
                    ApprovalEntries.RUN;*/

                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    Text001: label 'This request is already pending approval';
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    TestField("Global Dimension 1 Code");
                    TestField("Global Dimension 2 Code");
                    TestField("Destination Account");
                    TestField("Amount to Transfer");
                    /*
                    IF ApprovalsMgmt.CheckFixedDepositApprovalWorkflowEnabled(Rec) THEN
                      ApprovalsMgmt.OnSendFixedDepositForApproval(Rec);
                      */

                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Request';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    Approvalmgt: Codeunit "Approvals Mgmt.";
                begin
                    if Status<>Status::"Pending Approval" then
                      Error(Text0001)
                    /*ELSE
                    IF ApprovalsMgmt.CheckFixedDepositApprovalWorkflowEnabled(Rec) THEN
                      ApprovalsMgmt.OnCancelFixedDepositForApproval(Rec);
                    */

                end;
            }
        }
        area(processing)
        {
            action("Transfer Term Amnt from Current")
            {
                ApplicationArea = Basic;
                Caption = 'Transfer &Post';
                Promoted = true;

                trigger OnAction()
                begin
                    
                    //Transfer Balance if Fixed Deposit
                    TestField(Status,Status::Approved);
                    
                    AccountTypes.Reset;
                    AccountTypes.SetRange(AccountTypes.Code,"Account Type");
                    if AccountTypes.Find('-') then  begin
                      //IF AccountTypes."Fixed Deposit" <> TRUE THEN BEGIN
                      if Vend.Get("Savings Account No.") then begin
                        if Confirm('Are you sure you want to effect the transfer from the Current account',false) = false then
                        exit else
                    
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange(GenJournalLine."Journal Template Name",'PURCHASES');
                        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name",'TERM');
                        if GenJournalLine.Find('-') then
                        GenJournalLine.DeleteAll;
                    
                        // Vend.RESET;
                        // IF Vend.FIND('-') THEN
                        // Vend.CALCFIELDS(Vend.Balance);
                        // IF Vend.Balance<"Amount to Transfer" THEN
                        //   ERROR('You do not have sufficient funds to effect the transfer');
                        //IF (Vend."Balance (LCY)" - 500) < "Fixed Deposit Amount" THEN
                        //ERROR('Savings account does not have enough money to facilate the requested trasfer.');
                        //MESSAGE('Katabaka ene!');
                    
                        Vend.CalcFields(Vend.Balance);
                        if Vend.Balance<"Amount to Transfer" then
                         Error('You do not have sufficient funds in your currentr account to effect the transfer');
                    
                    
                        LineNo:=LineNo+10000;
                    
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Journal Batch Name":='TERM';
                        GenJournalLine."Document No.":="Document No.";
                        GenJournalLine."External Document No.":="Document No.";
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":="Savings Account No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Term Balance Tranfers';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        //GenJournalLine.Amount:="Fixed Deposit Amount";
                        GenJournalLine.Amount:="Amount to Transfer";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                         //MESSAGE('The FDR amount is %1 ',"Fixed Deposit Amount");
                        LineNo:=LineNo+10000;
                    
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Journal Batch Name":='TERM';
                        GenJournalLine."Document No.":="Document No.";
                        GenJournalLine."External Document No.":="Document No.";
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":="Destination Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Term Balance Tranfers';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        //GenJournalLine.Amount:=-"Fixed Deposit Amount";
                        GenJournalLine.Amount:=-"Amount to Transfer";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                    
                        //END;
                    
                    
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name",'TERM');
                        if GenJournalLine.Find('-') then begin
                        repeat
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco",GenJournalLine);
                        until GenJournalLine.Next = 0;
                        end;
                        Posted:=true;
                        "Date Posted":=Today;
                        "FDR Deposit Status Type":="fdr deposit status type"::Running;
                        "Fixed Deposit Status":="fixed deposit status"::Active;
                        "Fixed Deposit Start Date":=Today;
                        Validate("Fixed Deposit Start Date");
                        Modify;
                      end;
                    end;
                    
                    //Kimondiu -Print Certificate after transfer
                    ObjFDProcessing.Reset;
                    //ObjFDProcessing.SETRANGE(ObjFDProcessing."Document No.","Document No.");
                    if ObjFDProcessing.Find('-') then
                     Report.Run(51516711,false,false,ObjFDProcessing);
                    
                    
                    
                    /*//Post New
                    
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                    GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
                    IF GenJournalLine.FIND('-') THEN BEGIN
                    CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                    END;
                    
                    //Post New
                    */
                    
                    /*
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                    GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
                    GenJournalLine.DELETEALL;
                    
                       */
                    //Transfer Balance if Fixed Deposit

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        fnUpdateControls();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        FDRec.Reset;
        FDRec.SetRange(FDRec."User ID",UserId);
        FDRec.SetRange(FDRec.Status,FDRec.Status::New);
        if FDRec.Count > 0 then Error('Cannot create a new FD card while an unutilized one exists.');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Application Date":=Today;
        "User ID":=UserId;
        "Global Dimension 1 Code":='FOSA';
        "Account Type":='FIXED';

        fnUpdateControls();
    end;

    var
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        CustomizedCalEntry: Record "Customized Calendar Entry";
        CustomizedCalendar: Record "Customized Calendar Change";
        PictureExists: Boolean;
        AccountTypes: Record "Account Types-Saving Products";
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        StatusPermissions: Record "Status Change Permision";
        Charges: Record Charges;
        ForfeitInterest: Boolean;
        InterestBuffer: Record "Interest Buffer";
        FDType: Record "Fixed Deposit Type";
        Vend: Record Vendor;
        Cust: Record "Member Register";
        LineNo: Integer;
        UsersID: Record User;
        DActivity: Code[20];
        DBranch: Code[20];
        MinBalance: Decimal;
        OBalance: Decimal;
        OInterest: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        TotalRecovered: Decimal;
        LoansR: Record "Loans Register";
        LoanAllocation: Decimal;
        LGurantors: Record "Loan GuarantorsFOSA";
        Loans: Record "Loans Register";
        DefaulterType: Code[20];
        LastWithdrawalDate: Date;
        AccountType: Record "Account Types-Saving Products";
        ReplCharge: Decimal;
        Acc: Record Vendor;
        SearchAcc: Code[10];
        Searchfee: Decimal;
        Statuschange: Record "Status Change Permision";
        UnclearedLoan: Decimal;
        LineN: Integer;
        Joint2DetailsVisible: Boolean;
        Joint3DetailsVisible: Boolean;
        GenSetup: Record "Sacco General Set-Up";
        ObjFDProcessing: Record "Loan Repay Schedule-Calc";
        ObjGroup: Boolean;
        undisplay: Integer;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        Text0001: label 'Status must be pending Approval';
        Editable: Boolean;
        FDRec: Record "FD Processing";

    local procedure fnUpdateControls()
    begin
        if (Status=Status::Approved) or (Status=Status::"Pending Approval") then
          Editable:=false
        else
          Editable:=true;
    end;
}

