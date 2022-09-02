#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516940 "Package Retrieval Request Card"
{
    PageType = Card;
    SourceTable = "Package Retrieval Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Request No"; "Request No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Package ID"; "Package ID")
                {
                    ApplicationArea = Basic;
                    Editable = PackageIDEditable;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Package Description"; "Package Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Retrieval Requested By"; "Retrieval Requested By")
                {
                    ApplicationArea = Basic;
                    Editable = RequestingAgentEditable;
                }
                field("Requesting Agent Name"; "Requesting Agent Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Requesting Agent ID/Passport"; "Requesting Agent ID/Passport")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Retrieval Request Date"; "Retrieval Request Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Retrieved By(Custodian 1)"; "Retrieved By(Custodian 1)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Retrieved By(Custodian 2)"; "Retrieved By(Custodian 2)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Retrieval Date"; "Retrieval Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Retrieval Charge Account"; "Retrieval Charge Account")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Charge Account Name"; "Charge Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Reason for Retrieval"; "Reason for Retrieval")
                {
                    ApplicationArea = Basic;
                    Editable = ReasonForRetrieval;
                }
                field("Package Expiry Date"; "Package Expiry Date")
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
                field("Re_Lodged By(Custodian 1)"; "Re_Lodged By(Custodian 1)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Re_Lodged By(Custodian 2)"; "Re_Lodged By(Custodian 2)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Re_Lodged"; "Date Re_Lodged")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Time Re_Lodged"; "Time Re_Lodged")
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
            }
            group("Agent Access Instructions")
            {
                Caption = 'Agent Access Instructions';
                field("Collect Package/Item"; "Collect Package/Item")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Add Package/Item"; "Add Package/Item")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Make Copy of Package/Item"; "Make Copy of Package/Item")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control24; "Custody Agent Picture")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "Agent ID" = field("Retrieval Requested By");
            }
            part(Control23; "Custody Agent Signature")
            {
                ApplicationArea = All;
                Caption = 'Signature';
                SubPageLink = "Agent ID" = field("Retrieval Requested By");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Charge Retrieval Fee")
            {
                ApplicationArea = Basic;
                Enabled = ChargeRetrievalFeeVisible;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to charge package retrieval Fee', false) = true then begin

                        ObjVendors.Reset;
                        ObjVendors.SetRange(ObjVendors."No.", "Retrieval Charge Account");
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
                        DocNo := 'Retr_' + Format("Request No");
                        GenSetup.Get();
                        LineNo := LineNo + 10000;
                        TransType := Transtype::" ";
                        AccountType := Accounttype::Vendor;
                        BalAccountType := Balaccounttype::"G/L Account";

                        ObjPackageTypes.Reset;
                        ObjPackageTypes.SetRange(ObjPackageTypes.Code, "Package Type");
                        if ObjPackageTypes.FindSet then begin
                            RetrievalFee := ObjPackageTypes."Package Retrieval Fee";
                            RetrievalFeeAccount := ObjPackageTypes."Package Retrieval Fee Account";
                        end;
                        GenSetup.Get();
                        if AvailableBal < (RetrievalFee + (RetrievalFee * GenSetup."Excise Duty(%)" / 100)) then
                            Error('The Member has less than %1 retrieval Fee on their Account,Account Available Balance is %2', (RetrievalFee + (RetrievalFee * GenSetup."Excise Duty(%)" / 100)), AvailableBal);

                        SurestepFactory.FnClearGnlJournalLine(JTemplate, JBatch);
                        //Retrieval Fee=============================================================================
                        LineNo := LineNo + 10000;
                        SurestepFactory.FnCreateGnlJournalLineBalanced(JTemplate, JBatch, DocNo, LineNo, TransType, AccountType, "Retrieval Charge Account", Today, 'Package Retrieval Charge_' + Format("Request No"), BalAccountType, RetrievalFeeAccount,
                        RetrievalFee, 'BOSA', '');
                        //Retrieval Fee=============================================================================

                        ExciseDuty := (RetrievalFee * (GenSetup."Excise Duty(%)" / 100));
                        ExciseDutyAccount := GenSetup."Excise Duty Account";

                        GenSetup.Get();
                        //Excise On Retrieval Fee=============================================================================
                        LineNo := LineNo + 10000;
                        SurestepFactory.FnCreateGnlJournalLineBalanced(JTemplate, JBatch, DocNo, LineNo, TransType, AccountType, "Retrieval Charge Account", Today, 'Excise On Retrieval Charge_' + Format("Request No"), BalAccountType, ExciseDutyAccount,
                         ExciseDuty, 'BOSA', '');
                        //Excise On Retrieval Fee=============================================================================



                        SurestepFactory.FnPostGnlJournalLine(JTemplate, JBatch);
                    end;
                    Message('Retrieval Fee Amount of %1 Deducted Successfuly', RetrievalFee);
                end;
            }
            action("Retrieve Package")
            {
                ApplicationArea = Basic;
                Image = LinkAccount;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Status <> Status::Approved then
                        Error('This Request is yet to be approved');

                    if ("Retrieved By(Custodian 1)" <> '') and ("Retrieved By(Custodian 2)" <> '') then
                        Error('This Package has already been Retrieve');

                    ObjCustodians.Reset;
                    ObjCustodians.SetRange(ObjCustodians."User ID", UserId);
                    ObjCustodians.SetRange(ObjCustodians."Custodian Of", ObjCustodians."custodian of"::"Safe Custody");
                    if ObjCustodians.Find('-') = true then begin

                        if ("Retrieved By(Custodian 1)" = '') and ("Retrieved By(Custodian 2)" <> UserId) then begin
                            "Retrieved By(Custodian 1)" := UserId
                        end else
                            if ("Retrieved By(Custodian 2)" = '') and ("Retrieved By(Custodian 1)" <> UserId) then begin
                                "Retrieved By(Custodian 2)" := UserId
                            end;
                    end;

                    ObjCustodians.Reset;
                    ObjCustodians.SetRange(ObjCustodians."User ID", UserId);
                    ObjCustodians.SetRange(ObjCustodians."Custodian Of", ObjCustodians."custodian of"::"Safe Custody");
                    if ObjCustodians.Find('-') = false then begin
                        Error('You are not authorized to lodge Packages')
                    end;


                    if ("Retrieved By(Custodian 1)" <> '') and ("Retrieved By(Custodian 2)" <> '') then begin
                        "Retrieval Date" := Today;
                    end;


                    //Update Retrieval Details on Items
                    ObjItems.Reset;
                    ObjItems.SetRange(ObjItems."Package ID", "Package ID");
                    if ObjItems.FindSet then begin
                        repeat
                            ObjItems."Retrieved By(Custodian 1)" := "Retrieved By(Custodian 1)";
                            ObjItems."Retrieved By(Custodian 2)" := "Retrieved By(Custodian 2)";
                            ObjItems."Retrieved On" := "Retrieval Date";
                            ObjItems.Modify;
                        until ObjItems.Next = 0;
                    end;

                    //Update Retrieval Details On Package
                    ObjPackage.Reset;
                    ObjPackage.SetRange(ObjPackage."Package ID", "Package ID");
                    if ObjPackage.FindSet then begin
                        repeat
                            ObjPackage."Retrieved By(Custodian 1)" := "Retrieved By(Custodian 1)";
                            ObjPackage."Retrieved By (Custodian 2)" := "Retrieved By(Custodian 2)";
                            ObjPackage."Retrieved On" := "Retrieval Date";
                            ObjPackage."Retrieved At" := Time;
                            ObjPackage.Modify;
                        until ObjPackage.Next = 0;
                    end;
                end;
            }
            action("Re_Lodge Package")
            {
                ApplicationArea = Basic;
                Image = Lock;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Status <> Status::Approved then
                        Error('You can not Re_lodge a package that is not approved');

                    if ("Re_Lodged By(Custodian 1)" <> '') and ("Re_Lodged By(Custodian 2)" <> '') then
                        Error('This Package has already been Re_lodged');

                    ObjCustodians.Reset;
                    ObjCustodians.SetRange(ObjCustodians."User ID", UserId);
                    ObjCustodians.SetRange(ObjCustodians."Custodian Of", ObjCustodians."custodian of"::"Safe Custody");
                    if ObjCustodians.FindSet = true then begin
                        if ("Re_Lodged By(Custodian 1)" = '') and ("Re_Lodged By(Custodian 2)" <> UserId) then begin
                            "Re_Lodged By(Custodian 1)" := UserId
                        end else
                            if ("Re_Lodged By(Custodian 2)" = '') and ("Re_Lodged By(Custodian 1)" <> UserId) then begin
                                "Re_Lodged By(Custodian 2)" := UserId
                            end else
                                Error('You are not authorized to lodge Packages')
                    end;

                    if ("Re_Lodged By(Custodian 1)" <> '') and ("Re_Lodged By(Custodian 2)" <> '') then begin
                        "Date Re_Lodged" := Today;
                        "Time Re_Lodged" := Time;
                    end;

                    /*
                    //Update Lodge Details on Items
                    ObjItems.RESET;
                    ObjItems.SETRANGE(ObjItems."Package ID","Package ID");
                    IF ObjItems.FINDSET THEN BEGIN
                      REPEAT
                        ObjItems."Retrieved By(Custodian 1)":="Lodged By(Custodian 1)";
                        ObjItems."Lodged By(Custodian 2)":="Lodged By(Custodian 2)";
                        ObjItems."Date Lodged":="Date Lodged";
                        ObjItems.MODIFY;
                        UNTIL ObjItems.NEXT=0;
                      END;
                      */

                end;
            }
            action("Release Package")
            {
                ApplicationArea = Basic;
                Image = UnLinkAccount;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Status <> Status::Approved then
                        Error('You can not Release a package that is not approved');

                    if ("Re_Lodged By(Custodian 1)" <> '') and ("Re_Lodged By(Custodian 2)" <> '') then
                        Error('This Package has already been Released');

                    ObjCustodians.Reset;
                    ObjCustodians.SetRange(ObjCustodians."User ID", UserId);
                    if ObjCustodians.FindSet = true then begin
                        if ("Released By(Custodian 1)" = '') and ("Released By(Custodian 2)" <> UserId) then begin
                            "Released By(Custodian 1)" := UserId
                        end else
                            if ("Released By(Custodian 2)" = '') and ("Released By(Custodian 1)" <> UserId) then begin
                                "Released By(Custodian 2)" := UserId
                            end else
                                Error('You are not authorized to Release Packages')
                    end;

                    if ("Released By(Custodian 1)" <> '') and ("Released By(Custodian 2)" <> '') then begin
                        "Date Released" := Today;
                        "Time Released" := Time;
                    end;


                    //Update Release Details on Package
                    ObjPackages.Reset;
                    ObjPackages.SetRange(ObjPackages."Package ID", "Package ID");
                    if ObjPackages.FindSet then begin
                        repeat
                            ObjPackages."Released By(Custodian 1)" := "Released By(Custodian 1)";
                            ObjPackages."Released By(Custodian 2)" := "Released By(Custodian 2)";
                            ObjPackages."Date Released" := "Date Released";
                            ObjPackages.Modify;
                        until ObjPackages.Next = 0;
                    end;

                    //Update Release Details on Items
                    ObjItems.Reset;
                    ObjItems.SetRange(ObjItems."Package ID", "Package ID");
                    if ObjItems.FindSet then begin
                        repeat
                            ObjItems."Released By(Custodian 1)" := "Released By(Custodian 1)";
                            ObjItems."Released By(Custodian 2)" := "Released By(Custodian 2)";
                            ObjItems."Date Released" := "Date Released";
                            ObjItems.Modify;
                        until ObjItems.Next = 0;
                    end;

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

                        DocumentType := Documenttype::PackageRetrieval;
                        ApprovalEntries.Setfilters(Database::"Bulk Withdrawal Application", DocumentType, "Package ID");
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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        if ApprovalsMgmt.CheckPackageRetrievalApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendPackageRetrievalForApproval(Rec)

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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckPackageRetrievalApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnCancelPackageRetrievalApprovalRequest(Rec);

                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin

        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        FnEnableFieldEditable();
        FnEnableVisibility();
    end;

    trigger OnOpenPage()
    begin
        FnEnableFieldEditable();
        FnEnableVisibility();
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
        ObjItems: Record "Safe Custody Item Register";
        ObjPackage: Record "Safe Custody Package Register";
        ObjCustodians: Record "Safe Custody Custodians";
        PackageIDEditable: Boolean;
        RequestingAgentEditable: Boolean;
        ReasonForRetrieval: Boolean;
        ChargeRetrievalFeeVisible: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ObjPackageTypes: Record "Package Types";
        RetrievalFee: Decimal;
        RetrievalFeeAccount: Code[20];
        ObjVendors: Record Vendor;
        AvailableBal: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
        ExciseDuty: Decimal;
        ExciseDutyAccount: Code[20];
        ObjPackages: Record "Safe Custody Package Register";

    local procedure FnEnableFieldEditable()
    begin
        if (Status = Status::Approved) or (Status = Status::"Pending Approval") then begin
            PackageIDEditable := false;
            RequestingAgentEditable := false;
            ReasonForRetrieval := false;
        end;
        if (Status = Status::Open) then begin
            PackageIDEditable := true;
            RequestingAgentEditable := true;
            ReasonForRetrieval := true;
        end;
    end;

    local procedure FnEnableVisibility()
    begin
        if Status <> Status::Approved then begin
            ChargeRetrievalFeeVisible := false
        end else
            ChargeRetrievalFeeVisible := true;
    end;
}

