#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516924 "Lead card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "General Equiries.";
    SourceTableView = where(Send = const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Equiring As"; "Calling As")
                {
                    ApplicationArea = Basic;
                    Caption = 'Equiring As';
                    OptionCaption = ',As Non Member,As Others>';
                }
                field("<Equiring For>"; "Calling For")
                {
                    ApplicationArea = Basic;
                    Caption = 'Log Type';
                }
                field("Contact Mode"; "Contact Mode")
                {
                    ApplicationArea = Basic;
                }
                field("Physical Meeting Location"; "Physical Meeting Location")
                {
                    ApplicationArea = Basic;
                }
                field("Lead Status"; "Lead Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Lead Region"; "Lead Region")
                {
                    ApplicationArea = Basic;
                }
                field("Captured By"; "Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Captured On"; "Captured On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Lead Details")
            {
                field("First Name"; "First Name")
                {
                    ApplicationArea = Basic;
                }
                field("Middle Name"; "Middle Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Middle Name';
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No"; "Phone No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No';
                }
                field(Email; Email)
                {
                    ApplicationArea = Basic;
                }
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                }
                field("Id Number"; "Passport No")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No';
                }
            }
            group("Employment Info")
            {
                Caption = 'Employment Info';
                field(Control16; "Employment Info")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        if "Employment Info" = "employment info"::Employed then begin
                            EmployerCodeEditable := true;
                            DepartmentEditable := true;
                            TermsofEmploymentEditable := true;
                            ContractingEditable := false;
                            EmployedEditable := false;
                            OccupationEditable := false;
                            PositionHeldEditable := true;
                            EmploymentDateEditable := true;
                            EmployerAddressEditable := true;
                            NatureofBussEditable := false;
                            IndustryEditable := false;
                            BusinessNameEditable := false;
                            PhysicalBussLocationEditable := false;
                            YearOfCommenceEditable := false;



                        end else
                            if "Employment Info" = "employment info"::Contracting then begin
                                ContractingEditable := true;
                                EmployerCodeEditable := false;
                                DepartmentEditable := false;
                                TermsofEmploymentEditable := false;
                                OccupationEditable := false;
                                PositionHeldEditable := false;
                                EmploymentDateEditable := false;
                                EmployerAddressEditable := false;
                                NatureofBussEditable := false;
                                IndustryEditable := false;
                                BusinessNameEditable := false;
                                PhysicalBussLocationEditable := false;
                                YearOfCommenceEditable := false;
                            end else
                                if "Employment Info" = "employment info"::Others then begin
                                    OthersEditable := true;
                                    ContractingEditable := false;
                                    EmployerCodeEditable := false;
                                    DepartmentEditable := false;
                                    TermsofEmploymentEditable := false;
                                    OccupationEditable := false;
                                    PositionHeldEditable := false;
                                    EmploymentDateEditable := false;
                                    EmployerAddressEditable := false
                                end else
                                    if "Employment Info" = "employment info"::"Self-Employed" then begin
                                        OccupationEditable := true;
                                        EmployerCodeEditable := false;
                                        DepartmentEditable := false;
                                        TermsofEmploymentEditable := false;
                                        ContractingEditable := false;
                                        EmployedEditable := false;
                                        NatureofBussEditable := true;
                                        IndustryEditable := true;
                                        BusinessNameEditable := true;
                                        PhysicalBussLocationEditable := true;
                                        YearOfCommenceEditable := true;
                                        PositionHeldEditable := false;
                                        EmploymentDateEditable := false;
                                        EmployerAddressEditable := false

                                    end;




                        /*IF "Identification Document"="Identification Document"::"Nation ID Card" THEN BEGIN
                          PassportEditable:=FALSE;
                          IDNoEditable:=TRUE
                          END ELSE
                          IF "Identification Document"="Identification Document"::"Passport Card" THEN BEGIN
                          PassportEditable:=TRUE;
                          IDNoEditable:=FALSE
                          END ELSE
                          IF "Identification Document"="Identification Document"::"Aliens Card" THEN BEGIN
                          PassportEditable:=TRUE;
                          IDNoEditable:=TRUE;
                        END;*/

                    end;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = EmployerCodeEditable;
                    ShowMandatory = true;
                }
                field("Employer Name"; "Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = EmployedEditable;
                }
                field("Employer Address"; "Employer Address")
                {
                    ApplicationArea = Basic;
                    Editable = EmployerAddressEditable;
                }
                field(Department; Department)
                {
                    ApplicationArea = Basic;
                    Caption = 'WorkStation / Depot';
                    Editable = DepartmentEditable;
                }
                field("Terms of Employment"; "Terms of Employment")
                {
                    ApplicationArea = Basic;
                    Editable = TermsofEmploymentEditable;
                    ShowMandatory = true;
                }
                field("Date of Employment"; "Date of Employment")
                {
                    ApplicationArea = Basic;
                    Editable = EmploymentDateEditable;
                }
                field("Position Held"; "Position Held")
                {
                    ApplicationArea = Basic;
                    Editable = PositionHeldEditable;
                }
                field("Expected Monthly Income"; "Expected Monthly Income")
                {
                    ApplicationArea = Basic;
                    Editable = MonthlyIncomeEditable;
                }
                field("Nature Of Business"; "Nature Of Business")
                {
                    ApplicationArea = Basic;
                    Editable = NatureofBussEditable;
                }
                field(Industry; Industry)
                {
                    ApplicationArea = Basic;
                    Editable = IndustryEditable;
                }
                field("Business Name"; "Business Name")
                {
                    ApplicationArea = Basic;
                    Editable = BusinessNameEditable;
                }
                field("Physical Business Location"; "Physical Business Location")
                {
                    ApplicationArea = Basic;
                    Editable = PhysicalBussLocationEditable;
                }
                field("Year of Commence"; "Year of Commence")
                {
                    ApplicationArea = Basic;
                    Editable = YearOfCommenceEditable;
                }
                field(Occupation; Occupation)
                {
                    ApplicationArea = Basic;
                    Editable = OccupationEditable;
                }
                field("Others Details"; "Others Details")
                {
                    ApplicationArea = Basic;
                    Editable = OthersEditable;
                }
            }
            group("Referee Details")
            {
                Caption = 'Referee Details';
                field("Referee Member No"; "Referee Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Referee Name"; "Referee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Referee ID No"; "Referee ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Referee Mobile Phone No"; "Referee Mobile Phone No")
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
            action("Detailed Member Page")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = New;
            }
            action("Create ")
            {
                ApplicationArea = Basic;
                Caption = 'Create Lead';
                Image = Change;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin



                    //ERROR("Calling As");
                    //IF ("Calling As"="Calling As"::"As Non Member")OR ("Calling As"="Calling As"::"As Others") THEN BEGIN
                    ok := Confirm('Create a lead  for ' + "First Name" + "Middle Name" + '.The lead will be allocated a new lead Number. Continue?');
                    if ok then begin
                        //Create Invest Account
                        if LeadSetup.Get then begin
                            LeadSetup.TestField(LeadSetup."Lead Nos");
                            LeadNo := NoSeriesMgt.GetNextNo(LeadSetup."Lead Nos", 0D, true);
                            if LeadNo <> '' then begin
                                LeadM.Init;
                                LeadM."No." := LeadNo;
                                LeadM."First Name" := "First Name";
                                LeadM."Middle Name" := "Middle Name";
                                LeadM.Surname := "Last Name";
                                LeadM."member no" := "Member No";
                                LeadM.Name := "Member Name";
                                LeadM.Address := Address;
                                LeadM.City := City;
                                LeadM."Phone No." := "Phone No";
                                LeadM."Company No." := "Company No";
                                LeadM."Company Name" := "Company Name";
                                LeadM.Name := "First Name" + ' ' + "Middle Name" + ' ' + ' ' + "Last Name";
                                LeadM.Type := "Calling As";
                                LeadM."ID No" := "ID No";
                                LeadM."Receive date" := Today;
                                LeadM."Receive Time" := Time;
                                LeadM."Received From" := UserId;
                                LeadM."Sent By" := UserId;
                                LeadM."Caller Reffered To" := "Caller Reffered To";
                                LeadM.Description := Description;
                                LeadM.status := LeadM.Status::Opportunity;
                                LeadM."Employment Info" := "Employment Info";
                                LeadM."Employer Code" := "Employer Code";
                                LeadM."Employer Name" := "Employer Name";
                                LeadM."Employer Address" := "Employer Address";
                                LeadM."Employer Type" := "Employer Type";
                                LeadM."Employment Terms" := "Employment Terms";
                                LeadM."Business Name" := "Business Name";
                                LeadM.Industry := Industry;
                                LeadM.Department := Department;
                                LeadM."Year of Commence" := "Year of Commence";
                                LeadM."Position Held" := "Position Held";
                                LeadM."Expected Monthly Income" := "Expected Monthly Income";
                                LeadM."Date of Employment" := "Date of Employment";
                                LeadM."Physical Business Location" := "Physical Business Location";
                                LeadM."Others Details" := "Others Details";
                                LeadM."Nature Of Business" := "Nature Of Business";
                                LeadM."Referee Member No" := "Referee Member No";
                                LeadM."Referee ID No" := "Referee ID No";
                                LeadM."Referee Name" := "Referee Name";
                                LeadM."Referee Mobile Phone No" := "Referee Mobile Phone No";
                                LeadM."Lead Status" := LeadM."lead status"::"Converted to Opportunity";
                                LeadM.Insert(true);
                                //Send:=TRUE;
                                LeadM.Converted := true;
                                Modify;
                                Message('Opportunity successfully generated');
                            end;
                        end;
                    end;

                    //categories lead
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        AsEmployer := false;
        Asmember := false;
        AsNonmember := false;
        Asother := false;
        Ascase := false;
        if "Calling As" = "calling as"::"As Member" then begin
            Asmember := true;
            AsEmployer := true;
            Ascase := true;
        end;
        if "Calling As" = "calling as"::"As Non Member" then begin
            AsNonmember := true;
            Asother := true;
        end;
        if "Calling As" = "calling as"::"As Employer" then begin
            AsEmployer := true;
            Asother := true;
            Ascase := true;
        end;

        if "Employment Info" = "employment info"::Employed then begin
            EmployerCodeEditable := true;
            DepartmentEditable := true;
            TermsofEmploymentEditable := true;
            ContractingEditable := false;
            EmployedEditable := false;
            OccupationEditable := false;
            PositionHeldEditable := true;
            EmploymentDateEditable := true;
            EmployerAddressEditable := true;
            NatureofBussEditable := false;
            IndustryEditable := false;
            BusinessNameEditable := false;
            PhysicalBussLocationEditable := false;
            YearOfCommenceEditable := false;



        end else
            if "Employment Info" = "employment info"::Contracting then begin
                ContractingEditable := true;
                EmployerCodeEditable := false;
                DepartmentEditable := false;
                TermsofEmploymentEditable := false;
                OccupationEditable := false;
                PositionHeldEditable := false;
                EmploymentDateEditable := false;
                EmployerAddressEditable := false;
                NatureofBussEditable := false;
                IndustryEditable := false;
                BusinessNameEditable := false;
                PhysicalBussLocationEditable := false;
                YearOfCommenceEditable := false;
            end else
                if "Employment Info" = "employment info"::Others then begin
                    OthersEditable := true;
                    ContractingEditable := false;
                    EmployerCodeEditable := false;
                    DepartmentEditable := false;
                    TermsofEmploymentEditable := false;
                    OccupationEditable := false;
                    PositionHeldEditable := false;
                    EmploymentDateEditable := false;
                    EmployerAddressEditable := false
                end else
                    if "Employment Info" = "employment info"::"Self-Employed" then begin
                        OccupationEditable := true;
                        EmployerCodeEditable := false;
                        DepartmentEditable := false;
                        TermsofEmploymentEditable := false;
                        ContractingEditable := false;
                        EmployedEditable := false;
                        NatureofBussEditable := true;
                        IndustryEditable := true;
                        BusinessNameEditable := true;
                        PhysicalBussLocationEditable := true;
                        YearOfCommenceEditable := true;
                        PositionHeldEditable := false;
                        EmploymentDateEditable := false;
                        EmployerAddressEditable := false

                    end;
    end;

    trigger OnOpenPage()
    begin
        AsEmployer := false;
        Asmember := false;
        AsNonmember := false;
        Asother := false;
        Ascase := false;

        if "Calling As" = "calling as"::"As Non Member" then begin
            AsNonmember := true;
            Asother := true;
        end;


        if "Employment Info" = "employment info"::Employed then begin
            EmployerCodeEditable := true;
            DepartmentEditable := true;
            TermsofEmploymentEditable := true;
            ContractingEditable := false;
            EmployedEditable := false;
            OccupationEditable := false;
            PositionHeldEditable := true;
            EmploymentDateEditable := true;
            EmployerAddressEditable := true;
            NatureofBussEditable := false;
            IndustryEditable := false;
            BusinessNameEditable := false;
            PhysicalBussLocationEditable := false;
            YearOfCommenceEditable := false;



        end else
            if "Employment Info" = "employment info"::Contracting then begin
                ContractingEditable := true;
                EmployerCodeEditable := false;
                DepartmentEditable := false;
                TermsofEmploymentEditable := false;
                OccupationEditable := false;
                PositionHeldEditable := false;
                EmploymentDateEditable := false;
                EmployerAddressEditable := false;
                NatureofBussEditable := false;
                IndustryEditable := false;
                BusinessNameEditable := false;
                PhysicalBussLocationEditable := false;
                YearOfCommenceEditable := false;
            end else
                if "Employment Info" = "employment info"::Others then begin
                    OthersEditable := true;
                    ContractingEditable := false;
                    EmployerCodeEditable := false;
                    DepartmentEditable := false;
                    TermsofEmploymentEditable := false;
                    OccupationEditable := false;
                    PositionHeldEditable := false;
                    EmploymentDateEditable := false;
                    EmployerAddressEditable := false
                end else
                    if "Employment Info" = "employment info"::"Self-Employed" then begin
                        OccupationEditable := true;
                        EmployerCodeEditable := false;
                        DepartmentEditable := false;
                        TermsofEmploymentEditable := false;
                        ContractingEditable := false;
                        EmployedEditable := false;
                        NatureofBussEditable := true;
                        IndustryEditable := true;
                        BusinessNameEditable := true;
                        PhysicalBussLocationEditable := true;
                        YearOfCommenceEditable := true;
                        PositionHeldEditable := false;
                        EmploymentDateEditable := false;
                        EmployerAddressEditable := false

                    end;
    end;

    var
        Cust: Record Customer;
        PvApp: Record "Cust. Ledger Entry";
        CustCare: Record "General Equiries.";
        CQuery: Record "General Equiries.";
        employer: Record "Sacco Employers";
        membApp: Record "Membership Applications";
        LeadM: Record "Lead Management";
        entry: Integer;
        vend: Record Vendor;
        CASEM: Record "Cases Management";
        AsEmployer: Boolean;
        Asmember: Boolean;
        AsNonmember: Boolean;
        Asother: Boolean;
        Ascase: Boolean;
        Leadacc: Record "Lead Management";
        LeadAcc2: Record "Lead Management";
        ok: Boolean;
        LeadSetup: Record "Crm General Setup.";
        LeadNo: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CaseNO: Code[20];
        CaseSetup: Record "Crm General Setup.";
        sure: Boolean;
        Yah: Boolean;
        EmploymentInfoEditable: Boolean;
        EmployedEditable: Boolean;
        ContractingEditable: Boolean;
        NatureofBussEditable: Boolean;
        IndustryEditable: Boolean;
        BusinessNameEditable: Boolean;
        PhysicalBussLocationEditable: Boolean;
        YearOfCommenceEditable: Boolean;
        PositionHeldEditable: Boolean;
        EmploymentDateEditable: Boolean;
        EmployerAddressEditable: Boolean;
        EmployerCodeEditable: Boolean;
        DepartmentEditable: Boolean;
        TermsofEmploymentEditable: Boolean;
        OccupationEditable: Boolean;
        OthersEditable: Boolean;
        MonthlyIncomeEditable: Boolean;
}

