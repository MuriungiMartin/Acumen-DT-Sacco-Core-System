#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516735 "Loan Recoverly Card"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTable = "Loans Register";

    layout
    {
        area(content)
        {
            field("Loan  No."; "Loan  No.")
            {
                ApplicationArea = Basic;
            }
            field("Application Date"; "Application Date")
            {
                ApplicationArea = Basic;
            }
            field("Loan Product Type"; "Loan Product Type")
            {
                ApplicationArea = Basic;
            }
            field("Client Code"; "Client Code")
            {
                ApplicationArea = Basic;
            }
            field("Client Name"; "Client Name")
            {
                ApplicationArea = Basic;
            }
            field("Requested Amount"; "Requested Amount")
            {
                ApplicationArea = Basic;
            }
            field("Approved Amount"; "Approved Amount")
            {
                ApplicationArea = Basic;
            }
            field("Loan Disbursement Date"; "Loan Disbursement Date")
            {
                ApplicationArea = Basic;
            }
            field(Installments; Installments)
            {
                ApplicationArea = Basic;
            }
            field("Oustanding Interest"; "Oustanding Interest")
            {
                ApplicationArea = Basic;
            }
            field("Outstanding Balance"; "Outstanding Balance")
            {
                ApplicationArea = Basic;
            }
            field("Days in Arrears"; "Days in Arrears")
            {
                ApplicationArea = Basic;
            }
            field(DefaulterInfo; DefaulterInfo)
            {
                ApplicationArea = Basic;
            }
            field(Defaulter; Defaulter)
            {
                ApplicationArea = Basic;
            }
            field("Loans Category-SASRA"; "Loans Category-SASRA")
            {
                ApplicationArea = Basic;
            }
            field("Loans Category"; "Loans Category")
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("Demand Letters")
            {
                action("Demand Notice Letter")
                {
                    ApplicationArea = Basic;
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        // // // IF CONFIRM('Are you sending this Demand notice to the Member',FALSE)=TRUE THEN BEGIN
                        // // //  ObjDemands.RESET;
                        // // //  ObjDemands.SETRANGE(ObjDemands."Loan In Default","Loan In Default");
                        // // //  ObjDemands.SETFILTER(ObjDemands."Document No",'<>%1',"Document No");
                        // // //  IF ObjDemands.FIND('-')=FALSE THEN BEGIN
                        // // //    "Notice Type":="Notice Type"::"1st Demand Notice";
                        // // //    "Demand Notice Date":=TODAY;
                        // // //    END;
                        // // //
                        // // //  ObjDemands.RESET;
                        // // //  ObjDemands.SETRANGE(ObjDemands."Loan In Default","Loan In Default");
                        // // //  IF ObjDemands.FINDSET THEN BEGIN
                        // // //    IF ObjDemands.COUNT>1 THEN BEGIN
                        // // //    "Notice Type":="Notice Type"::"2nd Demand Notice";
                        // // //    "Demand Notice Date":=TODAY;
                        // // //      END;
                        // // //    END;


                        ObjLoans.Reset;
                        ObjLoans.SetRange(ObjLoans."Loan  No.", "Loan  No.");
                        if ObjLoans.FindSet then begin
                            Report.Run(51516326, true, true, ObjLoans);
                        end;
                        ///END;
                    end;
                }
                action("CRB Demand Letter")
                {
                    ApplicationArea = Basic;
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin
                        // // IF CONFIRM('Are you sending this CRB Demand notice to the Member',FALSE)=TRUE THEN BEGIN
                        // // ObjDemands.RESET;
                        // // ObjDemands.SETRANGE(ObjDemands."Document No","Document No");
                        // // IF ObjDemands.FINDSET THEN BEGIN
                        // //    "Notice Type":="Notice Type"::"CRB Notice";
                        // //    "Demand Notice Date":=TODAY;
                        // //    END;

                        ObjLoans.Reset;
                        ObjLoans.SetRange(ObjLoans."Loan  No.", "Loan  No.");
                        if ObjLoans.FindSet then begin
                            Report.Run(51516926, true, true, ObjLoans);
                        end;
                        ///END;
                    end;
                }
                action("Auctioneer Demand Letter")
                {
                    ApplicationArea = Basic;
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin
                        // // IF CONFIRM('Are you sending this Demand notice to the Auctioneer',FALSE)=TRUE THEN BEGIN
                        // // // // ObjDemands.RESET;
                        // // // // ObjDemands.SETRANGE(ObjDemands."Document No","Document No");
                        // // // // IF ObjDemands.FINDSET THEN BEGIN
                        // // // //    "Notice Type":="Notice Type"::"Auctioneers Notice";
                        // // // //    "Demand Notice Date":=TODAY;
                        // // // //    END;
                        // //
                        // // ObjDemands.RESET;
                        // // ObjDemands.SETRANGE(ObjDemands."Document No",);
                        // // IF ObjDemands.FINDSET THEN BEGIN
                        // //  REPORT.RUN(51516928,TRUE,TRUE,ObjDemands);
                        // //  END;
                        // // END;
                    end;
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                action("Loan Defaulter 1st  Notifly")
                {
                    ApplicationArea = Basic;
                    Image = SendElectronicDocument;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        // // // ObjLoans.RESET;
                        // // // ObjLoans.SETRANGE(ObjLoans."Loan  No.","Loan In Default");
                        // // // IF ObjLoans.FINDSET THEN BEGIN
                        // // //  REPORT.RUN(51516391,TRUE,TRUE,ObjLoans);
                        // // //  END;
                        // // // //END;
                        // // // // //
                        // // // // // IF GenSetup."Send Loan Disbursement SMS"=TRUE THEN BEGIN
                        // // // // //  FnSendDisburesmentSMS(LoanApps."Loan  No.",LoanApps."Client Code");
                        // // // // //  END;
                        //*********************************************************************************************************************
                        if Confirm('Are You Sure to notifly Loan Defaulter ', true) then
                            GenSetup.Get;
                        compinfo.Get;
                        //SMS MESSAGE
                        SMSMessage.Reset;
                        if SMSMessage.Find('+') then begin
                            iEntryNo := SMSMessage."Entry No";
                            iEntryNo := iEntryNo + 1;
                        end
                        else begin
                            iEntryNo := 1;
                        end;


                        SMSMessage.Init;
                        SMSMessage."Entry No" := iEntryNo;
                        //SMSMessage."Batch No":="Batch No.";
                        SMSMessage."Document No" := "Loan  No.";
                        SMSMessage."Account No" := "Client Code";
                        SMSMessage."Date Entered" := Today;
                        SMSMessage."Time Entered" := Time;
                        SMSMessage.Source := 'LOAN DEFAULTERS';
                        SMSMessage."Entered By" := UserId;
                        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                        SMSMessage."SMS Message" := 'Defaulter 1st Notice: Dear ' + "Client Name" + '  kindly note that you have defaulted your loan ' + "Loan  No." + '  by KSHs. '
                        + Format("Amount in Arrears") + 'Arrears. at ACUMEN SACCO LTD. Kindly clear your loan arrears within 14 Days' + compinfo.Name + ' ' + GenSetup."Customer Care No";
                        Cust.Reset;

                        Cust.SetRange(Cust."No.", "Client Code");
                        if Cust.Find('-') then begin
                            SMSMessage."Telephone No" := Cust."Mobile Phone No";
                        end;
                        if Cust."Mobile Phone No" <> '' then
                            SMSMessage.Insert;
                    end;
                }
                action("Loan Defaulter 2nd Notifly")
                {
                    ApplicationArea = Basic;
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        // // // ObjLoans.RESET;
                        // // // ObjLoans.SETRANGE(ObjLoans."Loan  No.","Loan In Default");
                        // // // IF ObjLoans.FINDSET THEN BEGIN
                        // // //  REPORT.RUN(51516392,TRUE,TRUE,ObjLoans);
                        // // //  END;
                        //*************************************************************************************************************************
                        if Confirm('Are You Sure to notifly Loan Defaulter ', true) then
                            GenSetup.Get;
                        compinfo.Get;
                        //SMS MESSAGE
                        SMSMessage.Reset;
                        if SMSMessage.Find('+') then begin
                            iEntryNo := SMSMessage."Entry No";
                            iEntryNo := iEntryNo + 1;
                        end
                        else begin
                            iEntryNo := 1;
                        end;


                        SMSMessage.Init;
                        SMSMessage."Entry No" := iEntryNo;
                        //SMSMessage."Batch No":="Batch No.";
                        SMSMessage."Document No" := "Loan  No.";
                        SMSMessage."Account No" := "Client Name";
                        SMSMessage."Date Entered" := Today;
                        SMSMessage."Time Entered" := Time;
                        SMSMessage.Source := 'LOAN DEFAULTERS';
                        SMSMessage."Entered By" := UserId;
                        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                        SMSMessage."SMS Message" := 'Defaulter 2nd Notice: Dear ' + "Client Name" + '  kindly note that you have defaulted your loan ' + "Loan  No." + '  by KSHs. '
                        + Format("Amount in Arrears") + 'Arrears. at ACUMEN SACCO LTD. Kindly clear your loan arrears within 14 Days' + compinfo.Name + ' ' + GenSetup."Customer Care No";
                        Cust.Reset;

                        Cust.SetRange(Cust."No.", "Client Code");
                        if Cust.Find('-') then begin
                            SMSMessage."Telephone No" := Cust."Mobile Phone No";
                        end;
                        if Cust."Mobile Phone No" <> '' then
                            SMSMessage.Insert;
                        compinfo.Get();
                        if Confirm('Are you sure you want to notify Guarantors about this Loan ?', true) = false then
                            exit;
                        LoanGuar.Reset;
                        LoanGuar.SetRange(LoanGuar."Loan No", "Loan  No.");
                        if LoanGuar.Find('-') then begin
                            repeat
                                Cust.Reset;
                                Cust.SetRange(Cust."No.", LoanGuar."Member No");
                                if Cust.Find('-') then begin
                                    Message(Format(Cust."No."));
                                    SFactory.FnSendSMS('Defaulter 2nd Notice', 'Dear ' + LoanGuar.Name + '.This is to notify you that ' + "Client Name" + 'has defaulted a loan No.'
                                    + "Loan  No." + ' you had guaranteed by KSHs.' + Format(LoanGuar."Amont Guaranteed") + ' at ACUMEN SACCO LTD.',
                                    Cust."FOSA Account No.", Cust."Phone No.");
                                end;
                            until LoanGuar.Next = 0;
                        end;
                        //END;
                    end;
                }
                action("Defaulter Final Notification ")
                {
                    ApplicationArea = Basic;
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        // // // ObjLoans.RESET;
                        // // // ObjLoans.SETRANGE(ObjLoans."Loan  No.","Loan In Default");
                        // // // IF ObjLoans.FINDSET THEN BEGIN
                        // // //  REPORT.RUN(51516393,TRUE,TRUE,ObjLoans);
                        // // //  END;
                        //*************************************************************************************************************************
                        if Confirm('Are You Sure to notifly Loan Defaulter ', true) then
                            GenSetup.Get;
                        compinfo.Get;
                        //SMS MESSAGE
                        SMSMessage.Reset;
                        if SMSMessage.Find('+') then begin
                            iEntryNo := SMSMessage."Entry No";
                            iEntryNo := iEntryNo + 1;
                        end
                        else begin
                            iEntryNo := 1;
                        end;


                        SMSMessage.Init;
                        SMSMessage."Entry No" := iEntryNo;
                        //SMSMessage."Batch No":="Batch No.";
                        SMSMessage."Document No" := "Loan  No.";
                        SMSMessage."Account No" := "Client Name";
                        SMSMessage."Date Entered" := Today;
                        SMSMessage."Time Entered" := Time;
                        SMSMessage.Source := 'LOAN DEFAULTERS';
                        SMSMessage."Entered By" := UserId;
                        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                        SMSMessage."SMS Message" := 'Defaulter Final Notice: Dear ' + "Client Name" + '  kindly note that you have defaulted your loan ' + "Loan  No." + '  by KSHs. '
                        + Format("Amount in Arrears") + 'Arrears. at ACUMEN SACCO LTD. Kindly clear your loan arrears within 14 Days after which we will recover it from your savings' + compinfo.Name + ' ' + GenSetup."Customer Care No";
                        Cust.Reset;

                        Cust.SetRange(Cust."No.", "Client Code");
                        if Cust.Find('-') then begin
                            SMSMessage."Telephone No" := Cust."Mobile Phone No";
                        end;
                        if Cust."Mobile Phone No" <> '' then
                            SMSMessage.Insert;
                        compinfo.Get();
                        if Confirm('Are you sure you want to notify Guarantors about this Loan ?', true) = false then
                            exit;
                        LoanGuar.Reset;
                        LoanGuar.SetRange(LoanGuar."Loan No", "Loan  No.");
                        if LoanGuar.Find('-') then begin
                            repeat
                                Cust.Reset;
                                Cust.SetRange(Cust."No.", LoanGuar."Member No");
                                if Cust.Find('-') then begin
                                    Message(Format(Cust."No."));
                                    SFactory.FnSendSMS('Defaulter Final Notice', 'Dear ' + LoanGuar.Name + '.This is to notify you that ' + "Client Name" + 'has defaulted a loan No.'
                                    + "Loan  No."
                                    + ' you had guaranteed by KSHs.' + Format(LoanGuar."Amont Guaranteed") + ' at ACUMEN SACCO LTD.If loan arrears are not Payed within 14 Days we will recover it from your savings',
                                    Cust."FOSA Account No.", Cust."Phone No.");
                                end;
                            until LoanGuar.Next = 0;
                        end;
                        //END;
                    end;
                }
            }
        }
    }

    var
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval;
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        SurestepFactory: Codeunit "SURESTEP Factory.";
        JTemplate: Code[20];
        JBatch: Code[20];
        GenSetup: Record "Sacco General Set-Up";
        DocNo: Code[20];
        LineNo: Integer;
        TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares";
        AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor;
        BalAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        ApprovalsMgmt: Codeunit WorkflowIntegration;
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        ObjLoans: Record "Loans Register";
        ObjDemands: Record "Default Notices Register";
        VarAuctioneerDetailsVisible: Boolean;
        compinfo: Record "Company Information";
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Cust: Record Customer;
        LoanApps: Record "Loans Register";
        LoanGuar: Record "Loans Guarantee Details";
        SFactory: Codeunit "SURESTEP Factory.";

    local procedure FNenableVisbility()
    begin
        // // // VarAuctioneerDetailsVisible:=FALSE;
        // // //
        // // // IF "Notice Type"="Notice Type"::"Auctioneers Notice" THEN BEGIN
        // // //  VarAuctioneerDetailsVisible:=TRUE;
        // // //  END
    end;

    local procedure FNenableEditing()
    begin
    end;


    procedure FnSendDisburesmentSMS(LoanNo: Code[20]; AccountNo: Code[20])
    begin

        GenSetup.Get;
        compinfo.Get;



        //SMS MESSAGE
        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        //SMSMessage."Batch No":="Batch No.";
        SMSMessage."Document No" := LoanNo;
        SMSMessage."Account No" := "Loan  No.";
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'BATCH';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member,Your Loan has been Approved and posted to your FOSA Account,'
        + compinfo.Name + ' ' + GenSetup."Customer Care No";
        Cust.Reset;
        Cust.SetRange(Cust."No.", "Client Code");
        if Cust.Find('-') then begin
            SMSMessage."Telephone No" := Cust."Mobile Phone No";
        end;
        if Cust."Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;
}

