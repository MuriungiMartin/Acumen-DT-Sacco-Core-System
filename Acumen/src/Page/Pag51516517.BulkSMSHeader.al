#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516517 "Bulk SMS Header"
{
    SourceTable = "Bulk SMS Header";

    layout
    {
        area(content)
        {
            field(No;No)
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Date Entered";"Date Entered")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Time Entered";"Time Entered")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Entered By";"Entered By")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("SMS Type";"SMS Type")
            {
                ApplicationArea = Basic;
            }
            field("SMS Status";"SMS Status")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Status Date";"Status Date")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Status Time";"Status Time")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Status By";"Status By")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field(Message;Message)
            {
                ApplicationArea = Basic;
                Editable = Mssage;
            }
            part(Control1000000012;"Bulk SMS Lines Part")
            {
                Caption = '<Bulk SMS Lines>';
                Editable = BulkSMSLines;
                SubPageLink = No=field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Send)
            {
                ApplicationArea = Basic;
                Image = PutawayLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ///Kyalo Code from Old System for Sending SMS
                    //*******************************************************************************************************
                    
                    if Confirm('Are you sure you would like to send the SMS(ES)?',false)=true then begin
                    TestField(Message);
                    BulkHeader.Reset;
                    BulkHeader.SetRange(BulkHeader.No,No);
                    if BulkHeader.Find('-') then begin
                    
                    //ALL
                    if BulkHeader."SMS Type"=BulkHeader."sms type"::Everyone then begin
                    Vend.Reset;
                    Vend.SetRange(Vend."Creditor Type",Vend."creditor type"::"FOSA Account");
                    Vend.SetRange(Vend."Vendor Posting Group",'SAVINGS');
                    if Vend.Find('-') then begin
                    repeat
                    //SMS MESSAGE
                    SMSMessage.Reset;
                    if SMSMessage.Find('+') then begin
                    iEntryNo:=SMSMessage."Entry No";
                    iEntryNo:=iEntryNo+1;
                    end
                    else begin
                    iEntryNo:=1;
                    end;
                    
                    SMSMessage.Init;
                    SMSMessage."Entry No":=iEntryNo;
                    SMSMessage."Batch No":=No;
                    SMSMessage."Document No":='';
                    SMSMessage."Account No":=Vend."No.";
                    SMSMessage."Date Entered":=Today;
                    SMSMessage."Time Entered":=Time;
                    SMSMessage.Source:='BULK';
                    SMSMessage."Entered By":=UserId;
                    SMSMessage."Sent To Server":=SMSMessage."sent to server"::No;
                    SMSMessage."SMS Message":=Message;
                    SMSMessage."Telephone No":=Vend."Phone No.";
                    if Vend."Phone No."<>'' then
                    SMSMessage.Insert;
                    
                    until Vend.Next=0
                    end;
                    end;
                    
                    //DIMENSION
                    if BulkHeader."SMS Type"=BulkHeader."sms type"::Dimension then begin
                    BulkLines.Reset;
                    BulkLines.SetRange(BulkLines.No,No);
                    if BulkLines.Find('-') then begin
                    repeat
                    
                    Vend.Reset;
                    Vend.SetRange(Vend."Creditor Type",Vend."creditor type"::"FOSA Account");
                    Vend.SetRange(Vend."Vendor Posting Group",'SAVINGS');
                    Vend.SetRange(Vend."Global Dimension 1 Code",BulkLines.Code);
                    if Vend.Find('-') then begin
                    repeat
                    //SMS MESSAGE
                    SMSMessage.Reset;
                    if SMSMessage.Find('+') then begin
                    iEntryNo:=SMSMessage."Entry No";
                    iEntryNo:=iEntryNo+1;
                    end
                    else begin
                    iEntryNo:=1;
                    end;
                    
                    SMSMessage.Init;
                    SMSMessage."Entry No":=iEntryNo;
                    SMSMessage."Batch No":=No;
                    SMSMessage."Document No":='';
                    SMSMessage."Account No":=Vend."No.";
                    SMSMessage."Date Entered":=Today;
                    SMSMessage."Time Entered":=Time;
                    SMSMessage.Source:='BULK';
                    SMSMessage."Entered By":=UserId;
                    SMSMessage."Sent To Server":=SMSMessage."sent to server"::No;
                    SMSMessage."SMS Message":=Message;
                    SMSMessage."Telephone No":=Vend."Phone No.";
                    if Vend."Phone No."<>'' then
                    SMSMessage.Insert;
                    
                    until Vend.Next=0
                    end;
                    
                    until BulkLines.Next=0
                    end;
                    end;
                    
                    //Telephone
                    if BulkHeader."SMS Type"=BulkHeader."sms type"::Telephone then begin
                    BulkLines.Reset;
                    BulkLines.SetRange(BulkLines.No,No);
                    if BulkLines.Find('-') then begin
                    repeat
                    
                    //SMS MESSAGE
                    SMSMessage.Reset;
                    if SMSMessage.Find('+') then begin
                    iEntryNo:=SMSMessage."Entry No";
                    iEntryNo:=iEntryNo+1;
                    end
                    else begin
                    iEntryNo:=1;
                    end;
                    
                    SMSMessage.Init;
                    SMSMessage."Entry No":=iEntryNo;
                    SMSMessage."Batch No":=No;
                    SMSMessage."Document No":='';
                    SMSMessage."Account No":=BulkLines.Code;
                    SMSMessage."Date Entered":=Today;
                    SMSMessage."Time Entered":=Time;
                    SMSMessage.Source:='BULK';
                    SMSMessage."Entered By":=UserId;
                    SMSMessage."Sent To Server":=SMSMessage."sent to server"::No;
                    SMSMessage."SMS Message":=Message;
                    SMSMessage."Telephone No":=BulkLines.Code;
                    if BulkLines.Code<>'' then
                    SMSMessage.Insert;
                    
                    
                    until BulkLines.Next=0
                    end;
                    end;
                    
                    
                    "SMS Status" := "sms status"::Sent;
                    "Status Date" := Today;
                    "Status Time" := Time;
                    "Status By" := UserId;
                    Modify;
                    
                    end;
                    end;
                    ///********************************************************************************************************////
                    /*
                    
                    IF "SMS Status"<>"SMS Status"::Pending THEN
                    ERROR('This sms has already been sent');
                    IF CONFIRM('Are you sure you would like to send the SMS(ES)?',FALSE)=TRUE THEN BEGIN
                    IF "SMS Type" <> "SMS Type"::Telephone THEN BEGIN
                    TESTFIELD(Message);
                    END;
                    
                    IF "SMS Type" = "SMS Type"::Telephone THEN BEGIN
                    IF "Use Line Message"   = TRUE THEN BEGIN
                    TESTFIELD(Message);
                    END;
                    END;
                    
                    
                    BulkHeader.RESET;
                    BulkHeader.SETRANGE(BulkHeader.No,No);
                    IF BulkHeader.FIND('-') THEN BEGIN
                    
                    //ALL
                    IF BulkHeader."SMS Type"=BulkHeader."SMS Type"::Everyone THEN BEGIN
                    Vend.RESET;
                    Vend.SETRANGE(Vend."Creditor Type",Vend."Creditor Type"::Account);
                    Vend.SETRANGE(Vend."Vendor Posting Group",'SAVINGS');
                    IF Vend.FIND('-') THEN BEGIN
                    REPEAT
                    //SMS MESSAGE
                    SMSMessage.RESET;
                    IF SMSMessage.FIND('+') THEN BEGIN
                    iEntryNo:=SMSMessage."Entry No";
                    iEntryNo:=iEntryNo+1;
                    END
                    ELSE BEGIN
                    iEntryNo:=1;
                    END;
                    
                    SMSMessage.INIT;
                    SMSMessage."Entry No":=iEntryNo;
                    SMSMessage."Batch No":=No;
                    SMSMessage."Document No":='';
                    SMSMessage."Account No":=Vend."No.";
                    SMSMessage."Date Entered":=TODAY;
                    SMSMessage."Time Entered":=TIME;
                    SMSMessage.Source:='BULK';
                    SMSMessage."Entered By":=USERID;
                    SMSMessage."Sent To Server":=SMSMessage."Sent To Server"::No;
                    SMSMessage."SMS Message":=Message;
                    
                          IF  Vend."Phone No."<>'' THEN BEGIN
                            SMSMessage."Telephone No":= Vend."Phone No.";
                          END ELSE IF Vend."Mobile Phone No"<>'' THEN BEGIN
                            SMSMessage."Telephone No":=Vend."Mobile Phone No";
                          END ELSE BEGIN
                            SMSMessage."Telephone No":=Vend."MPESA Mobile No";
                          END;
                    
                    IF SMSMessage."Telephone No"<>'' THEN
                      SMSMessage.INSERT;
                    
                    //IF Vend."MPESA Mobile No"<>'' THEN
                    //SMSMessage.INSERT;
                    
                    UNTIL Vend.NEXT=0
                    END;
                    END;
                    
                    {
                    //DIMENSION
                    IF BulkHeader."SMS Type"=BulkHeader."SMS Type"::Dimension THEN BEGIN
                    BulkLines.RESET;
                    BulkLines.SETRANGE(BulkLines.No,No);
                    IF BulkLines.FIND('-') THEN BEGIN
                    REPEAT
                    
                    Vend.RESET;
                    Vend.SETRANGE(Vend."Creditor Type",Vend."Creditor Type"::Account);
                    Vend.SETRANGE(Vend."Vendor Posting Group",'SAVINGS');
                    Vend.SETRANGE(Vend."Global Dimension 1 Code",BulkLines.Code);
                    IF Vend.FIND('-') THEN BEGIN
                    REPEAT
                    //SMS MESSAGE
                    SMSMessage.RESET;
                    IF SMSMessage.FIND('+') THEN BEGIN
                    iEntryNo:=SMSMessage."Entry No";
                    iEntryNo:=iEntryNo+1;
                    END
                    ELSE BEGIN
                    iEntryNo:=1;
                    END;
                    
                    SMSMessage.INIT;
                    SMSMessage."Entry No":=iEntryNo;
                    SMSMessage."Batch No":=No;
                    SMSMessage."Document No":='';
                    SMSMessage."Account No":=Vend."No.";
                    SMSMessage."Date Entered":=TODAY;
                    SMSMessage."Time Entered":=TIME;
                    SMSMessage.Source:='BULK';
                    SMSMessage."Entered By":=USERID;
                    SMSMessage."Sent To Server":=SMSMessage."Sent To Server"::No;
                    SMSMessage."SMS Message":=Message;
                    SMSMessage."Telephone No":=Vend."MPESA Mobile No";
                    IF Vend."MPESA Mobile No"<>'' THEN
                    SMSMessage.INSERT;
                    
                    UNTIL Vend.NEXT=0
                    END;
                    
                    UNTIL BulkLines.NEXT=0
                    END;
                    END;
                    }
                    
                    //Telephone
                    IF BulkHeader."SMS Type"=BulkHeader."SMS Type"::Telephone THEN BEGIN
                    BulkLines.RESET;
                    BulkLines.SETRANGE(BulkLines.No,No);
                    IF BulkLines.FIND('-') THEN BEGIN
                    REPEAT
                    
                    //SMS MESSAGE
                    SMSMessage.RESET;
                    IF SMSMessage.FIND('+') THEN BEGIN
                    iEntryNo:=SMSMessage."Entry No";
                    iEntryNo:=iEntryNo+1;
                    END
                    ELSE BEGIN
                    iEntryNo:=1;
                    END;
                    
                    
                    
                    SMSMessage.INIT;
                    SMSMessage."Entry No":=iEntryNo;
                    SMSMessage."Batch No":=No;
                    SMSMessage."Document No":='';
                    SMSMessage."Account No":=BulkLines.Code;
                    SMSMessage."Date Entered":=TODAY;
                    SMSMessage."Time Entered":=TIME;
                    SMSMessage.Source:='BULK';
                    SMSMessage."Entered By":=USERID;
                    SMSMessage."Sent To Server":=SMSMessage."Sent To Server"::No;
                    IF "Use Line Message" = TRUE THEN BEGIN
                    SMSMessage."SMS Message":=Message;
                    END
                    ELSE BEGIN
                    //SMSMessage."SMS Message":=BulkLines.Description;
                    
                    SMSMessage."SMS Message":=Message;
                    END;
                    
                    SMSMessage."Telephone No":=BulkLines.Code;
                    IF BulkLines.Code<>'' THEN
                    SMSMessage.INSERT;
                    
                    
                    
                    UNTIL BulkLines.NEXT=0
                    END;
                    END;
                    
                    
                    END;
                    
                    "SMS Status" := "SMS Status"::Sent;
                    "Status Date" := TODAY;
                    "Status Time" := TIME;
                    "Status By" := USERID;
                    MODIFY;
                    
                    END;
                    */

                end;
            }
            action("Import Telephone Nos")
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    if "SMS Type"<>"sms type"::Telephone then begin
                    Error('SMS Type must be Telephone.');
                    end;

                    BulkHeader.Reset;
                    BulkHeader.SetRange(BulkHeader.No,No);
                    if BulkHeader.Find('-') then begin
                    BulkLines.Reset;
                    BulkLines.SetRange(BulkLines.No,BulkHeader.No);
                    Xmlport.Run(51516016);
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "SMS Type":="sms type"::Telephone;
    end;

    var
        BulkHeader: Record "Bulk SMS Header";
        BulkLines: Record "Bulk SMS Lines";
        Vend: Record Vendor;
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        StatusPermissions: Record "Status Change Permision";
        ApprovalEntries: Page "Approval Entries";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,ImprestSurrender,"MSacco Applications","MSacco PinChange","MSacco PhoneChange","MSacco TransChange",BulkSMS;
        text001: label 'Status must be Open';
        text002: label 'Status must be Pending';
        Mssage: Boolean;
        UseHeader: Boolean;
        BulkSMSLines: Boolean;


    procedure UpdateControl()
    begin
        if Status=Status::Open then begin
        Mssage:=true;
        UseHeader:=true;
        BulkSMSLines:=true;
        end;

        if Status=Status::Pending then begin
        Mssage:=false;
        UseHeader:=false;
        BulkSMSLines:=false;
        end;

        if Status=Status::Rejected then begin
        Mssage:=false;
        UseHeader:=false;
        BulkSMSLines:=false;
        end;


        if Status=Status::Approved then begin
        Mssage:=false;
        UseHeader:=false;
        BulkSMSLines:=false;
        end;
    end;
}

