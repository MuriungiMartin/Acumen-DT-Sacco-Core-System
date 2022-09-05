#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516904 "SCustody Package Booking Card"
{
    PageType = Card;
    SourceTable = "Safe Custody Package Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Package ID"; "Package ID")
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
                field("Package Type"; "Package Type")
                {
                    ApplicationArea = Basic;
                    Editable = PackageTypeEditable;
                }
                field("Package Description"; "Package Description")
                {
                    ApplicationArea = Basic;
                    Editable = PackageDescriptionEditable;
                }
                field("Custody Period"; "Custody Period")
                {
                    ApplicationArea = Basic;
                    Editable = CustodyPeriodEditable;
                }
                field("Charge Account"; "Charge Account")
                {
                    ApplicationArea = Basic;
                    Editable = ChargeAccountEditable;
                }
                field("Charge Account Name"; "Charge Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Maturity Instruction"; "Maturity Instruction")
                {
                    ApplicationArea = Basic;
                    Editable = MaturityInstructionsEditable;
                }
                field("File Serial No"; "File Serial No")
                {
                    ApplicationArea = Basic;
                    Editable = FileSerialNoEditable;
                }
                field("Date Received"; "Date Received")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Time Received"; "Time Received")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Received By"; "Received By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Safe Custody Fee Charged"; "Safe Custody Fee Charged")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Lodged By(Custodian 1)"; "Lodged By(Custodian 1)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Lodged By(Custodian 2)"; "Lodged By(Custodian 2)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Lodged"; "Date Lodged")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Time Lodged"; "Time Lodged")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Released By(Custodian 1)"; "Released By(Custodian 1)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Released By(Custodian 2)"; "Released By(Custodian 2)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Released"; "Date Released")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Time Released"; "Time Released")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Collected By"; "Collected By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Collected On"; "Collected On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Collected At"; "Collected At")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Maturity Date"; "Maturity Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Retrieved By(Custodian 1)"; "Retrieved By(Custodian 1)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Retrieved By (Custodian 2)"; "Retrieved By (Custodian 2)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Retrieved On"; "Retrieved On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Retrieved At"; "Retrieved At")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Charge PackageLodge Fee")
            {
                ApplicationArea = Basic;
                Caption = 'Charge Package Lodge Fee';
                Enabled = ChargeLodgeFeeVisible;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to charge package Lodging Fee', false) = true then begin
                        if "Safe Custody Fee Charged" = true then begin
                            //ERROR('Safe Custody Fee for this package has been charged');
                        end;
                        ObjVendors.Reset;
                        ObjVendors.SetRange(ObjVendors."No.", "Charge Account");
                        if ObjVendors.Find('-') then begin
                            ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                            AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                            ObjAccTypes.Reset;
                            ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                            if ObjAccTypes.Find('-') then
                                AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
                        end;




                        JTemplate := 'GENERAL';
                        JBatch := 'SCUSTODY';
                        DocNo := 'Lodge_' + Format("Package ID");
                        GenSetup.Get();
                        LineNo := LineNo + 10000;
                        SurestepFactory.FnClearGnlJournalLine(JTemplate, JBatch);//Clear Journal Batch=============================
                        TransType := Transtype::" ";
                        AccountType := Accounttype::Vendor;
                        BalAccountType := Balaccounttype::"G/L Account";

                        ObjPackageTypes.Reset;
                        ObjPackageTypes.SetRange(ObjPackageTypes.Code, "Package Type");
                        if ObjPackageTypes.FindSet then begin
                            LodgeFee := ObjPackageTypes."Package Charge";
                            LodgeFeeAccount := ObjPackageTypes."Package Charge Account";
                        end;
                        GenSetup.Get();
                        if AvailableBal < (LodgeFee + (LodgeFee * (GenSetup."Excise Duty(%)" / 100))) then
                            Error('The Member has less than %1 Lodge Fee on their Account.Account Available Balance is %2', (LodgeFee + (LodgeFee * (GenSetup."Excise Duty(%)" / 100))), AvailableBal);


                        //Lodge Fee=============================================================================
                        LineNo := LineNo + 10000;
                        SurestepFactory.FnCreateGnlJournalLineBalanced(JTemplate, JBatch, DocNo, LineNo, TransType, AccountType, "Charge Account", Today, 'Package Lodge Charge_' + Format("Package ID"), BalAccountType, LodgeFeeAccount,
                        LodgeFee, 'BOSA', '');
                        //Lodge Fee=============================================================================
                        GenSetup.Get();
                        ExciseDuty := (LodgeFee * (GenSetup."Excise Duty(%)" / 100));
                        ExciseDutyAccount := GenSetup."Excise Duty Account";

                        GenSetup.Get();
                        //Excise On Lodge Fee=============================================================================
                        LineNo := LineNo + 10000;
                        SurestepFactory.FnCreateGnlJournalLineBalanced(JTemplate, JBatch, DocNo, LineNo, TransType, AccountType, "Charge Account", Today, 'Excise On Lodge Charge_' + Format("Package ID"), BalAccountType, ExciseDutyAccount,
                         ExciseDuty, 'BOSA', '');
                        //Excise On Lodge Fee=============================================================================

                    end;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'SCUSTODY');
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                    "Safe Custody Fee Charged" := true;
                    Message('Charge Amount of %1 Deducted Successfuly', LodgeFee + ExciseDuty);
                end;
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

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin

                        DocumentType := Documenttype::PackageLodging;
                        ApprovalEntries.Setfilters(Database::"Safe Custody Package Register", DocumentType, "Package ID");
                        ApprovalEntries.Run;
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

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                        ApprovalsMgmt: Codeunit WorkflowIntegration;
                    begin
                        //Check Item and Agent Attachment
                        ObjAgents.Reset;
                        ObjAgents.SetRange(ObjAgents."Package ID", "Package ID");
                        ObjAgents.SetFilter(ObjAgents."Agent Name", '<>%1', '');
                        if ObjAgents.FindSet = false then begin
                            Error('You have to specify atleast 1 package agent');
                        end;

                        ObjItems.Reset;
                        ObjItems.SetRange(ObjItems."Package ID", "Package ID");
                        ObjItems.SetFilter(ObjItems."Item Description", '<>%1', '');
                        if ObjItems.FindSet = false then begin
                            Error('You have to specify atleast 1 package item');
                        end;

                        if ApprovalsMgmt.CheckPackageLodgeApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendPackageLodgeForApproval(Rec)

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

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit WorkflowIntegration;
                    begin
                        if ApprovalsMgmt.CheckPackageLodgeApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnCancelPackageLodgeApprovalRequest(Rec);

                    end;
                }
            }
            group(Documents)
            {
                action("Package Agent")
                {
                    ApplicationArea = Basic;
                    Image = DocumentEdit;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "SCustody Agent List";
                    RunPageLink = "Package ID" = field("Package ID");
                }
                action("Package Items")
                {
                    ApplicationArea = Basic;
                    Image = DocumentEdit;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Safe Custody Item List";
                    RunPageLink = "Package ID" = field("Package ID");
                }
                action("Lodge Package")
                {
                    ApplicationArea = Basic;
                    Image = Lock;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Status <> Status::Approved then
                            Error('You can not lodge a package that is not approved');

                        if ("Lodged By(Custodian 1)" <> '') and ("Lodged By(Custodian 2)" <> '') then
                            Error('This Package has already been lodged');

                        ObjCustodians.Reset;
                        ObjCustodians.SetRange(ObjCustodians."User ID", UserId);
                        ObjCustodians.SetRange(ObjCustodians."Custodian Of", ObjCustodians."custodian of"::"Safe Custody");
                        if ObjCustodians.Find('-') = true then begin
                            if ("Lodged By(Custodian 1)" = '') and ("Lodged By(Custodian 2)" <> UserId) then begin
                                "Lodged By(Custodian 1)" := UserId
                            end else
                                if ("Lodged By(Custodian 2)" = '') and ("Lodged By(Custodian 1)" <> UserId) then begin
                                    "Lodged By(Custodian 2)" := UserId
                                end;
                        end;

                        ObjCustodians.Reset;
                        ObjCustodians.SetRange(ObjCustodians."User ID", UserId);
                        ObjCustodians.SetRange(ObjCustodians."Custodian Of", ObjCustodians."custodian of"::"Safe Custody");
                        if ObjCustodians.Find('-') = false then begin
                            Error('You are not authorized to lodge Packages')
                        end;

                        if ("Lodged By(Custodian 1)" <> '') and ("Lodged By(Custodian 2)" <> '') then begin
                            "Date Lodged" := Today;
                            "Time Lodged" := Time;
                        end;


                        //Update Lodge Details on Items
                        ObjItems.Reset;
                        ObjItems.SetRange(ObjItems."Package ID", "Package ID");
                        if ObjItems.FindSet then begin
                            repeat
                                ObjItems."Lodged By(Custodian 1)" := "Lodged By(Custodian 1)";
                                ObjItems."Lodged By(Custodian 2)" := "Lodged By(Custodian 2)";
                                ObjItems."Date Lodged" := "Date Lodged";
                                ObjItems.Modify;
                            until ObjItems.Next = 0;
                        end;
                    end;
                }
                action(RetrievePackage)
                {
                    ApplicationArea = Basic;
                    Caption = 'Retrieve Package';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Package Retrieval Request List";

                    trigger OnAction()
                    begin
                        /*IF Status<>Status::Approved THEN
                          ERROR('You can not Retrieve a package that is not approved');
                        
                        IF ("Retrieved By(Custodian 1)"<>'') AND ("Retrieved By (Custodian 2)"<>'') THEN
                          ERROR('This Package has already been Retrieved');
                        
                        ObjCustodians.RESET;
                        ObjCustodians.SETRANGE(ObjCustodians."User ID",USERID);
                        IF ObjCustodians.FINDSET=TRUE THEN BEGIN
                          IF ("Retrieved By(Custodian 1)"='') AND ("Retrieved By (Custodian 2)"<>USERID) THEN BEGIN
                            "Retrieved By(Custodian 1)":=USERID
                            END ELSE
                            IF ("Retrieved By (Custodian 2)"='') AND ("Retrieved By(Custodian 1)"<>USERID) THEN BEGIN
                            "Retrieved By (Custodian 2)":=USERID
                          END ELSE
                          ERROR('You are not authorized to Retrieve Packages')
                            END;
                        
                        IF ("Retrieved By(Custodian 1)"<>'') AND ("Retrieved By (Custodian 2)"<>'') THEN BEGIN
                          "Retrieved On":=TODAY;
                          "Retrieved At":=TIME;
                        
                        JTemplate:='GENERAL';
                          JBatch:='SCUSTODY';
                          DocNo:='Lodge_'+FORMAT("Package ID");
                          GenSetup.GET();
                          LineNo:=LineNo+10000;
                          TransType:=TransType::" ";
                          AccountType:=AccountType::Vendor;
                          BalAccountType:=BalAccountType::"G/L Account";
                        
                          ObjPackageTypes.RESET;
                          ObjPackageTypes.SETRANGE(ObjPackageTypes.Code,"Package Type");
                          IF ObjPackageTypes.FINDSET THEN BEGIN
                            LodgeFee:=ObjPackageTypes."Package Retrieval Fee";
                            LodgeFeeAccount:=ObjPackageTypes."Package Retrieval Fee Account";
                            END;
                        
                            IF AvailableBal<LodgeFee THEN
                             //ERROR('The Member has less than %1 Lodge Fee on their Account.Account Available Balance is %2',LodgeFee,AvailableBal);
                        
                           SurestepFactory.FnCreateGnlJournalLineBalanced(JTemplate,JBatch,DocNo,LineNo,TransType,AccountType,"Charge Account",TODAY,'Package Retrieval Charge_'+FORMAT("Package ID"),BalAccountType,LodgeFeeAccount,
                           LodgeFee,'BOSA','');
                        
                          SurestepFactory.FnPostGnlJournalLine(JTemplate,JBatch);
                          MESSAGE('Charge Amount of %1 Deducted Successfuly',LodgeFee);
                          END;
                        
                        
                        
                        
                        
                        
                        //Update Lodge Details on Items
                        ObjItems.RESET;
                        ObjItems.SETRANGE(ObjItems."Package ID","Package ID");
                        IF ObjItems.FINDSET THEN BEGIN
                          REPEAT
                            ObjItems."Lodged By(Custodian 1)":="Lodged By(Custodian 1)";
                            ObjItems."Lodged By(Custodian 2)":="Lodged By(Custodian 2)";
                            ObjItems."Date Lodged":="Date Lodged";
                            ObjItems.MODIFY;
                            UNTIL ObjItems.NEXT=0;
                          END;
                          */

                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        Approv: codeunit "Approvals Mgmt.";
    begin

        OpenApprovalEntriesExist := Approv.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := Approv.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
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
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff;
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
        ObjPackageTypes: Record "Package Types";
        LodgeFee: Decimal;
        LodgeFeeAccount: Code[20];
        ObjCustodians: Record "Safe Custody Custodians";
        ObjItems: Record "Safe Custody Item Register";
        ObjAgents: Record "Safe Custody Agents Register";
        LodgeVisible: Boolean;
        ChargeLodgeFeeVisible: Boolean;
        RetrievalRequestVisible: Boolean;
        PackageTypeEditable: Boolean;
        PackageDescriptionEditable: Boolean;
        CustodyPeriodEditable: Boolean;
        ChargeAccountEditable: Boolean;
        MaturityInstructionsEditable: Boolean;
        FileSerialNoEditable: Boolean;
        AddAgentEditable: Boolean;
        AddItemsEditable: Boolean;
        ApprovalsMgmt: Codeunit WorkflowIntegration;
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        ExciseDuty: Decimal;
        ExciseDutyAccount: Code[50];
        GenJournalLine: Record "Gen. Journal Line";

    local procedure FNenableVisbility()
    begin
        if Status <> Status::Approved then begin
            LodgeVisible := false;
            ChargeLodgeFeeVisible := false;
            RetrievalRequestVisible := false
        end;
        if Status = Status::Approved then begin
            LodgeVisible := true;
            ChargeLodgeFeeVisible := true;
            RetrievalRequestVisible := true;
        end;
    end;

    local procedure FNenableEditing()
    begin
        if Status = Status::Open then begin
            PackageTypeEditable := true;
            PackageDescriptionEditable := true;
            MaturityInstructionsEditable := true;
            CustodyPeriodEditable := true;
            FileSerialNoEditable := true;
            ChargeAccountEditable := true;
            AddAgentEditable := true;
            AddItemsEditable := true;
        end;

        if (Status = Status::"Pending Approval") or (Status = Status::Approved) then begin
            PackageTypeEditable := false;
            PackageDescriptionEditable := false;
            MaturityInstructionsEditable := false;
            CustodyPeriodEditable := false;
            FileSerialNoEditable := false;
            ChargeAccountEditable := false;
            AddAgentEditable := false;
            AddItemsEditable := false;
        end;
    end;
}

