#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516891 "MC Member List"
{
    ApplicationArea = Basic;
    Caption = 'Member List';
    CardPageID = "MC Individual Page";
    Editable = false;
    PageType = List;
    SourceTable = "Member Register";
    SourceTableView = where("Global Dimension 1 Code"=filter('MICRO'),
                            "Group Account"=filter(false));
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field("Old Account No.";"Old Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code";"Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("ID No.";"ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No.";"Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Posting Group";"Customer Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail";"E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code";"Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Birth";"Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Gender;Gender)
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Account";"FOSA Account")
                {
                    ApplicationArea = Basic;
                }
                field("Group Code";"Group Code")
                {
                    ApplicationArea = Basic;
                }
                field("Current Shares";"Current Shares")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Balance";"Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Shares Retained";"Shares Retained")
                {
                    ApplicationArea = Basic;
                }
                field("Current Savings";"Current Savings")
                {
                    ApplicationArea = Basic;
                }
                field("Recruited By";"Recruited By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000013;"Member Statistics FactBox")
            {
                SubPageLink = "No."=field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(ActionGroup1102755024)
            {
                action("<Page Customer Ledger Entries>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Customer Ledger E&ntries';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer Ledger Entries";
                    RunPageLink = "Customer No."=field("No.");
                    RunPageView = sorting("Customer No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "No."=field("No.");
                }
                action("Bank Account")
                {
                    ApplicationArea = Basic;
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer Bank Account Card";
                    RunPageLink = "Customer No."=field("No.");
                }
                action(Contacts)
                {
                    ApplicationArea = Basic;
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Process;

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
                action("Loans Guarantors")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Guarantors';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin

                        Cust.Reset;
                        Cust.SetRange(Cust."No.","No.");
                        if Cust.Find('-') then
                        Report.Run(39004290,true,false,Cust);
                    end;
                }
                action("Loans Guaranteed")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Guaranteed';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.","No.");
                        if Cust.Find('-') then
                        Report.Run(39004450,true,false,Cust);
                    end;
                }
                action("Member Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Card';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."ID No.","ID No.");
                        if Cust.Find('-') then
                        Report.Run(39004267,true,false,Cust);
                    end;
                }
                separator(Action1102755016)
                {
                }
                action("Account Closure Slip")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Closure Slip';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.","No.");
                        if Cust.Find('-') then
                        Report.Run(39004268,true,false,Cust);
                    end;
                }
                separator(Action1102755014)
                {
                }
            }
            group(ActionGroup1102755013)
            {
                action("Monthly Contributions")
                {
                    ApplicationArea = Basic;
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Sections List";
                    RunPageLink = "No."=field("No.");
                }
                action("Members Statistics")
                {
                    ApplicationArea = Basic;
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Members Statistics";
                    RunPageLink = "No. Series"=field("No.");
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

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.","No.");
                        if Cust.Find('-') then
                        Report.Run(51516223,true,false,Cust);
                    end;
                }
                separator(Action1102755004)
                {
                }
                action("Account Closure Slip")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Closure Slip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.","No.");
                        if Cust.Find('-') then
                        Report.Run(51516474,true,false,Cust);
                    end;
                }
                action("Close Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Close Account';

                    trigger OnAction()
                    begin
                        if "Status - Withdrawal App." <> "status - withdrawal app."::Rejected then
                        Error('Withdrawal application must be approved before posting.');

                        if Confirm('Are you sure you want to recover the loans from the members shares?') = false then
                        exit;

                        GeneralSetup.Get(0);

                        //delete journal line
                        Gnljnline.Reset;
                        Gnljnline.SetRange("Journal Template Name",'GENERAL');
                        Gnljnline.SetRange("Journal Batch Name",'ACC CLOSED');
                        Gnljnline.DeleteAll;
                        //end of deletion

                        TotalRecovered:=0;

                        CalcFields("Outstanding Balance","Accrued Interest","Current Shares","Insurance Fund","FOSA Outstanding Balance",
                                   "FOSA Oustanding Interest","Shares Retained");

                        if Status = Status::Deceased then
                        TotalAvailable:=("Current Shares")*-1
                        else
                        TotalAvailable:=("Insurance Fund"+"Current Shares")*-1;


                        if "Shares Retained" <-GeneralSetup."Retained Shares" then
                        Error('Please transfer 2000/= deposits to the member share capital account.');

                        if "Defaulted Loans Recovered" <> true then begin
                        if "Closing Deposit Balance" = 0 then
                        "Closing Deposit Balance":="Current Shares"*-1;
                        if "Closing Loan Balance" = 0 then
                        "Closing Loan Balance":="Outstanding Balance"+"FOSA Outstanding Balance";
                        if "Closing Insurance Balance" = 0 then
                        "Closing Insurance Balance":="Insurance Fund"*-1;
                        end;
                        "Withdrawal Posted":=true;
                        Modify;

                        Loans.Reset;
                        Loans.SetRange(Loans."Client Code","Micro Group Code");
                        Loans.SetRange(Loans.Source,Loans.Source::BOSA);
                        if Loans.Find('-') then begin
                        repeat
                        Loans.CalcFields(Loans."Outstanding Balance",Loans."Oustanding Interest");

                        if Loans."Outstanding Balance" > 0 then
                        TotalFOSALoan:=TotalFOSALoan+Loans."Outstanding Balance";

                        if Loans."Oustanding Interest" > 0 then
                        TotalFOSALoan:=TotalFOSALoan+Loans."Oustanding Interest";

                        until Loans.Next = 0;
                        end;


                        TotalOustanding:=("Outstanding Balance"+"Accrued Interest"+TotalFOSALoan);



                        //Create MC Account
                        if (TotalOustanding + 1000 + ("Current Shares"+"Insurance Fund")) < 0 then begin
                        if Vend.Get('MC-'+Password) = false then begin
                        TestField(Password);

                        Vend.Init;
                        Vend."No.":='MC-'+Password;
                        Vend.Name:=Name;
                        //Vend."Staff Account":="Member Cell Group Name";
                        Vend."Global Dimension 1 Code":="Global Dimension 1 Code";
                        Vend."Global Dimension 2 Code":="Global Dimension 2 Code";
                        Vend."Vendor Posting Group":='MCREDITOR';
                        Vend.Insert(true);

                        Vend.Reset;
                        if Vend.Get('MC-'+Password) then begin
                        Vend.Validate(Vend.Name);
                        Vend."Global Dimension 1 Code":="Global Dimension 1 Code";
                        Vend."Global Dimension 2 Code":="Global Dimension 2 Code";
                        Vend.Validate(Vend."Global Dimension 1 Code");
                        Vend.Validate(Vend."Global Dimension 2 Code");
                        Vend.Validate(Vend."Vendor Posting Group");
                        Vend.Modify;
                        end;
                        end;
                        end;
                        //Create MC Account


                        //Recover Defaulter Loan first
                        TotalDefaulterR:=0;
                        Value2:=TotalAvailable;
                        AvailableShares:=TotalAvailable;

                        Loans.Reset;
                        Loans.SetRange(Loans."Client Code","No.");
                        Loans.SetRange(Loans.Source,Loans.Source::" ");
                        Loans.SetRange(Loans."Loan Product Type",'DFTL');
                        if Loans.Find('-') then begin
                        repeat
                        Loans.CalcFields(Loans."Outstanding Balance",Loans."Oustanding Interest");

                        Value1:=Loans."Outstanding Balance"+Loans."Oustanding Interest";
                        if (Value1<>0 )and (TotalAvailable>0) then begin
                        //Recover Interest
                        if (Loans."Oustanding Interest" > 0) and (AvailableShares > 0) then begin
                            Interest:=0;
                            Interest:=Loans."Oustanding Interest";

                            if Interest > 0 then begin

                            LineN:=LineN+10000;
                            Gnljnline.Init;
                            Gnljnline."Journal Template Name":='GENERAL';
                            Gnljnline."Journal Batch Name":='ACC CLOSED';
                            Gnljnline."Line No.":=LineN;
                            Gnljnline."Account Type":=Gnljnline."bal. account type"::Customer;
                            Gnljnline."Account No.":="No.";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No.":='LR-'+"No.";
                            Gnljnline."Posting Date":=Today;
                            Gnljnline.Description:='Interest Recovery from deposits';
                            if AvailableShares < Interest then
                            Gnljnline.Amount:=-1*AvailableShares
                            else
                            Gnljnline.Amount:=-1*Interest;

                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Insurance Contribution";
                            Gnljnline."Loan No":=Loans."Loan  No.";
                            if Gnljnline.Amount<>0 then
                            Gnljnline.Insert;

                            AvailableShares:=AvailableShares-(Gnljnline.Amount*-1);
                            TotalDefaulterR:=TotalDefaulterR+(Gnljnline.Amount*-1);
                            TotalRecovered:=TotalRecovered+(Gnljnline.Amount*-1);
                            end;
                        end;




                        //Recover Repayment
                        if (Loans."Outstanding Balance" > 0) and (AvailableShares > 0) then begin
                            LRepayment:=0;
                            LRepayment:=Loans."Outstanding Balance";

                            if LRepayment > 0 then begin


                            LineN:=LineN+10000;

                            Gnljnline.Init;
                            Gnljnline."Journal Template Name":='GENERAL';
                            Gnljnline."Journal Batch Name":='ACC CLOSED';
                            Gnljnline."Line No.":=LineN;
                            Gnljnline."Account Type":=Gnljnline."bal. account type"::Customer;
                            Gnljnline."Account No.":="No.";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No.":='LR-'+"No.";
                            Gnljnline."Posting Date":=Today;
                            Gnljnline.Description:='Loan Recovery from deposits';
                            if AvailableShares < LRepayment then
                            Gnljnline.Amount:=AvailableShares*-1
                            else
                            Gnljnline.Amount:=LRepayment*-1;

                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Interest Paid";
                            Gnljnline."Loan No":=Loans."Loan  No.";
                            if Gnljnline.Amount<>0 then
                            Gnljnline.Insert;

                            AvailableShares:=AvailableShares-(Gnljnline.Amount*-1);
                            TotalDefaulterR:=TotalDefaulterR+(Gnljnline.Amount*-1);
                            TotalRecovered:=TotalRecovered+(Gnljnline.Amount*-1);

                            end;

                            Loans."Recovered Balance":=Loans."Outstanding Balance";
                            Loans.Modify;

                        end;
                        end;
                        until Loans.Next = 0;
                        end;

                        //Recover Defaulter Loan first



                        //Recover Interest without loan First
                        Loans.Reset;
                        Loans.SetRange(Loans."BOSA No","No.");
                        if Loans.Find('-') then begin
                        repeat
                        Loans.CalcFields(Loans."Outstanding Balance",Loans."Oustanding Interest");
                        //Recover Interest
                        if (Loans."Outstanding Balance" <= 0) and (Loans."Oustanding Interest" > 0) and (AvailableShares > 0) then begin
                            Interest:=0;
                            Interest:=Loans."Oustanding Interest";

                            if Interest > 0 then begin

                            LineN:=LineN+10000;
                            Gnljnline.Init;
                            Gnljnline."Journal Template Name":='GENERAL';
                            Gnljnline."Journal Batch Name":='ACC CLOSED';
                            Gnljnline."Line No.":=LineN;
                            Gnljnline."Account Type":=Gnljnline."bal. account type"::Customer;
                            Gnljnline."Account No.":="No.";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No.":='LR-'+"No.";
                            Gnljnline."Posting Date":=Today;
                            Gnljnline.Description:='Interest Recovery from deposits';
                            if AvailableShares < Interest then
                            Gnljnline.Amount:=-1*AvailableShares
                            else
                            Gnljnline.Amount:=-1*Interest;

                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Insurance Contribution";
                            Gnljnline."Loan No":=Loans."Loan  No.";
                            if Gnljnline.Amount<>0 then
                            Gnljnline.Insert;

                            AvailableShares:=AvailableShares-(Gnljnline.Amount*-1);
                            TotalDefaulterR:=TotalDefaulterR+(Gnljnline.Amount*-1);
                            TotalRecovered:=TotalRecovered+(Gnljnline.Amount*-1);
                            end;
                        end;

                        until Loans.Next = 0;
                        end;

                        //Recover Interest without loan First



                        TotalOustanding:=TotalOustanding-TotalRecovered;


                        Loans.Reset;
                        Loans.SetRange(Loans."Client Code","No.");
                        Loans.SetRange(Loans.Source,Loans.Source::" ");
                        if Loans.Find('-') then begin
                        repeat
                        if Loans."Loan Product Type" <> 'DFTL' then begin

                        Loans.CalcFields(Loans."Outstanding Balance",Loans."Oustanding Interest");

                        if (Loans."Outstanding Balance" > 0) and ((TotalAvailable-TotalDefaulterR) > 0) then begin

                        AvailableShares:=ROUND(((Loans."Outstanding Balance"+Loans."Oustanding Interest")/TotalOustanding)
                                         *(TotalAvailable-TotalDefaulterR),0.01);

                        //Recover Interest
                        if Loans."Oustanding Interest" > 0 then begin
                            Interest:=0;
                            Interest:=Loans."Oustanding Interest";

                            if Interest > 0 then begin

                            LineN:=LineN+10000;
                            Gnljnline.Init;
                            Gnljnline."Journal Template Name":='GENERAL';
                            Gnljnline."Journal Batch Name":='ACC CLOSED';
                            Gnljnline."Line No.":=LineN;
                            Gnljnline."Account Type":=Gnljnline."bal. account type"::Customer;
                            Gnljnline."Account No.":="No.";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No.":='LR-'+"No.";
                            Gnljnline."Posting Date":=Today;
                            Gnljnline.Description:='Interest Recovery from deposits';
                            if AvailableShares < Interest then
                            Gnljnline.Amount:=-1*AvailableShares
                            else
                            Gnljnline.Amount:=-1*Interest;

                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Insurance Contribution";
                            Gnljnline."Loan No":=Loans."Loan  No.";
                            if Gnljnline.Amount<>0 then
                            Gnljnline.Insert;

                            AvailableShares:=AvailableShares-(Gnljnline.Amount*-1);
                            TotalRecovered:=TotalRecovered+(Gnljnline.Amount*-1);
                            end;
                        end;




                        //Recover Repayment
                        if Loans."Outstanding Balance" > 0 then begin
                            LRepayment:=0;
                            LRepayment:=Loans."Outstanding Balance";

                            if LRepayment > 0 then begin


                            LineN:=LineN+10000;

                            Gnljnline.Init;
                            Gnljnline."Journal Template Name":='GENERAL';
                            Gnljnline."Journal Batch Name":='ACC CLOSED';
                            Gnljnline."Line No.":=LineN;
                            Gnljnline."Account Type":=Gnljnline."bal. account type"::Customer;
                            Gnljnline."Account No.":="No.";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No.":='LR-'+"No.";
                            Gnljnline."Posting Date":=Today;
                            Gnljnline.Description:='Loan Recovery from deposits';
                            if AvailableShares < LRepayment then
                            Gnljnline.Amount:=AvailableShares*-1
                            else
                            Gnljnline.Amount:=LRepayment*-1;

                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Interest Paid";
                            Gnljnline."Loan No":=Loans."Loan  No.";
                            if Gnljnline.Amount<>0 then
                            Gnljnline.Insert;

                            AvailableShares:=AvailableShares-(Gnljnline.Amount*-1);
                            TotalRecovered:=TotalRecovered+(Gnljnline.Amount*-1);

                            end;

                            Loans."Recovered Balance":=Loans."Outstanding Balance";
                            Loans.Modify;

                        end;
                        end;
                        end;
                        until Loans.Next = 0;
                        end;

                        //Recover FOSA Loans
                        Loans.Reset;
                        Loans.SetRange(Loans."Client Code","Micro Group Code");
                        Loans.SetRange(Loans.Source,Loans.Source::BOSA);
                        if Loans.Find('-') then begin
                        repeat
                        Loans.CalcFields(Loans."Outstanding Balance",Loans."Oustanding Interest");

                        if (Loans."Outstanding Balance" > 0) and ((TotalAvailable-TotalDefaulterR) >0) then begin
                        AvailableShares:=ROUND((Loans."Outstanding Balance"+Loans."Oustanding Interest")/(TotalOustanding)
                                         *(TotalAvailable-TotalDefaulterR),0.01);


                        //Recover Interest
                        if Loans."Oustanding Interest">0 then begin
                            Interest:=0;
                            Interest:=Loans."Oustanding Interest";

                            if Interest > 0 then begin

                            LineN:=LineN+10000;

                            Gnljnline.Init;
                            Gnljnline."Journal Template Name":='GENERAL';
                            Gnljnline."Journal Batch Name":='ACC CLOSED';
                            Gnljnline."Line No.":=LineN;
                            Gnljnline."Account Type":=Gnljnline."bal. account type"::Customer;
                            Gnljnline."Account No.":=Loans."Client Code";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No.":='LR-'+"No.";
                            Gnljnline."Posting Date":=Today;
                            Gnljnline.Description:='Interest Recovery from deposits';
                            if AvailableShares < Interest then
                            Gnljnline.Amount:=-1*AvailableShares
                            else
                            Gnljnline.Amount:=-1*Interest;

                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Insurance Contribution";
                            Gnljnline."Loan No":=Loans."Loan  No.";
                            if Gnljnline.Amount<>0 then
                            Gnljnline.Insert;

                            AvailableShares:=AvailableShares-(Gnljnline.Amount*-1);
                            TotalRecovered:=TotalRecovered+(Gnljnline.Amount*-1);
                            end;
                        end;




                        //Recover Repayment
                        if Loans."Outstanding Balance" > 0 then begin
                            LRepayment:=0;
                            LRepayment:=Loans."Outstanding Balance";

                            if LRepayment > 0 then begin


                            LineN:=LineN+10000;

                            Gnljnline.Init;
                            Gnljnline."Journal Template Name":='GENERAL';
                            Gnljnline."Journal Batch Name":='ACC CLOSED';
                            Gnljnline."Line No.":=LineN;
                            Gnljnline."Account Type":=Gnljnline."bal. account type"::Customer;
                            Gnljnline."Account No.":=Loans."Client Code";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No.":='LR-'+"No.";
                            Gnljnline."Posting Date":=Today;
                            Gnljnline.Description:='Loan Recovery from deposits';
                            if AvailableShares < LRepayment then
                            Gnljnline.Amount:=AvailableShares*-1
                            else
                            Gnljnline.Amount:=LRepayment*-1;

                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Interest Paid";
                            Gnljnline."Loan No":=Loans."Loan  No.";
                            if Gnljnline.Amount<>0 then
                            Gnljnline.Insert;

                            AvailableShares:=AvailableShares-(Gnljnline.Amount*-1);
                            TotalRecovered:=TotalRecovered+(Gnljnline.Amount*-1);

                            end;

                            Loans."Recovered Balance":=Loans."Outstanding Balance";
                            Loans.Modify;

                        end;
                        end;

                        until Loans.Next = 0;
                        end;


                        //Reduce Shares
                            LineN:=LineN+10000;

                            Gnljnline.Init;
                            Gnljnline."Journal Template Name":='GENERAL';
                            Gnljnline."Journal Batch Name":='ACC CLOSED';
                            Gnljnline."Line No.":=LineN;
                            Gnljnline."Account Type":=Gnljnline."bal. account type"::Customer;
                            Gnljnline."Account No.":="No.";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No.":='LR-'+"No.";
                            Gnljnline."Posting Date":=Today;
                            Gnljnline.Description:='Deposit Refundable';
                            if Status = Status::Deceased then
                            Gnljnline.Amount:=TotalRecovered+GeneralSetup."Withdrawal Fee"
                            else
                            Gnljnline.Amount:=TotalRecovered+"Insurance Fund"+GeneralSetup."Withdrawal Fee";
                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Transaction Type":=Gnljnline."transaction type"::Loan;
                            if Gnljnline.Amount<>0 then
                            Gnljnline.Insert;


                        //Reduce Insurance Contribution
                        if Status <> Status::Deceased then begin
                            LineN:=LineN+10000;

                            Gnljnline.Init;
                            Gnljnline."Journal Template Name":='GENERAL';
                            Gnljnline."Journal Batch Name":='ACC CLOSED';
                            Gnljnline."Line No.":=LineN;
                            Gnljnline."Account Type":=Gnljnline."bal. account type"::Customer;
                            Gnljnline."Account No.":="No.";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No.":='LR-'+"No.";
                            Gnljnline."Posting Date":=Today;
                            Gnljnline.Description:='Insurance Refundable';
                            Gnljnline.Amount:="Insurance Fund"* -1;
                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Benevolent Fund";
                            if Gnljnline.Amount<>0 then
                            Gnljnline.Insert;
                        end;



                        //Insurance Retension
                        if Status = Status::Deceased then begin
                            GeneralSetup.TestField(GeneralSetup."Insurance Retension Account");

                            LineN:=LineN+10000;

                            Gnljnline.Init;
                            Gnljnline."Journal Template Name":='GENERAL';
                            Gnljnline."Journal Batch Name":='ACC CLOSED';
                            Gnljnline."Line No.":=LineN;
                            Gnljnline."Account Type":=Gnljnline."bal. account type"::Customer;
                            Gnljnline."Account No.":="No.";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No.":='LR-'+"No.";
                            Gnljnline."Posting Date":=Today;
                            Gnljnline.Description:='Insurance Retension';
                            Gnljnline.Amount:="Insurance Fund" * -1;
                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Benevolent Fund";
                            Gnljnline."Bal. Account Type":=Gnljnline."bal. account type"::"G/L Account";
                            Gnljnline."Bal. Account No.":=GeneralSetup."Insurance Retension Account";
                            Gnljnline.Validate(Gnljnline."Bal. Account No.");
                            if Gnljnline.Amount<>0 then
                            Gnljnline.Insert;
                        end;

                        //Shares Capital Retension
                            GeneralSetup.TestField(GeneralSetup."Shares Retension Account");

                            LineN:=LineN+10000;

                            Gnljnline.Init;
                            Gnljnline."Journal Template Name":='GENERAL';
                            Gnljnline."Journal Batch Name":='ACC CLOSED';
                            Gnljnline."Line No.":=LineN;
                            Gnljnline."Account Type":=Gnljnline."bal. account type"::Customer;
                            Gnljnline."Account No.":="No.";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No.":='LR-'+"No.";
                            Gnljnline."Posting Date":=Today;
                            Gnljnline.Description:='Shares Capital Retension';
                            Gnljnline.Amount:=GeneralSetup."Retained Shares";
                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Recovery Account";
                            Gnljnline."Bal. Account Type":=Gnljnline."bal. account type"::"G/L Account";
                            Gnljnline."Bal. Account No.":=GeneralSetup."Shares Retension Account";
                            Gnljnline.Validate(Gnljnline."Bal. Account No.");
                            if Gnljnline.Amount<>0 then
                            Gnljnline.Insert;


                        //Withdrawal Fee
                        if GeneralSetup."Withdrawal Fee" > 0 then begin

                            LineN:=LineN+10000;

                            Gnljnline.Init;
                            Gnljnline."Journal Template Name":='GENERAL';
                            Gnljnline."Journal Batch Name":='ACC CLOSED';
                            Gnljnline."Line No.":=LineN;
                            Gnljnline."Account Type":=Gnljnline."bal. account type"::Customer;
                            Gnljnline."Account No.":="No.";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No.":='LR-'+"No.";
                            Gnljnline."Posting Date":=Today;
                            Gnljnline.Description:='Withdrawal Fee';
                            Gnljnline.Amount:=-GeneralSetup."Withdrawal Fee";
                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Loan Repayment";
                            Gnljnline.Validate(Gnljnline."Bal. Account No.");
                            if Gnljnline.Amount<>0 then
                            Gnljnline.Insert;

                        end;

                        //Transfer to MC Account
                        if ((TotalRecovered+1000) + ("Current Shares"+"Insurance Fund")) < 0 then begin
                            LineN:=LineN+10000;

                            Gnljnline.Init;
                            Gnljnline."Journal Template Name":='GENERAL';
                            Gnljnline."Journal Batch Name":='ACC CLOSED';
                            Gnljnline."Line No.":=LineN;
                            Gnljnline."Account Type":=Gnljnline."bal. account type"::Customer;
                            Gnljnline."Account No.":="No.";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No.":='LR-'+"No.";
                            Gnljnline."Posting Date":=Today;
                            Gnljnline.Description:='Refundable Deposits to MC';
                            if Status = Status::Deceased then
                            Gnljnline.Amount:=((TotalRecovered+GeneralSetup."Withdrawal Fee") + ("Current Shares"))*-1
                            else
                            Gnljnline.Amount:=((TotalRecovered+"Insurance Fund"+GeneralSetup."Withdrawal Fee") + ("Current Shares"))*-1;
                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Transaction Type":=Gnljnline."transaction type"::Loan;
                            if Gnljnline.Amount<>0 then
                            Gnljnline.Insert;

                            LineN:=LineN+10000;

                            Gnljnline.Init;
                            Gnljnline."Journal Template Name":='GENERAL';
                            Gnljnline."Journal Batch Name":='ACC CLOSED';
                            Gnljnline."Line No.":=LineN;
                            Gnljnline."Account Type":=Gnljnline."bal. account type"::Vendor;
                            Gnljnline."Account No.":='MC-'+Password;
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No.":='LR-'+"No.";
                            Gnljnline."Posting Date":=Today;
                            Gnljnline.Description:='Refundable Deposits to MC';
                            if Status = Status::Deceased then
                            Gnljnline.Amount:=((TotalRecovered+GeneralSetup."Withdrawal Fee") + ("Current Shares"))
                            else
                            Gnljnline.Amount:=((TotalRecovered+"Insurance Fund"+GeneralSetup."Withdrawal Fee") + ("Current Shares"));
                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Transaction Type":=Gnljnline."transaction type"::Loan;
                            if Gnljnline.Amount<>0 then
                            Gnljnline.Insert;

                            //Funeral Expenses
                            if Status = Status::Deceased then begin
                            GeneralSetup.TestField("Funeral Expenses Account");

                            LineN:=LineN+10000;

                            Gnljnline.Init;
                            Gnljnline."Journal Template Name":='GENERAL';
                            Gnljnline."Journal Batch Name":='ACC CLOSED';
                            Gnljnline."Line No.":=LineN;
                            Gnljnline."Account Type":=Gnljnline."bal. account type"::Vendor;
                            Gnljnline."Account No.":='MC-'+Password;
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No.":='LR-'+"No.";
                            Gnljnline."External Document No.":=Password;
                            Gnljnline."Posting Date":=Today;
                            Gnljnline.Description:='Funeral Expenses';
                            //Gnljnline.Amount:=-GeneralSetup."Funeral Expenses Amount";
                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Bal. Account Type":=Gnljnline."bal. account type"::"G/L Account";
                            Gnljnline."Bal. Account No.":=GeneralSetup."Funeral Expenses Account";
                            if Gnljnline.Amount<>0 then
                            Gnljnline.Insert;

                            end;

                        end;

                        //Post New
                        Gnljnline.Reset;
                        Gnljnline.SetRange("Journal Template Name",'GENERAL');
                        Gnljnline.SetRange("Journal Batch Name",'ACC CLOSED');
                        if Gnljnline.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch",Gnljnline);
                        end;

                        Message('Closure posted successfully.');
                    end;
                }
                action("Recover Loans from Guarantors")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recover Loans from Gurantors';

                    trigger OnAction()
                    begin
                        if ("Current Shares" * -1) > 0 then
                        Error('Please recover the loans from the members shares before recovering from gurantors.');

                        if Confirm('Are you absolutely sure you want to recover the loans from the guarantors as loans?') = false then
                        exit;

                        RoundingDiff:=0;

                        //delete journal line
                        Gnljnline.Reset;
                        Gnljnline.SetRange("Journal Template Name",'GENERAL');
                        Gnljnline.SetRange("Journal Batch Name",'LOANS');
                        Gnljnline.DeleteAll;
                        //end of deletion

                        TotalRecovered:=0;

                        DActivity:="Global Dimension 1 Code";
                        DBranch:="Global Dimension 2 Code";

                        CalcFields("Outstanding Balance","FOSA Outstanding Balance","Accrued Interest","Insurance Fund","Current Shares");


                        if "Closing Deposit Balance" = 0 then
                        "Closing Deposit Balance":="Current Shares"*-1;
                        if "Closing Loan Balance" = 0 then
                        "Closing Loan Balance":="Outstanding Balance"+"FOSA Outstanding Balance";
                        if "Closing Insurance Balance" = 0 then
                        "Closing Insurance Balance":="Insurance Fund"*-1;
                        "Withdrawal Posted":=true;
                        Modify;


                        CalcFields("Outstanding Balance","Accrued Interest","Current Shares");



                        LoansR.Reset;
                        LoansR.SetRange(LoansR."Client Code","No.");
                        LoansR.SetRange(LoansR.Source,LoansR.Source::" ");
                        if LoansR.Find('-') then begin
                        repeat

                        LoansR.CalcFields(LoansR."Outstanding Balance",LoansR."Oustanding Interest",LoansR."No. Of Guarantors");

                        //No Shares recovery
                        if LoansR."Recovered Balance" = 0 then begin
                        LoansR."Recovered Balance":=LoansR."Outstanding Balance";
                        end;
                        LoansR."Recovered From Guarantor":=true;
                        LoansR."Guarantor Amount":=LoansR."Outstanding Balance";
                        LoansR.Modify;

                        if ((LoansR."Outstanding Balance" + LoansR."Oustanding Interest") > 0) and (LoansR."No. Of Guarantors" > 0) then begin

                        LoanAllocation:=ROUND((LoansR."Outstanding Balance")/LoansR."No. Of Guarantors",0.01)+
                                        ROUND((LoansR."Oustanding Interest")/LoansR."No. Of Guarantors",0.01);


                        LGurantors.Reset;
                        LGurantors.SetRange(LGurantors."Loan No",LoansR."Loan  No.");
                        LGurantors.SetRange(LGurantors.Substituted,false);
                        if LGurantors.Find('-') then begin
                        repeat


                        Loans.Reset;
                        Loans.SetRange(Loans."Client Code",LGurantors."Member No");
                        Loans.SetRange(Loans."Loan Product Type",'DFTL');
                        Loans.SetRange(Loans.Posted,false);
                        if Loans.Find('-') then
                        Loans.DeleteAll;


                        Loans.Init;
                        Loans."Loan  No.":='';
                        Loans.Source:=Loans.Source::" ";
                        Loans."Client Code":=LGurantors."Member No";
                        Loans."Loan Product Type":='DFTL';
                        Loans.Validate(Loans."Client Code");
                        Loans."Application Date":=Today;
                        Loans.Validate(Loans."Loan Product Type");
                        if (LoansR."Approved Amount" > 0) and (LoansR.Installments > 0) then
                        Loans.Installments:=ROUND((LoansR."Outstanding Balance")
                                                  /(LoansR."Approved Amount"/LoansR.Installments),1,'>');
                        //IF LoansR.Repayment > 0 THEN
                        //Loans.Installments:=ROUND((LoansR."Outstanding Balance")
                        //                          /(LoansR.Repayment-((LoansR."Outstanding Balance"*LoansR.Interest)/1200)),1,'>');
                        Loans."Requested Amount":=LoanAllocation;
                        Loans."Approved Amount":=LoanAllocation;
                        Loans.Validate(Loans."Approved Amount");
                        Loans."Loan Status":=Loans."loan status"::Approved;
                        Loans."Issued Date":=Today;
                        Loans."Loan Disbursement Date":=Today;
                        Loans."Repayment Start Date":=Today;
                        Loans."Batch No.":="Batch No.";
                        Loans."BOSA No":=LGurantors."Member No";
                        Loans."Recovered Loan":=LoansR."Loan  No.";
                        Loans.Insert(true);

                        Loans.Reset;
                        Loans.SetRange(Loans."Client Code",LGurantors."Member No");
                        Loans.SetRange(Loans."Loan Product Type",'DFTL');
                        Loans.SetRange(Loans.Posted,false);
                        if Loans.Find('-') then begin

                        LineN:=LineN+10000;

                        Gnljnline.Init;
                        Gnljnline."Journal Template Name":='GENERAL';
                        Gnljnline."Journal Batch Name":='LOANS';
                        Gnljnline."Line No.":=LineN;
                        Gnljnline."Document No.":='GL-'+LoansR."Client Code";
                        Gnljnline."Posting Date":=Today;
                        Gnljnline."External Document No.":=LoansR."Loan  No.";
                        Gnljnline."Account Type":=Gnljnline."bal. account type"::Customer;
                        Gnljnline."Account No.":=LGurantors."Member No";
                        Gnljnline.Validate(Gnljnline."Account No.");
                        Gnljnline.Description:='Principle Amount';
                        Gnljnline.Amount:=LoanAllocation;
                        Gnljnline.Validate(Gnljnline.Amount);
                        Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Share Capital";
                        Gnljnline."Loan No":=Loans."Loan  No.";
                        Gnljnline."Shortcut Dimension 1 Code":=DActivity;
                        Gnljnline."Shortcut Dimension 2 Code":=DBranch;
                        Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                        Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                        if Gnljnline.Amount<>0 then
                        Gnljnline.Insert;


                        Loans.Posted:=true;
                        Loans.Modify;


                        //Off Set BOSA Loans

                        //Principle
                        LineN:=LineN+10000;

                        Gnljnline.Init;
                        Gnljnline."Journal Template Name":='GENERAL';
                        Gnljnline."Journal Batch Name":='LOANS';
                        Gnljnline."Line No.":=LineN;
                        Gnljnline."Document No.":='GL-'+LoansR."Client Code";
                        Gnljnline."Posting Date":=Today;
                        Gnljnline."External Document No.":=Loans."Loan  No.";
                        Gnljnline."Account Type":=Gnljnline."bal. account type"::Customer;
                        Gnljnline."Account No.":=LoansR."Client Code";
                        Gnljnline.Validate(Gnljnline."Account No.");
                        Gnljnline.Description:='Cleared by Guarantor loan: ' + Loans."Loan  No.";
                        Gnljnline.Amount:=-ROUND(LoansR."Outstanding Balance"/LoansR."No. Of Guarantors",0.01);
                        Gnljnline.Validate(Gnljnline.Amount);
                        Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Interest Paid";
                        Gnljnline."Loan No":=LoansR."Loan  No.";
                        Gnljnline."Shortcut Dimension 1 Code":=DActivity;
                        Gnljnline."Shortcut Dimension 2 Code":=DBranch;
                        Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                        Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                        if Gnljnline.Amount<>0 then
                        Gnljnline.Insert;



                        //Interest
                        LineN:=LineN+10000;

                        Gnljnline.Init;
                        Gnljnline."Journal Template Name":='GENERAL';
                        Gnljnline."Journal Batch Name":='LOANS';
                        Gnljnline."Line No.":=LineN;
                        Gnljnline."Document No.":='GL-'+LoansR."Client Code";
                        Gnljnline."Posting Date":=Today;
                        Gnljnline."External Document No.":=Loans."Loan  No.";
                        Gnljnline."Account Type":=Gnljnline."bal. account type"::Customer;
                        Gnljnline."Account No.":=LoansR."Client Code";
                        Gnljnline.Validate(Gnljnline."Account No.");
                        Gnljnline.Description:='Cleared by Guarantor loan: ' + Loans."Loan  No.";
                        Gnljnline.Amount:=-ROUND(LoansR."Oustanding Interest"/LoansR."No. Of Guarantors",0.01);
                        Gnljnline.Validate(Gnljnline.Amount);
                        Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Insurance Contribution";
                        Gnljnline."Loan No":=LoansR."Loan  No.";
                        Gnljnline."Shortcut Dimension 1 Code":=DActivity;
                        Gnljnline."Shortcut Dimension 2 Code":=DBranch;
                        Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                        Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                        if Gnljnline.Amount<>0 then
                        Gnljnline.Insert;



                        LoansR.Advice:=true;
                        LoansR.Modify;

                        end;

                        until LGurantors.Next = 0;
                        end;
                        end;

                        until LoansR.Next = 0;
                        end;


                        "Defaulted Loans Recovered":=true;
                        Modify;


                        //Post New
                        Gnljnline.Reset;
                        Gnljnline.SetRange("Journal Template Name",'GENERAL');
                        Gnljnline.SetRange("Journal Batch Name",'LOANS');
                        if Gnljnline.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch",Gnljnline);
                        end;



                        Message('Loan recovery from guarantors posted successfully.');
                    end;
                }
                action("Account Signatories ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories';
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Account Signatory list";
                    RunPageLink = "Account No"=field("No.");
                }
            }
        }
    }

    var
        Cust: Record "Member Register";
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


    procedure GetSelectionFilter(): Code[80]
    var
        Cust: Record "Member Register";
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


    procedure SetSelection(var Cust: Record "Member Register")
    begin
        //CurrPage.SETSELECTIONFILTER(Cust);
    end;
}

