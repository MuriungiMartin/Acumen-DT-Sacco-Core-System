#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 55479 "BankAlertMgt FP"
{

    trigger OnRun()
    begin
        InitAlert();
    end;

    var
        CurrentUserID: Code[20];
        BankAcc: Record "Bank Account";
        TellerSetup: Record UnknownRecord55889;
        BuffAlert: Record UnknownRecord55913;
        Selection: Boolean;
        LineNo: Integer;


    procedure InitAlert()
    begin
        CurrentUserID:=UserId;
        if AlertUser then
          begin
            GetTellers();
          end
        else
          begin
            exit;
          end;
        ShowBankAlert();
    end;


    procedure GetTellers()
    begin
        //this function gets all the tellers who are supervised by the current user
        TellerSetup.Reset;
        TellerSetup.SetRange(TellerSetup."Supervisor ID",CurrentUserID);

        if TellerSetup.Find('-') then
          begin
            repeat
              GetTellerBalance
                              (
                              TellerSetup.UserID
                              ,TellerSetup."Default Receipts Bank"
                              ,TellerSetup."Max. Cash Collection"
                              );
            until TellerSetup.Next=0;
          end;
    end;


    procedure GetTellerBalance(var TellerID: Code[20];var "Bank No.": Code[20];var MaxBal: Decimal)
    var
        Balance: Decimal;
    begin
        //this function gets the teller balance from the database
        BankAcc.Reset;
        BankAcc.Get("Bank No.");
        BankAcc.CalcFields(BankAcc."Balance (LCY)");
        Balance:=BankAcc."Balance (LCY)";
          LineNo:=LineNo + 1;
        InsertAlertRecord();
          BuffAlert."Line No.":=LineNo;
          BuffAlert."Teller ID":=TellerID;
          BuffAlert.Validate(BuffAlert."Teller ID");
          BuffAlert."Account No.":=BankAcc."No.";
          BuffAlert."Account Name":=BankAcc.Name;
          BuffAlert."Max. Balance":=MaxBal;
          BuffAlert."Curr. Balance":=Balance;
          BuffAlert."Min. Balance":=BankAcc."Min. Balance";
          BuffAlert."Supervisor ID":=CurrentUserID;
        BuffAlert.Insert();
    end;


    procedure InsertAlertRecord()
    begin
        BuffAlert.Init;
    end;


    procedure AlertUser(): Boolean
    begin
        //CHECK IF THE USER SHOULD BE ALERTED IN RELATION TO THE BANK ALERTS

        TellerSetup.Reset;
        TellerSetup.SetRange(TellerSetup."Supervisor ID",CurrentUserID);

        BuffAlert.Reset;
        if BuffAlert.FindLast then
          begin
            LineNo:=BuffAlert."Line No.";
          end;

        BuffAlert.Reset;
        BuffAlert.SetRange(BuffAlert."Supervisor ID",CurrentUserID);
        if BuffAlert.Find('-') then
          begin
            BuffAlert.DeleteAll;
          end;

        //getthe last number from the database

        exit((TellerSetup.Count>0));
    end;


    procedure ShowBankAlert()
    begin
        //this function shows the form depending on whether the are people in the list who have more money that they should
        BuffAlert.Reset;
        BuffAlert.SetRange(BuffAlert."Supervisor ID",CurrentUserID);
        if BuffAlert.Find('-') then
          begin
            repeat
              BuffAlert.Mark(false);
              BuffAlert.Modify;
            until BuffAlert.Next=0;
          end;

        if BuffAlert.Find('-') then
          begin
            repeat
              if BuffAlert."Max. Balance"<=BuffAlert."Curr. Balance" then
                begin
                  BuffAlert.Mark(true);
                  BuffAlert.Modify;
                end;
            until BuffAlert.Next=0;
          end;

        //get the count of marked records
        BuffAlert.MarkedOnly(true);

        //check if the count is greater than zero
        if BuffAlert.Count>0 then
          begin
            Selection:=Confirm('Alert Some Tellers have reached the maximum allowable collection. View details?',false);
            case Selection of
                true://show the user the form
                  begin
                    Page.Run(56031,BuffAlert)
                  end;
                false://exit the screen
                  begin
                    exit;
                  end;
              end;
          end;
    end;


    procedure CreateCashRequest(var Rec: Record UnknownRecord55913;CurrUser: Code[20]): Code[20]
    var
        Request: Record UnknownRecord55914;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TSetup: Record UnknownRecord55889;
        CSSetup: Record UnknownRecord55903;
        UserSelection: Boolean;
        Req: Record UnknownRecord55914;
    begin
        //this function creates a cash request from the teller to the person who initiated the request
        with Rec do begin
          //INSERT THE REQUEST INTO THE DATABASE AFTER GETTING THE NEXT NUMBER IN THE REQUEST TABLE
            CSSetup.Reset;
            CSSetup.Get();
            Request.Init;
              Request."No.":=NoSeriesMgt.GetNextNo(CSSetup."Cash Request Nos",Today,true);
              Request."Request Date":=Today;
              Request."Request Time":=Time;
              Request."Requester ID":=CurrUser;
              Request.Validate(Request."Requester ID");
              Request."Request Amount":="Curr. Balance"-"Min. Balance";
              Request."Request From ID":="Teller ID";
              Request.Validate(Request."Request From ID");
              Request."Request From Acc. No.":="Account No.";
              Request."Curr. Balance":="Curr. Balance";
              Request."Max. Balance":="Max. Balance";
              Request."Min. Balance":="Min. Balance";
              Request."Amount Pending":=Request."Request Amount";
            //get the details of the person who is requesting for cash
              TSetup.Reset;
              if TSetup.Get(CurrUser) then
                begin
                  Request."Requester Acc. No.":=TSetup."Default Receipts Bank";
                end;
              "Request Created":=true;
              Modify;
            Request.Insert();
        end;
        if Request.Count <1 then begin exit end;
        //ask for user confirmation
        UserSelection:=Confirm('A Cash Request ' + Format(Request."No.") + ' has been created. View Request?',false);

        Request.SetRange(Request."No.",Request."No.");

        //check the user selection
        if (UserSelection) and (Req.Count>0) then
          begin
            exit(Request."No.");
          end;
    end;


    procedure RetrieveActiveRequests()
    var
        Requests: Record UnknownRecord55914;
    begin
        //this function gets the active requests from the database that have not been met
        with Requests do begin
          Reset;
          SetFilter(Requests."Request From ID",UserId);
          SetFilter(Requests.Posted,Format(true));
          if Find('-') then
            begin
              repeat
                if "Amount Pending"<>0 then
                  begin
                    Mark(true);
                    Modify;
                  end
                else
                  begin
                    Mark(false);
                    Modify;
                  end;
              until Next=0;
            end;
            MarkedOnly(true);
            if Count>0 then
              begin
                if Confirm
                          (
                            'You have some pending Requests. View Them ?'
                            ,
                            false
                          ) =false
                then
                  begin
                    exit;
                  end
                else
                  begin
                    Page.Run(56033,Requests);
                  end;
              end;
        end;
    end;


    procedure CreateCashIssue(var Request: Record UnknownRecord55914)
    var
        Issue: Record UnknownRecord55915;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CSSetup: Record UnknownRecord55903;
        Selection: Boolean;
    begin
        //this function creates an issue in relation to the a request that has been sent to the teller
        CSSetup.Get();
        with Issue do begin
          Init;
            Issue."No.":=NoSeriesMgt.GetNextNo(CSSetup."Cash Issue Nos",Today,true);
            Issue."Request No.":=Request."No.";
            Issue."Issue Date":=Today;
            Issue."Issue Time":=Time;
            Issue."Requester ID":=Request."Requester ID";
            Issue."Requester Name":=Request."Requester Name";
            Issue."Requester Acc. No.":=Request."Requester Acc. No.";
            Issue."Request Amount":=Request."Request Amount";
            Issue."Issuer ID":=UserId;
            Issue."Issuer Name":=Request."Request From Name";
            Issue."Issuer Acc. No.":=Request."Requester Acc. No.";
            Issue."Issue Amount":=Request."Amount Pending";
            Issue.Remarks:='';
          Insert;

          SetRange("No.","No.");

          if Count>0 then
            begin
              Selection:=Confirm('A Cash Issue Document ' + Issue."No." + ' has been created. View The Document ?',false);

              case Selection of
                true://show the issue form
                  begin
                    Page.Run(56034,Issue);
                  end;
                false://do not show issue form
                  begin
                  end;
              end;
            end;
        end;
    end;


    procedure RetrieveActiveIssues(): Boolean
    var
        Issue: Record UnknownRecord55915;
        Selection: Boolean;
    begin
        //this function retrieves the active issues and prompts user for response
        with Issue do begin
          Reset;
          SetFilter(Issue."Requester ID",UserId);
          SetFilter(Issue.Receipted,Format(false));
          SetFilter(Issue.Posted,Format(true));
          if FindFirst then
            begin
              //get the user option from the database
              Selection:=Confirm('There are pending cash issues. Do you wish to view them now?',false);

              case Selection of
                  true://show the form
                    begin
                      Page.Run(56036,Issue);
                    end;
                  false://decide what to do user can be forced to view and receipt here
                    begin
                      exit(false);
                    end;
                end;
            end;
        end;
    end;


    procedure CreateCashReceipt(var Issue: Record UnknownRecord55915)
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CSSetup: Record UnknownRecord55903;
        Receipt: Record UnknownRecord55916;
        Selection: Boolean;
    begin
        //this function creates a cash receipt in the database
        CSSetup.Get();
        with Receipt do begin
          Init;
            "No.":=NoSeriesMgt.GetNextNo(CSSetup."Cash Receipt Nos",Today,true);
            "Issue No.":=Issue."No.";
            "Receipt Date":=Today;
            "Receipt Time":=Time;
            "Issuer ID":=Issue."Issuer ID";
            "Issuer Name":=Issue."Issuer Name";
            "Issuer Acc. No.":=Issue."Issuer Acc. No.";
            "Issue Amount":=Issue."Issue Amount";
            "Receiver ID":=Issue."Requester ID";
            "Receiver Acc. No.":=Issue."Requester Acc. No.";
            "Receiver Amount":=Issue."Issue Amount";
            "Receiver Name":=Issue."Requester Name";
          Insert;
        end;

        //ask for user confirmation
        Selection:=Confirm('A Cash Receipt ' + Receipt."No." + ' has been created. View the created Cash Receipt?',false);

        //check the selection made by the user of the system
        case Selection of
            true://user wishes to view hence show the form
              begin
                Page.Run(56037,Receipt);
              end;
            false://user does not wish to view the form
              begin
              end;
          end;
    end;
}

