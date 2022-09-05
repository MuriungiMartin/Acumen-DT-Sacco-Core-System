#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516366 "Member List"
{
    ApplicationArea = Basic;
    Caption = 'Member List';
    CardPageID = "Member Account Card";
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = Customer;
    SourceTableView = sorting("No.")
                      order(ascending)
                      where("Customer Type" = const(Member));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Account No."; "FOSA Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field(Pin; Pin)
                {
                    ApplicationArea = Basic;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Introduced By"; "Introduced By")
                {
                    ApplicationArea = Basic;
                }
                field("Reg Fee Paid."; "Reg Fee Paid.")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Name"; "Employer Name")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone No"; "Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA  Account Bal"; "FOSA  Account Bal")
                {
                    ApplicationArea = Basic;
                }
                field("Account Category"; "Account Category")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("Current Shares"; "Current Shares")
                {
                    ApplicationArea = Basic;
                }
                field("Registration Date"; "Registration Date")
                {
                    ApplicationArea = Basic;
                }
                field("Registration Fee Paid"; "Registration Fee Paid")
                {
                    ApplicationArea = Basic;
                }
                field("Recruited By"; "Recruited By")
                {
                    ApplicationArea = Basic;
                }
                field("Member class"; "Member class")
                {
                    ApplicationArea = Basic;
                }
                field("Personal No"; "Personal No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No';
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755032; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                Editable = false;
                SubPageLink = "No." = field("No.");
                Visible = true;
            }
            part(Control15; "Member Picture-Uploaded")
            {
                Caption = 'Picture';
                Editable = false;
                ShowFilter = false;
                SubPageLink = "No." = field("No.");
            }
            part(Control14; "Member Signature-Uploaded")
            {
                Caption = 'Signature';
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(ActionGroup1102755024)
            {
                action("Member Ledger Entries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Ledger Entries';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Member Ledger Entries";
                    RunPageLink = "Customer No." = field("No.");
                    RunPageView = sorting("Customer No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "No." = field("No.");
                    Visible = false;
                }
                action("Bank Account")
                {
                    ApplicationArea = Basic;
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer Bank Account Card";
                    RunPageLink = "Customer No." = field("No.");
                    Visible = false;
                }
                action(Contacts)
                {
                    ApplicationArea = Basic;
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        ShowContact;
                    end;
                }
            }
            group("Issued Documents")
            {
                Caption = 'Issued Documents';
                Visible = false;
                action("Loans Guaranteed")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Guarantors';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*
                        Cust.RESET;
                        Cust.SETRANGE(Cust."No.","No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(,TRUE,FALSE,Cust);
                        */

                    end;
                }
                action("Loans Guarantors")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Guaranteed';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*Cust.RESET;
                        Cust.SETRANGE(Cust."No.","No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(,TRUE,FALSE,Cust);
                        */

                    end;
                }
            }
            group(ActionGroup1102755013)
            {
                action("Members Kin Details List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Members Kin Details List';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Members Nominee Details List";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Members Statistics")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Details';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Members Statistics";
                    RunPageLink = "No." = field("No.");
                }
                action("Members Guaranteed")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Loans Guarantee Details";
                    RunPageLink = Name = field(Name);
                    RunPageMode = View;

                    trigger OnAction()
                    begin
                        LGurantors.Reset;
                        LGurantors.SetRange(LGurantors."Loan No", "No.");
                        if LGurantors.Find('-') then
;
                    end;
                }
                action("Check Off Slip")
                {
                    ApplicationArea = Basic;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516456, true, false, Cust);
                    end;
                }
                separator(Action1102755008)
                {
                }
            }
            group(ActionGroup1102755007)
            {
                action(Statement)
                {
                    ApplicationArea = Basic;
                    Caption = 'Detailed Statement';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        if ("Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
                            if UserSetup.Get(UserId) then begin
                                if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
                            end;

                        end;
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516886, true, false, Cust);
                    end;
                }
                action("Statement New")
                {
                    ApplicationArea = Basic;
                    Caption = 'New Detailed Statement';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        if ("Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
                            if UserSetup.Get(UserId) then begin
                                if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
                            end;

                        end;
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516307, true, false, Cust);
                    end;
                }
                action("Loan Statement BOSA")
                {
                    ApplicationArea = Basic;
                    Image = customer;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516531, true, false, Cust);
                    end;
                }
                action("Loan Statement BOSA new")
                {
                    ApplicationArea = Basic;
                    Caption = 'New Loan Statment';
                    Image = customer;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516308, true, false, Cust);
                    end;
                }
                action("Member Deposits Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516354, true, false, Cust);
                    end;
                }
                action("Account Closure Slip")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Closure Slip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516390, true, false, Cust);
                    end;
                }
                action("Send Checkoff")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin
                        FnGenerateCheckoffSlips(Rec."No.", Rec."No." + '.pdf');
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        MemberLiability := SFactory.FnGetMemberLiability("No.");
    end;

    var
        Cust: Record Customer;
        GeneralSetup: Record "Sacco General Set-Up";
        Gnljnline: Record "Gen. Journal Line";
        TotalRecovered: Decimal;
        TotalAvailable: Integer;
        Loans: Record "Loans Register";
        TotalFOSALoan: Decimal;
        TotalOustanding: Decimal;
        Vend: Record Vendor;
        TotalDefaulterR: Decimal;
        Value2: Decimal;
        AvailableShares: Decimal;
        Value1: Decimal;
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        RoundingDiff: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        LoansR: Record "Loans Register";
        LoanAllocation: Decimal;
        LGurantors: Record "Loans Guarantee Details";
        UserSetup: Record "User Setup";
        MemberLiability: Decimal;
        SFactory: Codeunit "SURESTEP Factory.";
        ObjMember: Record Customer;
        FILESPATH: label 'C:\CheckOff Reports\';


    procedure GetSelectionFilter(): Code[80]
    var
        Cust: Record Customer;
        FirstCust: Code[30];
        LastCust: Code[30];
        SelectionFilter: Code[250];
        CustCount: Integer;
        More: Boolean;
    begin
        /*CurrPage.SETSELECTIONFILTER(Cust);
        CustCount := Cust.COUNT;
        IF CustCount > 0 THEN BEGIN
          Cust.FIND('-');
          WHILE CustCount > 0 DO BEGIN
            CustCount := CustCount - 1;
            Cust.MARKEDONLY(FALSE);
            FirstCust := Cust."No.";
            LastCust := FirstCust;
            More := (CustCount > 0);
            WHILE More DO
              IF Cust.NEXT = 0 THEN
                More := FALSE
              ELSE
                IF NOT Cust.MARK THEN
                  More := FALSE
                ELSE BEGIN
                  LastCust := Cust."No.";
                  CustCount := CustCount - 1;
                  IF CustCount = 0 THEN
                    More := FALSE;
                END;
            IF SelectionFilter <> '' THEN
              SelectionFilter := SelectionFilter + '|';
            IF FirstCust = LastCust THEN
              SelectionFilter := SelectionFilter + FirstCust
            ELSE
              SelectionFilter := SelectionFilter + FirstCust + '..' + LastCust;
            IF CustCount > 0 THEN BEGIN
              Cust.MARKEDONLY(TRUE);
              Cust.NEXT;
            END;
          END;
        END;
        EXIT(SelectionFilter);
        */

    end;


    procedure SetSelection(var Cust: Record Customer)
    begin
        //CurrPage.SETSELECTIONFILTER(Cust);
    end;


    procedure FnGenerateCheckoffSlips("member no": Code[50]; path: Text[100])
    var
        filename: Text[100];
    begin
        filename := FILESPATH + path;
        Message(FILESPATH);
        if Exists(filename) then
            Erase(filename);
        ObjMember.Reset;
        ObjMember.SetRange("No.", "member no");
        if ObjMember.Find('-') then begin
            Report.SaveAsPdf(51516456, filename, ObjMember);
        end;
    end;
}

