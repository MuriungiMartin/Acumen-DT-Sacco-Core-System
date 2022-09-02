#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516974 "Collateral Action Card"
{
    PageType = Card;
    SourceTable = "Loan Collateral Register";

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
                field("Member No."; "Member No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Type"; "Collateral Type")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Description"; "Collateral Description")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Posting Group"; "Collateral Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Date Received"; "Date Received")
                {
                    ApplicationArea = Basic;
                }
                field("Registered Owner"; "Registered Owner")
                {
                    ApplicationArea = Basic;
                }
                field("Reference No"; "Reference No")
                {
                    ApplicationArea = Basic;
                }
                field("Received By"; "Received By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Released"; "Date Released")
                {
                    ApplicationArea = Basic;
                }
                field("Released By"; "Released By")
                {
                    ApplicationArea = Basic;
                }
                field(Picture; Picture)
                {
                    ApplicationArea = Basic;
                }
                field("Last Collateral Action"; "Last Collateral Action")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Insurance Details")
            {
                field("Insurance Effective Date"; "Insurance Effective Date")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Expiration Date"; "Insurance Expiration Date")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Policy No."; "Insurance Policy No.")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Annual Premium"; "Insurance Annual Premium")
                {
                    ApplicationArea = Basic;
                }
                field("Policy Coverage"; "Policy Coverage")
                {
                    ApplicationArea = Basic;
                }
                field("Total Value Insured"; "Total Value Insured")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Type"; "Insurance Type")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Vendor No."; "Insurance Vendor No.")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Depreciation Details")
            {
                field("Asset Value"; "Asset Value")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Depreciation Completion Date"; "Depreciation Completion Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expected Date of Loan Complition';
                    Editable = true;
                }
                field("Depreciation Percentage"; "Depreciation Percentage")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Collateral Depreciation Method"; "Collateral Depreciation Method")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Asset Depreciation Amount"; "Asset Depreciation Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Asset Value @Loan Completion"; "Asset Value @Loan Completion")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
            }
            group("Actions")
            {
                Caption = 'Actions';
                field("Action"; Action)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        FnGetVisibility();
                    end;
                }
            }
            group("Received at HQ")
            {
                Visible = ReceivedAtHQVisible;
                field("Received to HQ By"; "Received to HQ By")
                {
                    ApplicationArea = Basic;
                }
                field("Received to HQ On"; "Received to HQ On")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Strong Room")
            {
                Visible = StrongRoomVisible;
                field("Lodged to Strong Room By"; "Lodged to Strong Room By")
                {
                    ApplicationArea = Basic;
                }
                field("Lodged to Strong Room On"; "Lodged to Strong Room On")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieved From Strong Room By"; "Retrieved From Strong Room By")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieved From Strong Room On"; "Retrieved From Strong Room On")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Lawyer)
            {
                Visible = LawyerVisible;
                field("Issued to Lawyer By"; "Issued to Lawyer By")
                {
                    ApplicationArea = Basic;
                }
                field("Issued to Lawyer On"; "Issued to Lawyer On")
                {
                    ApplicationArea = Basic;
                }
                field("Lawyer Code"; "Lawyer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Lawyer Name"; "Lawyer Name")
                {
                    ApplicationArea = Basic;
                }
                field("Received From Lawyer By"; "Received From Lawyer By")
                {
                    ApplicationArea = Basic;
                }
                field("Received From Lawyer On"; "Received From Lawyer On")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Insurance Agent")
            {
                Visible = InsuranceAgentVisible;
                field("Issued to Insurance Agent By"; "Issued to Insurance Agent By")
                {
                    ApplicationArea = Basic;
                }
                field("Issued to Insurance Agent On"; "Issued to Insurance Agent On")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Agent Code"; "Insurance Agent Code")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Agent Name"; "Insurance Agent Name")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Branch)
            {
                Visible = BranchVisible;
                field("Dispatched to Branch By"; "Dispatched to Branch By")
                {
                    ApplicationArea = Basic;
                }
                field("Dispatched to Branch On"; "Dispatched to Branch On")
                {
                    ApplicationArea = Basic;
                }
                field("Dispatch to Branch"; "Dispatch to Branch")
                {
                    ApplicationArea = Basic;
                }
                field("Received at Branch By"; "Received at Branch By")
                {
                    ApplicationArea = Basic;
                }
                field("Received at Branch On"; "Received at Branch On")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Issue to Member")
            {
                Visible = IssuetoMemberVisible;
                field("Released to Member By"; "Released to Member By")
                {
                    ApplicationArea = Basic;
                }
                field("Released to Member on"; "Released to Member on")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Issued to Auctioneers")
            {
                Visible = IssuetoAuctioneerVisible;
                field("Issued to Auctioneer By"; "Issued to Auctioneer By")
                {
                    ApplicationArea = Basic;
                }
                field("Issued to Auctioneer On"; "Issued to Auctioneer On")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Safe Custody")
            {
                Visible = SafeCustodyVisible;
                field("Package Type"; "Package Type")
                {
                    ApplicationArea = Basic;
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
                field("Date Released from SafeCustody"; "Date Released from SafeCustody")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Time Released from SafeCustody"; "Time Released from SafeCustody")
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
            action("Calculate Depreciation")
            {
                ApplicationArea = Basic;
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    VarNoofYears := ROUND(("Depreciation Completion Date" - Today) / 365, 1, '>');

                    //===========Update Year 1 Depreciation==================================
                    ObjCollateralDeprReg.Reset;
                    ObjCollateralDeprReg.SetRange(ObjCollateralDeprReg."Document No", "Document No");
                    if ObjCollateralDeprReg.FindSet = false then begin
                        VarDepreciationValue := "Asset Value" * ("Depreciation Percentage" / 100);

                        ObjCollateralDeprReg.Init;
                        ObjCollateralDeprReg."Document No" := "Document No";
                        ObjCollateralDeprReg."Transaction Date" := CalcDate('1Y', Today);
                        ObjCollateralDeprReg."Transaction Description" := 'Year 1 Depreciation';
                        ObjCollateralDeprReg."Depreciation Amount" := VarDepreciationValue;
                        ObjCollateralDeprReg."Collateral NBV" := "Asset Value" - VarDepreciationValue;
                        ObjCollateralDeprReg.Insert;

                    end;
                    //=============End of Update Year 1 Depreciation==========================


                    //===========Update Year 2 Depreciation==================================

                    ObjCollateralDeprReg.Reset;
                    ObjCollateralDeprReg.SetRange(ObjCollateralDeprReg."Document No", "Document No");
                    if ObjCollateralDeprReg.FindLast then begin
                        VarCurrentNBV := ObjCollateralDeprReg."Collateral NBV";
                        VarDepreciationValue := ObjCollateralDeprReg."Collateral NBV" * ("Depreciation Percentage" / 100);
                    end;

                    ObjDepreciationRegister.Reset;
                    ObjDepreciationRegister.SetRange(ObjDepreciationRegister."Document No", "Document No");
                    if ObjDepreciationRegister.FindSet then begin
                        VarDepreciationNo := ObjDepreciationRegister.Count + 1;
                    end;

                    if (CalcDate('1Y', ObjCollateralDeprReg."Transaction Date")) <= "Depreciation Completion Date" then begin
                        ObjCollateralDeprReg.Init;
                        ObjCollateralDeprReg."Document No" := "Document No";
                        ObjCollateralDeprReg."Transaction Date" := CalcDate('1Y', ObjCollateralDeprReg."Transaction Date");
                        ObjCollateralDeprReg."Transaction Description" := 'Year ' + Format(VarDepreciationNo) + ' Depreciation';
                        ObjCollateralDeprReg."Depreciation Amount" := VarDepreciationValue;
                        ObjCollateralDeprReg."Collateral NBV" := VarCurrentNBV - VarDepreciationValue;
                        ObjCollateralDeprReg.Insert;
                    end;
                    //=============End of Update Year 2 Depreciation==========================

                    //===========Update Year 3 Depreciation==================================

                    ObjCollateralDeprReg.Reset;
                    ObjCollateralDeprReg.SetRange(ObjCollateralDeprReg."Document No", "Document No");
                    if ObjCollateralDeprReg.FindLast then begin
                        VarCurrentNBV := ObjCollateralDeprReg."Collateral NBV";
                        VarDepreciationValue := ObjCollateralDeprReg."Collateral NBV" * ("Depreciation Percentage" / 100);
                    end;

                    ObjDepreciationRegister.Reset;
                    ObjDepreciationRegister.SetRange(ObjDepreciationRegister."Document No", "Document No");
                    if ObjDepreciationRegister.FindSet then begin
                        VarDepreciationNo := ObjDepreciationRegister.Count + 1;
                    end;
                    if (CalcDate('1Y', ObjCollateralDeprReg."Transaction Date")) <= "Depreciation Completion Date" then begin
                        ObjCollateralDeprReg.Init;
                        ObjCollateralDeprReg."Document No" := "Document No";
                        ObjCollateralDeprReg."Transaction Date" := CalcDate('1Y', ObjCollateralDeprReg."Transaction Date");
                        ObjCollateralDeprReg."Transaction Description" := 'Year ' + Format(VarDepreciationNo) + ' Depreciation';
                        ObjCollateralDeprReg."Depreciation Amount" := VarDepreciationValue;
                        ObjCollateralDeprReg."Collateral NBV" := VarCurrentNBV - VarDepreciationValue;
                        ObjCollateralDeprReg.Insert;
                    end;
                    //=============End of Update Year 3 Depreciation==========================

                    //===========Update Year 4 Depreciation==================================

                    ObjCollateralDeprReg.Reset;
                    ObjCollateralDeprReg.SetRange(ObjCollateralDeprReg."Document No", "Document No");
                    if ObjCollateralDeprReg.FindLast then begin
                        VarCurrentNBV := ObjCollateralDeprReg."Collateral NBV";
                        VarDepreciationValue := ObjCollateralDeprReg."Collateral NBV" * ("Depreciation Percentage" / 100);
                    end;

                    ObjDepreciationRegister.Reset;
                    ObjDepreciationRegister.SetRange(ObjDepreciationRegister."Document No", "Document No");
                    if ObjDepreciationRegister.FindSet then begin
                        VarDepreciationNo := ObjDepreciationRegister.Count + 1;
                    end;
                    if (CalcDate('1Y', ObjCollateralDeprReg."Transaction Date")) <= "Depreciation Completion Date" then begin
                        ObjCollateralDeprReg.Init;
                        ObjCollateralDeprReg."Document No" := "Document No";
                        ObjCollateralDeprReg."Transaction Date" := CalcDate('1Y', ObjCollateralDeprReg."Transaction Date");
                        ObjCollateralDeprReg."Transaction Description" := 'Year ' + Format(VarDepreciationNo) + ' Depreciation';
                        ObjCollateralDeprReg."Depreciation Amount" := VarDepreciationValue;
                        ObjCollateralDeprReg."Collateral NBV" := VarCurrentNBV - VarDepreciationValue;
                        ObjCollateralDeprReg.Insert;
                    end;
                    //=============End of Update Year 4 Depreciation==========================

                    //===========Update Year 5 Depreciation==================================

                    ObjCollateralDeprReg.Reset;
                    ObjCollateralDeprReg.SetRange(ObjCollateralDeprReg."Document No", "Document No");
                    if ObjCollateralDeprReg.FindLast then begin
                        VarCurrentNBV := ObjCollateralDeprReg."Collateral NBV";
                        VarDepreciationValue := ObjCollateralDeprReg."Collateral NBV" * ("Depreciation Percentage" / 100);
                    end;

                    ObjDepreciationRegister.Reset;
                    ObjDepreciationRegister.SetRange(ObjDepreciationRegister."Document No", "Document No");
                    if ObjDepreciationRegister.FindSet then begin
                        VarDepreciationNo := ObjDepreciationRegister.Count + 1;
                    end;
                    if (CalcDate('1Y', ObjCollateralDeprReg."Transaction Date")) <= "Depreciation Completion Date" then begin
                        ObjCollateralDeprReg.Init;
                        ObjCollateralDeprReg."Document No" := "Document No";
                        ObjCollateralDeprReg."Transaction Date" := CalcDate('1Y', ObjCollateralDeprReg."Transaction Date");
                        ObjCollateralDeprReg."Transaction Description" := 'Year ' + Format(VarDepreciationNo) + ' Depreciation';
                        ObjCollateralDeprReg."Depreciation Amount" := VarDepreciationValue;
                        ObjCollateralDeprReg."Collateral NBV" := VarCurrentNBV - VarDepreciationValue;
                        ObjCollateralDeprReg.Insert;
                    end;
                    //=============End of Update Year 5 Depreciation==========================

                    //===========Update Year 6 Depreciation==================================

                    ObjCollateralDeprReg.Reset;
                    ObjCollateralDeprReg.SetRange(ObjCollateralDeprReg."Document No", "Document No");
                    if ObjCollateralDeprReg.FindLast then begin
                        VarCurrentNBV := ObjCollateralDeprReg."Collateral NBV";
                        VarDepreciationValue := ObjCollateralDeprReg."Collateral NBV" * ("Depreciation Percentage" / 100);
                    end;

                    ObjDepreciationRegister.Reset;
                    ObjDepreciationRegister.SetRange(ObjDepreciationRegister."Document No", "Document No");
                    if ObjDepreciationRegister.FindSet then begin
                        VarDepreciationNo := ObjDepreciationRegister.Count + 1;
                    end;
                    if (CalcDate('1Y', ObjCollateralDeprReg."Transaction Date")) <= "Depreciation Completion Date" then begin
                        ObjCollateralDeprReg.Init;
                        ObjCollateralDeprReg."Document No" := "Document No";
                        ObjCollateralDeprReg."Transaction Date" := CalcDate('1Y', ObjCollateralDeprReg."Transaction Date");
                        ObjCollateralDeprReg."Transaction Description" := 'Year ' + Format(VarDepreciationNo) + ' Depreciation';
                        ObjCollateralDeprReg."Depreciation Amount" := VarDepreciationValue;
                        ObjCollateralDeprReg."Collateral NBV" := VarCurrentNBV - VarDepreciationValue;
                        ObjCollateralDeprReg.Insert;
                    end;
                    //=============End of Update Year 6 Depreciation==========================
                end;
            }
            action("Depreciation Schedule")
            {
                ApplicationArea = Basic;
                Image = Form;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Collateral Depr. Schedule";
                RunPageLink = "Document No" = field("Document No");
            }
            action("Charge PackageLodge Fee")
            {
                ApplicationArea = Basic;
                Caption = 'Charge Package Lodge Fee';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to charge package Lodging Fee', false) = true then begin

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
                        DocNo := 'Lodge_' + Format("Document No");
                        GenSetup.Get();
                        LineNo := LineNo + 10000;
                        TransType := Transtype::" ";
                        AccountType := Accounttype::Vendor;
                        BalAccountType := Balaccounttype::"G/L Account";

                        ObjPackageTypes.Reset;
                        ObjPackageTypes.SetRange(ObjPackageTypes.Code, "Package Type");
                        if ObjPackageTypes.FindSet then begin
                            LodgeFee := ObjPackageTypes."Package Charge";
                            LodgeFeeAccount := ObjPackageTypes."Package Charge Account";
                        end;

                        if AvailableBal < LodgeFee then
                            Error('The Member has less than %1 Lodge Fee on their Account.Account Available Balance is %2', LodgeFee, AvailableBal);

                        SurestepFactory.FnCreateGnlJournalLineBalanced(JTemplate, JBatch, DocNo, LineNo, TransType, Accounttype::Vendor, "Charge Account", Today, 'Package Lodge Charge_' + Format("Document No"), Balaccounttype::"G/L Account", LodgeFeeAccount,
                        LodgeFee, 'BOSA', '');

                        SurestepFactory.FnPostGnlJournalLine(JTemplate, JBatch);
                    end;

                    Message('Charge Amount of %1 Deducted Successfuly', LodgeFee);
                end;
            }
            action("Lodge Package")
            {
                ApplicationArea = Basic;
                Image = LinkAccount;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Action <> Action::"Booked to Safe Custody" then
                        Error('This is action is only applicable to Safe Custody booking');

                    if ("Lodged By(Custodian 1)" <> '') and ("Lodged By(Custodian 2)" <> '') then
                        Error('This Package has already been lodged');

                    ObjCustodians.Reset;
                    ObjCustodians.SetRange(ObjCustodians."User ID", UserId);
                    if ObjCustodians.FindSet = true then begin
                        if ("Lodged By(Custodian 1)" = '') and ("Lodged By(Custodian 2)" <> UserId) then begin
                            "Lodged By(Custodian 1)" := UserId
                        end else
                            if ("Lodged By(Custodian 2)" = '') and ("Lodged By(Custodian 1)" <> UserId) then begin
                                "Lodged By(Custodian 2)" := UserId
                            end else
                                Error('You are not authorized to lodge Packages')
                    end;

                    if ("Lodged By(Custodian 1)" <> '') and ("Lodged By(Custodian 2)" <> '') then begin
                        "Date Lodged" := Today;
                        "Time Lodged" := Time;

                        //===========Create A Package in Safe Custody Module=======================
                        if ObjNoSeries.Get then begin
                            ObjNoSeries.TestField(ObjNoSeries."Safe Custody Package Nos");
                            VarPackageNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Safe Custody Package Nos", 0D, true);

                            ObjPackage.Init;
                            ObjPackage."Package ID" := VarPackageNo;
                            ObjPackage."Package Type" := "Package Type";
                            ObjPackage."Charge Account" := "Charge Account";
                            ObjPackage."Charge Account Name" := "Member Name";
                            ObjPackage."Lodged By(Custodian 1)" := "Lodged By(Custodian 1)";
                            ObjPackage."Lodged By(Custodian 2)" := "Lodged By(Custodian 2)";
                            ObjPackage."Date Lodged" := "Date Lodged";
                            ObjPackage."Time Lodged" := "Time Lodged";
                            ObjPackage.Insert;
                            Message('A Package has been created on Safe Custody Packages List# Package No%1', VarPackageNo);
                        end;
                    end;
                    //===========End Create A Package in Safe Custody Module=======================

                    /*//Update Lodge Details on Items
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
            action(RetrievePackage)
            {
                ApplicationArea = Basic;
                Caption = 'Retrieve Package';

                trigger OnAction()
                begin
                    if Action <> Action::"Booked to Safe Custody" then
                        Error('This is action is only applicable to Safe Custody booking');

                    if ("Lodged By(Custodian 1)" <> '') and ("Lodged By(Custodian 2)" <> '') then
                        Error('This Package has already been Retrieved');

                    ObjCustodians.Reset;
                    ObjCustodians.SetRange(ObjCustodians."User ID", UserId);
                    if ObjCustodians.FindSet = true then begin
                        if ("Released By(Custodian 1)" = '') and ("Released By(Custodian 2)" <> UserId) then begin
                            "Released By(Custodian 1)" := UserId
                        end else
                            if ("Released By(Custodian 2)" = '') and ("Released By(Custodian 1)" <> UserId) then begin
                                "Released By(Custodian 2)" := UserId
                            end else
                                Error('You are not authorized to Retrieve Packages')
                    end;

                    if ("Released By(Custodian 1)" <> '') and ("Released By(Custodian 2)" <> '') then begin
                        "Date Released from SafeCustody" := Today;
                        "Time Released from SafeCustody" := Time;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        FnGetVisibility();
        CalcFields("Last Collateral Action Entry");
        if ObjCollateralMovement.Get("Last Collateral Action Entry") then begin
            "Last Collateral Action" := ObjCollateralMovement."Current Location";
        end;
    end;

    var
        ObjCollateralDeprReg: Record "Collateral Depr Register";
        ObjCollateralDetails: Record "Loan Collateral Details";
        VarNoofYears: Integer;
        VarDepreciationValue: Decimal;
        ObjDepreciationRegister: Record "Collateral Depr Register";
        VarDepreciationNo: Integer;
        ObjDeprCollateralMaster: Record "Collateral Depr Register";
        VarCurrentNBV: Decimal;
        ReceivedAtHQVisible: Boolean;
        StrongRoomVisible: Boolean;
        LawyerVisible: Boolean;
        InsuranceAgentVisible: Boolean;
        BranchVisible: Boolean;
        IssuetoMemberVisible: Boolean;
        IssuetoAuctioneerVisible: Boolean;
        SafeCustodyVisible: Boolean;
        ObjCustodians: Record "Safe Custody Custodians";
        ObjVendors: Record Vendor;
        AvailableBal: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
        JTemplate: Code[20];
        JBatch: Code[20];
        DocNo: Code[20];
        GenSetup: Record "Sacco General Set-Up";
        LineNo: Integer;
        TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due ";
        AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor;
        BalAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        ObjPackageTypes: Record "Package Types";
        LodgeFee: Decimal;
        LodgeFeeAccount: Code[20];
        SurestepFactory: Codeunit "SURESTEP Factory.";
        ObjNoSeries: Record "Sacco No. Series";
        VarPackageNo: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjPackage: Record "Safe Custody Package Register";
        ObjCollateralMovement: Record "Collateral Movement Register";

    local procedure FnGetVisibility()
    begin
        ReceivedAtHQVisible := false;
        StrongRoomVisible := false;
        LawyerVisible := false;
        InsuranceAgentVisible := false;
        BranchVisible := false;
        IssuetoMemberVisible := false;
        IssuetoAuctioneerVisible := false;
        SafeCustodyVisible := false;


        if Action = Action::"Receive at HQ" then begin
            ReceivedAtHQVisible := true;
        end;
        if (Action = Action::"Dispatch to Branch") or (Action = Action::"Receive at Branch") then begin
            BranchVisible := true;
        end;
        if (Action = Action::"Issue to Lawyer") or (Action = Action::"Receive From Lawyer") then begin
            LawyerVisible := true;
        end;
        if Action = Action::"Issue to Auctioneer" then begin
            IssuetoAuctioneerVisible := true;
        end;
        if Action = Action::"Issue to Insurance Agent" then begin
            InsuranceAgentVisible := true;
        end;
        if Action = Action::"Release to Member" then begin
            IssuetoMemberVisible := true;
        end;
        if Action = Action::"Retrieve From Strong Room" then begin
            StrongRoomVisible := true;
        end;
        if Action = Action::"Booked to Safe Custody" then begin
            SafeCustodyVisible := true;
        end;
    end;
}

