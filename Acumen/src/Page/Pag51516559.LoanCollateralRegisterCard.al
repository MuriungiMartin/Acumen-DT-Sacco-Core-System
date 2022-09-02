#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516559 "Loan Collateral Register Card"
{
    PageType = Card;
    SourceTable = "Loan Collateral Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No";"Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No.";"Member No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";"Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("ID No.";"ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Type";"Collateral Type")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Description";"Collateral Description")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Posting Group";"Collateral Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Date Received";"Date Received")
                {
                    ApplicationArea = Basic;
                }
                field("Registered Owner";"Registered Owner")
                {
                    ApplicationArea = Basic;
                }
                field("Reference No";"Reference No")
                {
                    ApplicationArea = Basic;
                }
                field("Received By";"Received By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Released";"Date Released")
                {
                    ApplicationArea = Basic;
                }
                field("Released By";"Released By")
                {
                    ApplicationArea = Basic;
                }
                field(Picture;Picture)
                {
                    ApplicationArea = Basic;
                }
            }
            group("Insurance Details")
            {
                field("Insurance Effective Date";"Insurance Effective Date")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Expiration Date";"Insurance Expiration Date")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Policy No.";"Insurance Policy No.")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Annual Premium";"Insurance Annual Premium")
                {
                    ApplicationArea = Basic;
                }
                field("Policy Coverage";"Policy Coverage")
                {
                    ApplicationArea = Basic;
                }
                field("Total Value Insured";"Total Value Insured")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Type";"Insurance Type")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Vendor No.";"Insurance Vendor No.")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Depreciation Details")
            {
                field("Asset Value";"Asset Value")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Depreciation Completion Date";"Depreciation Completion Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expected Date of Loan Complition';
                    Editable = false;
                }
                field("Depreciation Percentage";"Depreciation Percentage")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Collateral Depreciation Method";"Collateral Depreciation Method")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Asset Depreciation Amount";"Asset Depreciation Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Asset Value @Loan Completion";"Asset Value @Loan Completion")
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

                    VarNoofYears:=ROUND(("Depreciation Completion Date"-Today)/365,1,'>');

                    //===========Update Year 1 Depreciation==================================
                    ObjCollateralDeprReg.Reset;
                    ObjCollateralDeprReg.SetRange(ObjCollateralDeprReg."Document No","Document No");
                    if ObjCollateralDeprReg.FindSet=false then begin
                      VarDepreciationValue:="Asset Value"*("Depreciation Percentage"/100);

                      ObjCollateralDeprReg.Init;
                      ObjCollateralDeprReg."Document No":="Document No";
                      ObjCollateralDeprReg."Transaction Date":=CalcDate('1Y',Today);
                      ObjCollateralDeprReg."Transaction Description":='Year 1 Depreciation';
                      ObjCollateralDeprReg."Depreciation Amount":=VarDepreciationValue;
                      ObjCollateralDeprReg."Collateral NBV":="Asset Value"-VarDepreciationValue;
                      ObjCollateralDeprReg.Insert;

                      end;
                    //=============End of Update Year 1 Depreciation==========================


                    //===========Update Year 2 Depreciation==================================

                            ObjCollateralDeprReg.Reset;
                            ObjCollateralDeprReg.SetRange(ObjCollateralDeprReg."Document No","Document No");
                            if ObjCollateralDeprReg.FindLast then begin
                              VarCurrentNBV:=ObjCollateralDeprReg."Collateral NBV";
                              VarDepreciationValue:=ObjCollateralDeprReg."Collateral NBV"*("Depreciation Percentage"/100);
                              end;

                              ObjDepreciationRegister.Reset;
                              ObjDepreciationRegister.SetRange(ObjDepreciationRegister."Document No","Document No");
                              if ObjDepreciationRegister.FindSet then begin
                                VarDepreciationNo:=ObjDepreciationRegister.Count+1;
                                end;

                              if (CalcDate('1Y',ObjCollateralDeprReg."Transaction Date"))<="Depreciation Completion Date" then begin
                                ObjCollateralDeprReg.Init;
                                ObjCollateralDeprReg."Document No":="Document No";
                                ObjCollateralDeprReg."Transaction Date":=CalcDate('1Y',ObjCollateralDeprReg."Transaction Date");
                                ObjCollateralDeprReg."Transaction Description":='Year '+ Format(VarDepreciationNo)+' Depreciation';
                                ObjCollateralDeprReg."Depreciation Amount":=VarDepreciationValue;
                                ObjCollateralDeprReg."Collateral NBV":=VarCurrentNBV-VarDepreciationValue;
                                ObjCollateralDeprReg.Insert;
                              end;
                    //=============End of Update Year 2 Depreciation==========================

                    //===========Update Year 3 Depreciation==================================

                            ObjCollateralDeprReg.Reset;
                            ObjCollateralDeprReg.SetRange(ObjCollateralDeprReg."Document No","Document No");
                            if ObjCollateralDeprReg.FindLast then begin
                              VarCurrentNBV:=ObjCollateralDeprReg."Collateral NBV";
                              VarDepreciationValue:=ObjCollateralDeprReg."Collateral NBV"*("Depreciation Percentage"/100);
                              end;

                              ObjDepreciationRegister.Reset;
                              ObjDepreciationRegister.SetRange(ObjDepreciationRegister."Document No","Document No");
                              if ObjDepreciationRegister.FindSet then begin
                                VarDepreciationNo:=ObjDepreciationRegister.Count+1;
                                end;
                            if (CalcDate('1Y',ObjCollateralDeprReg."Transaction Date"))<="Depreciation Completion Date" then begin
                              ObjCollateralDeprReg.Init;
                              ObjCollateralDeprReg."Document No":="Document No";
                              ObjCollateralDeprReg."Transaction Date":=CalcDate('1Y',ObjCollateralDeprReg."Transaction Date");
                              ObjCollateralDeprReg."Transaction Description":='Year '+ Format(VarDepreciationNo)+' Depreciation';
                              ObjCollateralDeprReg."Depreciation Amount":=VarDepreciationValue;
                              ObjCollateralDeprReg."Collateral NBV":=VarCurrentNBV-VarDepreciationValue;
                              ObjCollateralDeprReg.Insert;
                            end;
                    //=============End of Update Year 3 Depreciation==========================

                    //===========Update Year 4 Depreciation==================================

                            ObjCollateralDeprReg.Reset;
                            ObjCollateralDeprReg.SetRange(ObjCollateralDeprReg."Document No","Document No");
                            if ObjCollateralDeprReg.FindLast then begin
                              VarCurrentNBV:=ObjCollateralDeprReg."Collateral NBV";
                              VarDepreciationValue:=ObjCollateralDeprReg."Collateral NBV"*("Depreciation Percentage"/100);
                              end;

                              ObjDepreciationRegister.Reset;
                              ObjDepreciationRegister.SetRange(ObjDepreciationRegister."Document No","Document No");
                              if ObjDepreciationRegister.FindSet then begin
                                VarDepreciationNo:=ObjDepreciationRegister.Count+1;
                                end;
                            if (CalcDate('1Y',ObjCollateralDeprReg."Transaction Date"))<="Depreciation Completion Date" then begin
                              ObjCollateralDeprReg.Init;
                              ObjCollateralDeprReg."Document No":="Document No";
                              ObjCollateralDeprReg."Transaction Date":=CalcDate('1Y',ObjCollateralDeprReg."Transaction Date");
                              ObjCollateralDeprReg."Transaction Description":='Year '+ Format(VarDepreciationNo)+' Depreciation';
                              ObjCollateralDeprReg."Depreciation Amount":=VarDepreciationValue;
                              ObjCollateralDeprReg."Collateral NBV":=VarCurrentNBV-VarDepreciationValue;
                              ObjCollateralDeprReg.Insert;
                            end;
                    //=============End of Update Year 4 Depreciation==========================

                    //===========Update Year 5 Depreciation==================================

                            ObjCollateralDeprReg.Reset;
                            ObjCollateralDeprReg.SetRange(ObjCollateralDeprReg."Document No","Document No");
                            if ObjCollateralDeprReg.FindLast then begin
                              VarCurrentNBV:=ObjCollateralDeprReg."Collateral NBV";
                              VarDepreciationValue:=ObjCollateralDeprReg."Collateral NBV"*("Depreciation Percentage"/100);
                              end;

                              ObjDepreciationRegister.Reset;
                              ObjDepreciationRegister.SetRange(ObjDepreciationRegister."Document No","Document No");
                              if ObjDepreciationRegister.FindSet then begin
                                VarDepreciationNo:=ObjDepreciationRegister.Count+1;
                                end;
                            if (CalcDate('1Y',ObjCollateralDeprReg."Transaction Date"))<="Depreciation Completion Date" then begin
                              ObjCollateralDeprReg.Init;
                              ObjCollateralDeprReg."Document No":="Document No";
                              ObjCollateralDeprReg."Transaction Date":=CalcDate('1Y',ObjCollateralDeprReg."Transaction Date");
                              ObjCollateralDeprReg."Transaction Description":='Year '+ Format(VarDepreciationNo)+' Depreciation';
                              ObjCollateralDeprReg."Depreciation Amount":=VarDepreciationValue;
                              ObjCollateralDeprReg."Collateral NBV":=VarCurrentNBV-VarDepreciationValue;
                              ObjCollateralDeprReg.Insert;
                            end;
                    //=============End of Update Year 5 Depreciation==========================

                    //===========Update Year 6 Depreciation==================================

                            ObjCollateralDeprReg.Reset;
                            ObjCollateralDeprReg.SetRange(ObjCollateralDeprReg."Document No","Document No");
                            if ObjCollateralDeprReg.FindLast then begin
                              VarCurrentNBV:=ObjCollateralDeprReg."Collateral NBV";
                              VarDepreciationValue:=ObjCollateralDeprReg."Collateral NBV"*("Depreciation Percentage"/100);
                              end;

                              ObjDepreciationRegister.Reset;
                              ObjDepreciationRegister.SetRange(ObjDepreciationRegister."Document No","Document No");
                              if ObjDepreciationRegister.FindSet then begin
                                VarDepreciationNo:=ObjDepreciationRegister.Count+1;
                                end;
                            if (CalcDate('1Y',ObjCollateralDeprReg."Transaction Date"))<="Depreciation Completion Date" then begin
                              ObjCollateralDeprReg.Init;
                              ObjCollateralDeprReg."Document No":="Document No";
                              ObjCollateralDeprReg."Transaction Date":=CalcDate('1Y',ObjCollateralDeprReg."Transaction Date");
                              ObjCollateralDeprReg."Transaction Description":='Year '+ Format(VarDepreciationNo)+' Depreciation';
                              ObjCollateralDeprReg."Depreciation Amount":=VarDepreciationValue;
                              ObjCollateralDeprReg."Collateral NBV":=VarCurrentNBV-VarDepreciationValue;
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
                RunPageLink = "Document No"=field("Document No");
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        FnGetVisibility();
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

    local procedure FnGetVisibility()
    begin
        if Action=Action::"Receive at HQ" then begin
          ReceivedAtHQVisible:=true;
          end;
          if (Action=Action::"Dispatch to Branch") or (Action=Action::"Receive at Branch") then begin
            BranchVisible:=true;
            end;
            if (Action=Action::"Issue to Lawyer") or (Action=Action::"Receive From Lawyer") then begin
              LawyerVisible:=true;
              end;
              if Action=Action::"Issue to Auctioneer" then begin
                IssuetoAuctioneerVisible:=true;
                end;
                if Action=Action::"Issue to Insurance Agent" then begin
                  InsuranceAgentVisible:=true;
                  end;
                  if Action=Action::"Release to Member" then begin
                    IssuetoMemberVisible:=true;
                    end;
                    if Action=Action::"Retrieve From Strong Room" then begin
                      SafeCustodyVisible:=true;
                      end;
    end;
}

