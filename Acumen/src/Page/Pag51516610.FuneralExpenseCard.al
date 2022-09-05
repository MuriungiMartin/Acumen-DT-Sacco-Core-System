#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516610 "Funeral Expense Card"
{
    SourceTable = "Funeral Expense Payment";

    layout
    {
        area(content)
        {
            field("No."; "No.")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Member No."; "Member No.")
            {
                ApplicationArea = Basic;
            }
            field("Member Name"; "Member Name")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Member ID No"; "Member ID No")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Member Status"; "Member Status")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Death Date"; "Death Date")
            {
                ApplicationArea = Basic;
            }
            field("Date Reported"; "Date Reported")
            {
                ApplicationArea = Basic;
            }
            field("Reported By"; "Reported By")
            {
                ApplicationArea = Basic;
            }
            field("Reporter ID No."; "Reporter ID No.")
            {
                ApplicationArea = Basic;
            }
            field("Reporter Mobile No"; "Reporter Mobile No")
            {
                ApplicationArea = Basic;
            }
            field("Reporter Address"; "Reporter Address")
            {
                ApplicationArea = Basic;
            }
            field("Relationship With Deceased"; "Relationship With Deceased")
            {
                ApplicationArea = Basic;
            }
            field("Received Burial Permit"; "Received Burial Permit")
            {
                ApplicationArea = Basic;
            }
            field("Mode Of Disbursement"; "Mode Of Disbursement")
            {
                ApplicationArea = Basic;
            }
            field("Paying Bank"; "Paying Bank")
            {
                ApplicationArea = Basic;
            }
            field("Received Letter From Chief"; "Received Letter From Chief")
            {
                ApplicationArea = Basic;
            }
            field(Posted; Posted)
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Date Posted"; "Date Posted")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Time Posted"; "Time Posted")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Posted By"; "Posted By")
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
    }

    actions
    {
        area(creation)
        {
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
                    DocumentType := Documenttype::"Member Closure";
                    ApprovalEntries.Setfilters(Database::"HR Leave Register", DocumentType, "No.");
                    ApprovalEntries.Run;
                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                    ApprovalMgt: Codeunit WorkflowIntegration;
                begin
                    if Status <> Status::Open then
                        Error(text001);

                    //End allocate batch number
                    Doc_Type := Doc_type::"Member Closure";
                    Table_id := Database::"Membership Exit";
                    //IF ApprovalMgt.SendApproval(Table_id,"No.",Doc_Type,Status)THEN;
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel A&pproval Request';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                    ApprovalMgt: Codeunit WorkflowIntegration;
                begin
                    if Status <> Status::Open then
                        Error(text001);

                    //End allocate batch number
                    //ApprovalMgt.CancelClosureApprovalRequest(Rec);
                end;
            }
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

                    //Delete journal line
                    Gnljnline.Reset;
                    Gnljnline.SetRange("Journal Template Name", 'GENERAL');
                    Gnljnline.SetRange("Journal Batch Name", 'FRIDER');
                    Gnljnline.DeleteAll;
                    //End of deletion


                    DActivity := Cust."Global Dimension 1 Code";
                    DBranch := Cust."Global Dimension 2 Code";
                    Cust.CalcFields(Cust."Outstanding Balance", "Accrued Interest", "Current Shares");

                    Cust.CalcFields(Cust."Outstanding Balance", Cust."Outstanding Interest", "FOSA Outstanding Balance", "Accrued Interest", "Insurance Fund", "Current Shares");

                    Generalsetup.Get();

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'FRIDER';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine."External Document No." := "No.";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                    GenJournalLine."Account No." := "Member No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Funeral Rider';
                    GenJournalLine.Amount := Generalsetup."Funeral Expense Amount";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //   GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"48";
                    GenJournalLine."Bal. Account No." := "Paying Bank";
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Post New
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'FRIDER');
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
                    end;


                    Posted := true;
                    "Posted By" := UserId;
                    "Time Posted" := Time;
                    Modify;
                    Message('Funeral Rider posted successfully.');

                    //CHANGE ACCOUNT STATUS
                    Cust.Reset;
                    Cust.SetRange(Cust."No.", "Member No.");
                    if Cust.Find('-') then begin
                        Cust.Status := Cust.Status::Deceased;
                        Cust.Blocked := Cust.Blocked::All;
                        Cust.Modify;
                    end;
                end;
            }
        }
    }

    var
        Generalsetup: Record "Sacco General Set-Up";
        Gnljnline: Record "Gen. Journal Line";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff;
        DActivity: Code[30];
        DBranch: Code[30];
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening","Member Closure",Loan,"Loan Batch";
        Cust: Record Customer;
}

