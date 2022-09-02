#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516981 "Loan Demand Notices Card"
{
    PageType = Card;
    SourceTable = "Default Notices Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan In Default"; "Loan In Default")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product"; "Loan Product")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Instalments"; "Loan Instalments")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Disbursement Date"; "Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Completion Date"; "Expected Completion Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount In Arrears"; "Amount In Arrears")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Outstanding Balance"; "Loan Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Notice Type"; "Notice Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        FNenableVisbility();
                    end;
                }
                group("Auctioneer Details")
                {
                    Visible = VarAuctioneerDetailsVisible;
                    field("Auctioneer No"; "Auctioneer No")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Auctioneer  Name"; "Auctioneer  Name")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Auctioneer Address"; "Auctioneer Address")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Auctioneer Mobile No"; "Auctioneer Mobile No")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                }
                field("Demand Notice Date"; "Demand Notice Date")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Email Sent"; "Email Sent")
                {
                    ApplicationArea = Basic;
                }
                field("SMS Sent"; "SMS Sent")
                {
                    ApplicationArea = Basic;
                }
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
                        if Confirm('Are you sending this Demand notice to the Member', false) = true then begin
                            ObjDemands.Reset;
                            ObjDemands.SetRange(ObjDemands."Loan In Default", "Loan In Default");
                            ObjDemands.SetFilter(ObjDemands."Document No", '<>%1', "Document No");
                            if ObjDemands.Find('-') = false then begin
                                "Notice Type" := "notice type"::"1st Demand Notice";
                                "Demand Notice Date" := Today;
                            end;

                            ObjDemands.Reset;
                            ObjDemands.SetRange(ObjDemands."Loan In Default", "Loan In Default");
                            if ObjDemands.FindSet then begin
                                if ObjDemands.Count > 1 then begin
                                    "Notice Type" := "notice type"::"2nd Demand Notice";
                                    "Demand Notice Date" := Today;
                                end;
                            end;


                            ObjLoans.Reset;
                            ObjLoans.SetRange(ObjLoans."Loan  No.", "Loan In Default");
                            if ObjLoans.FindSet then begin
                                Report.Run(51516326, true, true, ObjLoans);
                            end;
                        end;
                    end;
                }
                action("CRB Demand Letter")
                {
                    ApplicationArea = Basic;
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        if Confirm('Are you sending this CRB Demand notice to the Member', false) = true then begin
                            ObjDemands.Reset;
                            ObjDemands.SetRange(ObjDemands."Document No", "Document No");
                            if ObjDemands.FindSet then begin
                                "Notice Type" := "notice type"::"CRB Notice";
                                "Demand Notice Date" := Today;
                            end;

                            ObjLoans.Reset;
                            ObjLoans.SetRange(ObjLoans."Loan  No.", "Loan In Default");
                            if ObjLoans.FindSet then begin
                                Report.Run(51516326, true, true, ObjLoans);
                            end;
                        end;
                    end;
                }
                action("Auctioneer Demand Letter")
                {
                    ApplicationArea = Basic;
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        if Confirm('Are you sending this Demand notice to the Auctioneer', false) = true then begin
                            ObjDemands.Reset;
                            ObjDemands.SetRange(ObjDemands."Document No", "Document No");
                            if ObjDemands.FindSet then begin
                                "Notice Type" := "notice type"::"Auctioneers Notice";
                                "Demand Notice Date" := Today;
                            end;

                            ObjDemands.Reset;
                            ObjDemands.SetRange(ObjDemands."Document No", "Document No");
                            if ObjDemands.FindSet then begin
                                Report.Run(51516928, true, true, ObjDemands);
                            end;
                        end;
                    end;
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        /*
                        DocumentType:=DocumentType::PackageLodging;
                        ApprovalEntries.Setfilters(DATABASE::"Safe Custody Package Register",DocumentType,"Package ID");
                        ApprovalEntries.RUN;
                        */

                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /*//Check Item and Agent Attachment
                        ObjAgents.RESET;
                        ObjAgents.SETRANGE(ObjAgents."Package ID","Package ID");
                        ObjAgents.SETFILTER(ObjAgents."Agent Name",'<>%1','');
                        IF ObjAgents.FINDSET=FALSE THEN BEGIN
                          ERROR('You have to specify atleast 1 package agent');
                          END;
                        
                        ObjItems.RESET;
                        ObjItems.SETRANGE(ObjItems."Package ID","Package ID");
                        ObjItems.SETFILTER(ObjItems."Item Description",'<>%1','');
                        IF ObjItems.FINDSET=FALSE THEN BEGIN
                          ERROR('You have to specify atleast 1 package item');
                          END;
                        
                        IF ApprovalsMgmt.CheckPackageLodgeApprovalsWorkflowEnabled(Rec) THEN
                          ApprovalsMgmt.OnSendPackageLodgeForApproval(Rec)
                        
                          */

                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /*IF ApprovalsMgmt.CheckPackageLodgeApprovalsWorkflowEnabled(Rec) THEN
                          ApprovalsMgmt.OnCancelPackageLodgeApprovalRequest(Rec);*/


                    end;
                }
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
                        SMSMessage."Document No" := "Loan In Default";
                        SMSMessage."Account No" := "Member No";
                        SMSMessage."Date Entered" := Today;
                        SMSMessage."Time Entered" := Time;
                        SMSMessage.Source := 'LOAN DEFAULTERS';
                        SMSMessage."Entered By" := UserId;
                        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                        SMSMessage."SMS Message" := 'Defaulter 1st Notice: Dear ' + "Member Name" + '  kindly note that you have defaulted your loan ' + "Loan In Default" + '  by KSHs. '
                        + Format("Amount In Arrears") + 'Arrears. at ACUMEN SACCO LTD. Kindly clear your loan arrears within 14 Days' + compinfo.Name + ' ' + GenSetup."Customer Care No";
                        Cust.Reset;

                        Cust.SetRange(Cust."No.", "Member No");
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
                        SMSMessage."Document No" := "Loan In Default";
                        SMSMessage."Account No" := "Member No";
                        SMSMessage."Date Entered" := Today;
                        SMSMessage."Time Entered" := Time;
                        SMSMessage.Source := 'LOAN DEFAULTERS';
                        SMSMessage."Entered By" := UserId;
                        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                        SMSMessage."SMS Message" := 'Defaulter 2nd Notice: Dear ' + "Member Name" + '  kindly note that you have defaulted your loan ' + "Loan In Default" + '  by KSHs. '
                        + Format("Amount In Arrears") + 'Arrears. at ACUMEN SACCO LTD. Kindly clear your loan arrears within 14 Days' + compinfo.Name + ' ' + GenSetup."Customer Care No";
                        Cust.Reset;

                        Cust.SetRange(Cust."No.", "Member No");
                        if Cust.Find('-') then begin
                            SMSMessage."Telephone No" := Cust."Mobile Phone No";
                        end;
                        if Cust."Mobile Phone No" <> '' then
                            SMSMessage.Insert;
                        compinfo.Get();
                        if Confirm('Are you sure you want to notify Guarantors about this Loan ?', true) = false then
                            exit;
                        LoanGuar.Reset;
                        LoanGuar.SetRange(LoanGuar."Loan No", "Loan In Default");
                        if LoanGuar.Find('-') then begin
                            repeat
                                Cust.Reset;
                                Cust.SetRange(Cust."No.", LoanGuar."Member No");
                                if Cust.Find('-') then begin
                                    Message(Format(Cust."No."));
                                    SFactory.FnSendSMS('Defaulter 2nd Notice', 'Dear ' + LoanGuar.Name + '.This is to notify you that ' + "Member Name" + 'has defaulted a loan No.'
                                    + "Loan In Default" + ' you had guaranteed by KSHs.' + Format(LoanGuar."Amont Guaranteed") + ' at ACUMEN SACCO LTD.',
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
                        SMSMessage."Document No" := "Loan In Default";
                        SMSMessage."Account No" := "Member No";
                        SMSMessage."Date Entered" := Today;
                        SMSMessage."Time Entered" := Time;
                        SMSMessage.Source := 'LOAN DEFAULTERS';
                        SMSMessage."Entered By" := UserId;
                        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                        SMSMessage."SMS Message" := 'Dear ' + "Member Name" + '  kindly note that you have defaulted your loan ' + "Loan In Default" + '  by KSHs. '
                        + Format("Amount In Arrears") + 'Arrears. at ACUMEN SACCO LTD. Kindly clear your loan arrears within 14 Days after which we will recover it from your savings' + compinfo.Name + ' ' + GenSetup."Customer Care No";
                        Cust.Reset;

                        Cust.SetRange(Cust."No.", "Member No");
                        if Cust.Find('-') then begin
                            SMSMessage."Telephone No" := Cust."Mobile Phone No";
                        end;
                        if Cust."Mobile Phone No" <> '' then
                            SMSMessage.Insert;
                        compinfo.Get();
                        if Confirm('Are you sure you want to notify Guarantors about this Loan ?', true) = false then
                            exit;
                        LoanGuar.Reset;
                        LoanGuar.SetRange(LoanGuar."Loan No", "Loan In Default");
                        if LoanGuar.Find('-') then begin
                            repeat
                                Cust.Reset;
                                Cust.SetRange(Cust."No.", LoanGuar."Member No");
                                if Cust.Find('-') then begin
                                    Message(Format(Cust."No."));
                                    SFactory.FnSendSMS('Defaulter', 'Dear ' + LoanGuar.Name + '.This is to notify you that ' + "Member Name" + ' defaulted a loan No.'
                                    + "Loan In Default" + ' you had guaranteed by KSHs.' + Format(LoanGuar."Amont Guaranteed") + '.If loan arrears are not Payed within 14 Days we will recover it from your savings',
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

    trigger OnAfterGetCurrRecord()
    begin
        /*
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        EnabledApprovalWorkflowsExist :=TRUE;
        IF Rec.Status=Status::Approved THEN BEGIN
          OpenApprovalEntriesExist:=FALSE;
          CanCancelApprovalForRecord:=FALSE;
          EnabledApprovalWorkflowsExist:=FALSE;
          END;
          */

    end;

    trigger OnAfterGetRecord()
    begin
        FNenableVisbility();
        FNenableEditing();
    end;

    trigger OnOpenPage()
    begin
        FNenableVisbility();
        FNenableEditing();
    end;

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
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        ObjLoans: Record "Loans Register";
        ObjDemands: Record "Default Notices Register";
        VarAuctioneerDetailsVisible: Boolean;
        compinfo: Record "Company Information";
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Cust: Record "Member Register";
        LoanApps: Record "Loans Register";
        LoanGuar: Record "Loans Guarantee Details";
        SFactory: Codeunit "SURESTEP Factory.";

    local procedure FNenableVisbility()
    begin
        VarAuctioneerDetailsVisible := false;

        if "Notice Type" = "notice type"::"Auctioneers Notice" then begin
            VarAuctioneerDetailsVisible := true;
        end
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
        SMSMessage."Account No" := AccountNo;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'BATCH';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member,Your Loan has been Approved and posted to your FOSA Account,'
        + compinfo.Name + ' ' + GenSetup."Customer Care No";
        Cust.Reset;
        Cust.SetRange(Cust."No.", AccountNo);
        if Cust.Find('-') then begin
            SMSMessage."Telephone No" := Cust."Mobile Phone No";
        end;
        if Cust."Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;
}

