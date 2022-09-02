#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516927 "Potential Opportunity Card"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "Lead Management";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("First Name";"First Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Surname;Surname)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Middle Name";"Middle Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field(Address;Address)
                {
                    ApplicationArea = Basic;
                }
                field(City;City)
                {
                    ApplicationArea = Basic;
                }
                field("Phone No.";"Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Lead Status";"Lead Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Employment Info")
            {
                Caption = 'Employment Info';
                field(Control21;"Employment Info")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        if "Employment Info"="employment info"::Employed then begin
                          EmployerCodeEditable:=true;
                          DepartmentEditable:=true;
                          TermsofEmploymentEditable:=true;
                          ContractingEditable:=false;
                          EmployedEditable:=false;
                          OccupationEditable:=false;
                          PositionHeldEditable:=true;
                          EmploymentDateEditable:=true;
                          EmployerAddressEditable:=true;
                          NatureofBussEditable:=false;
                          IndustryEditable:=false;
                          BusinessNameEditable:=false;
                          PhysicalBussLocationEditable:=false;
                          YearOfCommenceEditable:=false;
                        
                        
                        
                          end else
                          if "Employment Info"="employment info"::Contracting then begin
                          ContractingEditable:=true;
                          EmployerCodeEditable:=false;
                          DepartmentEditable:=false;
                          TermsofEmploymentEditable:=false;
                          OccupationEditable:=false;
                          PositionHeldEditable:=false;
                          EmploymentDateEditable:=false;
                          EmployerAddressEditable:=false;
                          NatureofBussEditable:=false;
                          IndustryEditable:=false;
                          BusinessNameEditable:=false;
                          PhysicalBussLocationEditable:=false;
                          YearOfCommenceEditable:=false;
                          end else
                          if "Employment Info"="employment info"::Others then begin
                          OthersEditable:=true;
                          ContractingEditable:=false;
                          EmployerCodeEditable:=false;
                          DepartmentEditable:=false;
                          TermsofEmploymentEditable:=false;
                          OccupationEditable:=false;
                          PositionHeldEditable:=false;
                          EmploymentDateEditable:=false;
                          EmployerAddressEditable:=false
                          end else
                          if "Employment Info"="employment info"::"Self-Employed" then begin
                          OccupationEditable:=true;
                          EmployerCodeEditable:=false;
                          DepartmentEditable:=false;
                          TermsofEmploymentEditable:=false;
                          ContractingEditable:=false;
                          EmployedEditable:=false;
                          NatureofBussEditable:=true;
                          IndustryEditable:=true;
                          BusinessNameEditable:=true;
                          PhysicalBussLocationEditable:=true;
                          YearOfCommenceEditable:=true;
                          PositionHeldEditable:=false;
                          EmploymentDateEditable:=false;
                          EmployerAddressEditable:=false
                        
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
                field("Employer Code";"Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = EmployerCodeEditable;
                    ShowMandatory = true;
                }
                field("Employer Name";"Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = EmployedEditable;
                }
                field("Employer Address";"Employer Address")
                {
                    ApplicationArea = Basic;
                    Editable = EmployerAddressEditable;
                }
                field(Department;Department)
                {
                    ApplicationArea = Basic;
                    Caption = 'WorkStation / Depot';
                    Editable = DepartmentEditable;
                }
                field("Terms of Employment";"Terms of Employment")
                {
                    ApplicationArea = Basic;
                    Editable = TermsofEmploymentEditable;
                    ShowMandatory = true;
                }
                field("Date of Employment";"Date of Employment")
                {
                    ApplicationArea = Basic;
                    Editable = EmploymentDateEditable;
                }
                field("Position Held";"Position Held")
                {
                    ApplicationArea = Basic;
                    Editable = PositionHeldEditable;
                }
                field("Expected Monthly Income";"Expected Monthly Income")
                {
                    ApplicationArea = Basic;
                    Editable = MonthlyIncomeEditable;
                }
                field("Nature Of Business";"Nature Of Business")
                {
                    ApplicationArea = Basic;
                    Editable = NatureofBussEditable;
                }
                field(Industry;Industry)
                {
                    ApplicationArea = Basic;
                    Editable = IndustryEditable;
                }
                field("Business Name";"Business Name")
                {
                    ApplicationArea = Basic;
                    Editable = BusinessNameEditable;
                }
                field("Physical Business Location";"Physical Business Location")
                {
                    ApplicationArea = Basic;
                    Editable = PhysicalBussLocationEditable;
                }
                field("Year of Commence";"Year of Commence")
                {
                    ApplicationArea = Basic;
                    Editable = YearOfCommenceEditable;
                }
                field(Occupation;Occupation)
                {
                    ApplicationArea = Basic;
                    Editable = OccupationEditable;
                }
                field("Others Details";"Others Details")
                {
                    ApplicationArea = Basic;
                    Editable = OthersEditable;
                }
            }
            group("Referee Details")
            {
                Caption = 'Referee Details';
                field("Referee Member No";"Referee Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Referee Name";"Referee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Referee ID No";"Referee ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Referee Mobile Phone No";"Referee Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group(Dates)
            {
                field("Date Filter";"Date Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Next Action Date";"Next Action Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Next Action Date';
                }
                field("Last Date Attempted";"Last Date Attempted")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Last Interaction";"Date of Last Interaction")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Opportunity details")
            {
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                }
                field("Lost Reasons";"Lost Reasons")
                {
                    ApplicationArea = Basic;
                }
                field("Company No.";"Company No.")
                {
                    ApplicationArea = Basic;
                }
                field("Company Name";"Company Name")
                {
                    ApplicationArea = Basic;
                }
                field("Job Title";"Job Title")
                {
                    ApplicationArea = Basic;
                }
                field("ID No";"ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Duration (Min.)";"Duration (Min.)")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Opportunities";"No. of Opportunities")
                {
                    ApplicationArea = Basic;
                }
                field(status;status)
                {
                    ApplicationArea = Basic;
                }
                field("Lead Type";"Lead Type")
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
            action("Create Opportunity")
            {
                ApplicationArea = Basic;
                Image = ChangeTo;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                      if Type=Type::Person then begin
                        MembApp.Init;
                        MembApp."No.":="No.";
                        MembApp."First Name":="First Name";
                        MembApp."Middle Name":="Middle Name";
                        MembApp."Last Name":=Surname;
                        MembApp.Name:="First Name"+' '+"Middle Name"+' '+Surname;
                        MembApp.Address:=Address;
                        MembApp."ID No.":="ID No";
                        MembApp."Customer Posting Group":='MEMBER';
                        MembApp."Customer Type":=MembApp."customer type"::Member;
                        MembApp.City:=City;
                        MembApp."Recruited By":=UserId;
                        MembApp."Registration Date":=Today;
                        MembApp."Employment Info":="Employment Info";
                        MembApp."Employer Code":="Employer Code";
                        MembApp."Employer Name":="Employer Name";
                        MembApp."Employer Type":="Employer Type";
                        //MembApp."Business Name":="Business Name";
                        MembApp."Employment Info":="Employment Info";
                        MembApp."Terms of Employment":="Terms of Employment";
                        //MembApp."Referee Member No":="Referee Member No";
                        //MembApp."Referee Name":="Referee Name";
                        //MembApp."Referee Mobile Phone No":="Referee Mobile Phone No";
                        //MembApp."Referee ID No":="Referee ID No";
                        MembApp.Insert(true);
                        Converted:=true;

                         Modify;
                        Message('Opportunity Members Successfully Generated');

                        end;
                        if Type=Type::Company then begin
                          Employer.Init;
                          Employer.Code:="Company No.";
                          Employer.Description:="Company Name";
                          Employer."Join Date":=Today;
                          Employer.Insert(true);
                          Converted:=true;
                          Modify;
                          Message('Opportunity Organizations Successfully Generated');
                      end;
                      // LOAN FORM
                end;
            }
            action("Meetings Schedule")
            {
                ApplicationArea = Basic;
                Image = FORM;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Meetings Schedule";
                RunPageLink = "Lead No"=field("No.");
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if "Employment Info"="employment info"::Employed then begin
          EmployerCodeEditable:=true;
          DepartmentEditable:=true;
          TermsofEmploymentEditable:=true;
          ContractingEditable:=false;
          EmployedEditable:=false;
          OccupationEditable:=false;
          PositionHeldEditable:=true;
          EmploymentDateEditable:=true;
          EmployerAddressEditable:=true;
          NatureofBussEditable:=false;
          IndustryEditable:=false;
          BusinessNameEditable:=false;
          PhysicalBussLocationEditable:=false;
          YearOfCommenceEditable:=false;



          end else
          if "Employment Info"="employment info"::Contracting then begin
          ContractingEditable:=true;
          EmployerCodeEditable:=false;
          DepartmentEditable:=false;
          TermsofEmploymentEditable:=false;
          OccupationEditable:=false;
          PositionHeldEditable:=false;
          EmploymentDateEditable:=false;
          EmployerAddressEditable:=false;
          NatureofBussEditable:=false;
          IndustryEditable:=false;
          BusinessNameEditable:=false;
          PhysicalBussLocationEditable:=false;
          YearOfCommenceEditable:=false;
          end else
          if "Employment Info"="employment info"::Others then begin
          OthersEditable:=true;
          ContractingEditable:=false;
          EmployerCodeEditable:=false;
          DepartmentEditable:=false;
          TermsofEmploymentEditable:=false;
          OccupationEditable:=false;
          PositionHeldEditable:=false;
          EmploymentDateEditable:=false;
          EmployerAddressEditable:=false
          end else
          if "Employment Info"="employment info"::"Self-Employed" then begin
          OccupationEditable:=true;
          EmployerCodeEditable:=false;
          DepartmentEditable:=false;
          TermsofEmploymentEditable:=false;
          ContractingEditable:=false;
          EmployedEditable:=false;
          NatureofBussEditable:=true;
          IndustryEditable:=true;
          BusinessNameEditable:=true;
          PhysicalBussLocationEditable:=true;
          YearOfCommenceEditable:=true;
          PositionHeldEditable:=false;
          EmploymentDateEditable:=false;
          EmployerAddressEditable:=false

        end;
    end;

    trigger OnOpenPage()
    begin
        if "Employment Info"="employment info"::Employed then begin
          EmployerCodeEditable:=true;
          DepartmentEditable:=true;
          TermsofEmploymentEditable:=true;
          ContractingEditable:=false;
          EmployedEditable:=false;
          OccupationEditable:=false;
          PositionHeldEditable:=true;
          EmploymentDateEditable:=true;
          EmployerAddressEditable:=true;
          NatureofBussEditable:=false;
          IndustryEditable:=false;
          BusinessNameEditable:=false;
          PhysicalBussLocationEditable:=false;
          YearOfCommenceEditable:=false;



          end else
          if "Employment Info"="employment info"::Contracting then begin
          ContractingEditable:=true;
          EmployerCodeEditable:=false;
          DepartmentEditable:=false;
          TermsofEmploymentEditable:=false;
          OccupationEditable:=false;
          PositionHeldEditable:=false;
          EmploymentDateEditable:=false;
          EmployerAddressEditable:=false;
          NatureofBussEditable:=false;
          IndustryEditable:=false;
          BusinessNameEditable:=false;
          PhysicalBussLocationEditable:=false;
          YearOfCommenceEditable:=false;
          end else
          if "Employment Info"="employment info"::Others then begin
          OthersEditable:=true;
          ContractingEditable:=false;
          EmployerCodeEditable:=false;
          DepartmentEditable:=false;
          TermsofEmploymentEditable:=false;
          OccupationEditable:=false;
          PositionHeldEditable:=false;
          EmploymentDateEditable:=false;
          EmployerAddressEditable:=false
          end else
          if "Employment Info"="employment info"::"Self-Employed" then begin
          OccupationEditable:=true;
          EmployerCodeEditable:=false;
          DepartmentEditable:=false;
          TermsofEmploymentEditable:=false;
          ContractingEditable:=false;
          EmployedEditable:=false;
          NatureofBussEditable:=true;
          IndustryEditable:=true;
          BusinessNameEditable:=true;
          PhysicalBussLocationEditable:=true;
          YearOfCommenceEditable:=true;
          PositionHeldEditable:=false;
          EmploymentDateEditable:=false;
          EmployerAddressEditable:=false

        end;
    end;

    var
        CustCare: Record "General Equiries.";
        CQuery: Record "General Equiries.";
        Employer: Record "Sacco Employers";
        MembApp: Record "Membership Applications";
        LeadM: Record "Lead Management";
        Entry: Integer;
        Vend: Record Vendor;
        CASEM: Record "Cases Management";
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

