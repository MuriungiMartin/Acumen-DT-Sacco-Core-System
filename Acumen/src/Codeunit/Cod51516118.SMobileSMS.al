#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516118 "SMobileSMS"
{

    trigger OnRun()
    begin
        SelectTopMessage();
    end;

    var
        SMSMessages: Record "SMS Messages";


    procedure PollPendingSMS() MessageDetails: Text[500]
    begin
          begin
          SMSMessages.Reset;
          SMSMessages.SetRange(SMSMessages."Sent To Server", 0);
          if SMSMessages.FindFirst() then
            begin
                 MessageDetails:=SMSMessages."Telephone No"+':'+SMSMessages."SMS Message";
                Message(MessageDetails);
            end
          else
          begin
             MessageDetails:='';
          end
          end;
    end;


    procedure ConfirmSent(TelephoneNo: Text[20];Status: Integer)
    begin
        begin
          SMSMessages.Reset;
          SMSMessages.SetRange(SMSMessages."Sent To Server", 0);
          SMSMessages.SetRange(SMSMessages."Telephone No", TelephoneNo);
          if SMSMessages.FindFirst() then
            begin
                 SMSMessages."Sent To Server":=1;
                 SMSMessages.Modify;
            end
         end;
    end;


    procedure SelectTopMessage() result: Text[500]
    begin
          begin
          SMSMessages.Reset;
          SMSMessages.SetRange(SMSMessages."Sent To Server", 0);
          if SMSMessages.FindFirst() then
            begin
                 result:=SMSMessages."SMS Message";
                //MESSAGE(result);
            end
          else
          begin
             result:='';
          end
          end;
          //EXIT
    end;


    procedure UpdateSentMessages(MessageId: Text[500])
    begin
        begin
          SMSMessages.Reset;
          SMSMessages.SetRange(SMSMessages."Sent To Server", 0);
          SMSMessages.SetRange(SMSMessages."SMS Message", MessageId);
          if SMSMessages.Find('-') then
            begin
                 SMSMessages."Sent To Server":=1;
                 SMSMessages.Modify;
            end
         end;
    end;
}

