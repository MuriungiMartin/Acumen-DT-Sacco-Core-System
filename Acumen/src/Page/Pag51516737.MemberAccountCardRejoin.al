#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516737 "Member Account Card Rejoin"
{
    Caption = 'Member Card';
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = Customer;
    SourceTableView = sorting("Employer Code")
                      where("Customer Type" = const(Member));

    layout
    {
        area(content)
        {
            group("General Info")
            {
                Caption = 'General Info';
                Editable = true;
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No.';
                    Editable = false;
                }
                field("Account Category"; "Account Category")
                {
                    ApplicationArea = Basic;
                }
                field("Joint Account Name"; "Joint Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Name';
                }
                field("Application No."; "Application No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Personal No"; "Personal No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No.';
                }
                field("FOSA Account No."; "FOSA Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Current Account';

                    trigger OnValidate()
                    begin
                        FosaName := '';

                        if "FOSA Account No." <> '' then begin
                            if Vend.Get("FOSA Account No.") then begin
                                FosaName := Vend.Name;
                            end;
                        end;
                    end;
                }
                field(FosaName; FosaName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Current Account Name';
                }
                field("Commission Paid"; "Commission Paid")
                {
                    ApplicationArea = Basic;
                }
                field(Commission; Commission)
                {
                    ApplicationArea = Basic;
                }
                field(County; County)
                {
                    ApplicationArea = Basic;
                }
                field("Members Parish"; "Members Parish")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Arch Dioces"; "Arch Dioces")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Dioces; Dioces)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Code/City';
                }
                field(City; City)
                {
                    ApplicationArea = Basic;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone No"; "Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Pension No"; "Pension No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Category"; "Member Category")
                {
                    ApplicationArea = Basic;
                }
                field("Identification Document"; "Identification Document")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID Number';
                    Editable = false;
                }
                field("Passport No."; "Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                }
                field(Pin; Pin)
                {
                    ApplicationArea = Basic;
                    Caption = 'KRA Pn';
                    Editable = false;
                    ShowMandatory = true;
                }
                field(txtMarital; "Marital Status")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                    Visible = txtMaritalVisible;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Disabled; Disabled)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Registration Date"; "Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Recruited By"; "Recruited By")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(rejoined; rejoined)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reactivated';
                    Editable = false;
                }
                field("Rejoining Date"; "Rejoining Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reactivation Date';
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        StatusPermissions.Reset;
                        StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                        StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Overide Defaulters");
                        if StatusPermissions.Find('-') = false then
                            Error('You do not have permissions to change the account status.');
                    end;
                }
                field(Picture; Piccture)
                {
                    ApplicationArea = Basic;
                }
                field(Signature; Signature)
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Customer Posting Group"; "Customer Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Blocked; Blocked)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Section; Section)
                {
                    ApplicationArea = Basic;
                    Caption = 'PERISH';
                    Visible = false;
                }
                field("Station/Section"; "Station/Section")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Last Payment Date"; "Last Payment Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Action On Dividend Earned"; "Action On Dividend Earned")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Member House Group"; "Member House Group")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Housel Group';
                    Editable = false;
                    Visible = false;
                }
                field("Member House Group Name"; "Member House Group Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member House Group Name';
                    Editable = false;
                    Visible = false;
                }
                field("Member Needs House Group"; "Member Needs House Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("No of House Group Changes"; "No of House Group Changes")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("House Group Status"; "House Group Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Employment Info")
            {
                Caption = 'Employment Info';
                field(Control1000000128; "Employment Info")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = false;

                    trigger OnValidate()
                    begin
                        /*IF "Employment Info"="Employment Info"::Employed THEN BEGIN
                          EmployerCodeEditable:=TRUE;
                          DepartmentEditable:=TRUE;
                          TermsofEmploymentEditable:=TRUE;
                          ContractingEditable:=FALSE;
                          EmployedEditable:=FALSE;
                          OccupationEditable:=FALSE;
                          PositionHeldEditable:=TRUE;
                          EmploymentDateEditable:=TRUE;
                          EmployerAddressEditable:=TRUE;
                          NatureofBussEditable:=FALSE;
                          IndustryEditable:=FALSE;
                          BusinessNameEditable:=FALSE;
                          PhysicalBussLocationEditable:=FALSE;
                          YearOfCommenceEditable:=FALSE;
                        
                        
                        
                          END ELSE
                          IF "Employment Info"="Employment Info"::Contracting THEN BEGIN
                          ContractingEditable:=TRUE;
                          EmployerCodeEditable:=FALSE;
                          DepartmentEditable:=FALSE;
                          TermsofEmploymentEditable:=FALSE;
                          OccupationEditable:=FALSE;
                          PositionHeldEditable:=FALSE;
                          EmploymentDateEditable:=FALSE;
                          EmployerAddressEditable:=FALSE;
                          NatureofBussEditable:=FALSE;
                          IndustryEditable:=FALSE;
                          BusinessNameEditable:=FALSE;
                          PhysicalBussLocationEditable:=FALSE;
                          YearOfCommenceEditable:=FALSE;
                          END ELSE
                          IF "Employment Info"="Employment Info"::Others THEN BEGIN
                          OthersEditable:=TRUE;
                          ContractingEditable:=FALSE;
                          EmployerCodeEditable:=FALSE;
                          DepartmentEditable:=FALSE;
                          TermsofEmploymentEditable:=FALSE;
                          OccupationEditable:=FALSE;
                          PositionHeldEditable:=FALSE;
                          EmploymentDateEditable:=FALSE;
                          EmployerAddressEditable:=FALSE
                          END ELSE
                          IF "Employment Info"="Employment Info"::"Self-Employed" THEN BEGIN
                          OccupationEditable:=TRUE;
                          EmployerCodeEditable:=FALSE;
                          DepartmentEditable:=FALSE;
                          TermsofEmploymentEditable:=FALSE;
                          ContractingEditable:=FALSE;
                          EmployedEditable:=FALSE;
                          NatureofBussEditable:=TRUE;
                          IndustryEditable:=TRUE;
                          BusinessNameEditable:=TRUE;
                          PhysicalBussLocationEditable:=TRUE;
                          YearOfCommenceEditable:=TRUE;
                          PositionHeldEditable:=FALSE;
                          EmploymentDateEditable:=FALSE;
                          EmployerAddressEditable:=FALSE
                        
                        END;
                        
                        
                        
                        
                        IF "Identification Document"="Identification Document"::"ID Card" THEN BEGIN
                          PassportEditable:=FALSE;
                          IDNoEditable:=TRUE
                          END ELSE
                          IF "Identification Document"="Identification Document"::Passport THEN BEGIN
                          PassportEditable:=TRUE;
                          IDNoEditable:=FALSE
                          END ELSE
                          IF "Identification Document"="Identification Document"::Both THEN BEGIN
                          PassportEditable:=TRUE;
                          IDNoEditable:=TRUE;
                        END;
                        */

                    end;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Employer Name"; "Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = false;
                }
                field("Station/Department"; "Station/Department")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Employer Address"; "Employer Address")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Department; Department)
                {
                    ApplicationArea = Basic;
                    Caption = 'WorkStation / Depot';
                    Editable = false;
                    Visible = false;
                }
                field("Terms Of Employment"; "Terms Of Employment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Date of Employment"; "Date of Employment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Position Held"; "Position Held")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Expected Monthly Income"; "Expected Monthly Income")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Nature Of Business"; "Nature Of Business")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Industry; Industry)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Business Name"; "Business Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Physical Business Location"; "Physical Business Location")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Year of Commence"; "Year of Commence")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Occupation; Occupation)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Others Details"; "Others Details")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Referee Details")
            {
                field("Referee Member No"; "Referee Member No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
            group("Member Risk Rating")
            {
                Editable = false;
                Visible = false;
                group("Member Risk Rate")
                {
                    field("Individual Category"; "Individual Category")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Member Residency Status"; "Member Residency Status")
                    {
                        ApplicationArea = Basic;
                    }
                    field(Entities; Entities)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Industry Type"; "Industry Type")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Lenght Of Relationship"; "Lenght Of Relationship")
                    {
                        ApplicationArea = Basic;
                    }
                    field("International Trade"; "International Trade")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group("Product Risk Rating")
                {
                    field("Electronic Payment"; "Electronic Payment")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Accounts Type Taken"; "Accounts Type Taken")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Cards Type Taken"; "Cards Type Taken")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Others(Channels)"; "Others(Channels)")
                    {
                        ApplicationArea = Basic;
                    }
                }
            }
            group(Joint2Details)
            {
                Caption = 'Joint2Details';
                Visible = Joint2DetailsVisible;
                field("Name 2"; "Name 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                }
                field(Address3; Address3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                    Editable = false;
                }
                field("Postal Code 2"; "Postal Code 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                    Editable = false;
                }
                field("Town 2"; "Town 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                    Editable = false;
                }
                field("Mobile No. Three"; "Mobile No. Three")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Date of Birth2"; "Date of Birth2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    Editable = false;
                }
                field("ID No.2"; "ID No.2")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Passport 2"; "Passport 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                    Editable = false;
                }
                field("Member Parish 2"; "Member Parish 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish';
                    Editable = false;
                    ShowMandatory = true;
                    Visible = false;
                }
                field("Member Parish Name 2"; "Member Parish Name 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish Name';
                    Editable = false;
                    Visible = false;
                }
                field(Gender2; Gender2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    Editable = false;
                }
                field("Marital Status2"; "Marital Status2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                    Editable = false;
                }
                field("Home Postal Code2"; "Home Postal Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                    Editable = false;
                }
                field("Home Town2"; "Home Town2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                    Editable = false;
                }
                field("Employer Code2"; "Employer Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                    Editable = false;
                }
                field("Employer Name2"; "Employer Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                    Editable = false;
                }
                field("E-Mail (Personal3)"; "E-Mail (Personal3)")
                {
                    ApplicationArea = Basic;
                    Caption = 'E-Mail (Personal)';
                    Editable = false;
                }
                field("Picture 2"; "Picture 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Picture';
                    Editable = false;
                }
                field("Signature  2"; "Signature  2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signature';
                    Editable = false;
                }
            }
            group(Joint3Details)
            {
                Visible = Joint3DetailsVisible;
                field("Name 3"; "Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                }
                field(Address4; Address4)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                    Editable = false;
                }
                field("Postal Code 3"; "Postal Code 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                    Editable = false;
                }
                field("Town 3"; "Town 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                    Editable = false;
                }
                field("Mobile No. 4"; "Mobile No. 4")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("ID No.3"; "ID No.3")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Passport 3"; "Passport 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                    Editable = false;
                }
                field("Member Parish 3"; "Member Parish 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish';
                    Editable = false;
                    ShowMandatory = true;
                    Visible = false;
                }
                field("Member Parish Name 3"; "Member Parish Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish Name';
                    Editable = false;
                    Visible = false;
                }
                field(Gender3; Gender3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    Editable = false;
                }
                field("Marital Status3"; "Marital Status3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                    Editable = false;
                }
                field("Home Postal Code3"; "Home Postal Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                    Editable = false;
                }
                field("Home Town3"; "Home Town3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                    Editable = false;
                }
                field("Employer Code3"; "Employer Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                    Editable = false;
                }
                field("Employer Name3"; "Employer Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                    Editable = false;
                }
                field("E-Mail (Personal2)"; "E-Mail (Personal2)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Picture 3"; "Picture 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Picture';
                    Editable = false;
                }
                field("Signature  3"; "Signature  3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signature';
                    Editable = false;
                }
                field("Retirement Date"; "Retirement Date")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Contact Info")
            {
                Caption = 'Contact Info';
                Editable = true;
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Email Indemnified"; "Email Indemnified")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Send E-Statements"; "Send E-Statements")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Home Page"; "Home Page")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Fax No."; "Fax No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Home Address"; "Home Address")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Home Postal Code"; "Home Postal Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(District; District)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Location; Location)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sub-Location"; "Sub-Location")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Village/Residence"; "Village/Residence")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Contact Person"; "Contact Person")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Contact Person Phone"; "Contact Person Phone")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("File Movement Tracker")
            {
                Caption = 'File Movement Tracker';
                field(Filelocc; Filelocc)
                {
                    ApplicationArea = Basic;
                    Caption = 'Current File Location';
                    Editable = false;
                }
                field("Loc Description"; "Loc Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Move to"; "Move to")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dispatch to:';
                }
                field("Move to description"; "Move to description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(User; User)
                {
                    ApplicationArea = Basic;
                }
                field("Folio Number"; "Folio Number")
                {
                    ApplicationArea = Basic;
                }
                field("File Movement Remarks"; "File Movement Remarks")
                {
                    ApplicationArea = Basic;
                }
                field("File MVT User ID"; "File MVT User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("File MVT Date"; "File MVT Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("File MVT Time"; "File MVT Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("file Received"; "file Received")
                {
                    ApplicationArea = Basic;
                    Caption = 'File Received';
                    Editable = false;
                }
                field("file received date"; "file received date")
                {
                    ApplicationArea = Basic;
                    Caption = 'File received date';
                    Editable = false;
                }
                field("File received Time"; "File received Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("File Received by"; "File Received by")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("No Of Days"; "No Of Days")
                {
                    ApplicationArea = Basic;
                    Caption = 'No of Days in Current Locaton';
                    Editable = false;
                }
                field("Reason for file overstay"; "Reason for file overstay")
                {
                    ApplicationArea = Basic;
                }
                field("File Movement Remarks1"; "File Movement Remarks1")
                {
                    ApplicationArea = Basic;
                    Caption = 'File MV General Remarks';
                }
            }
            group("Withdrawal Details")
            {
                Caption = 'Withdrawal Details';
                field("Withdrawal Application Date"; "Withdrawal Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Reason For Membership Withdraw"; "Reason For Membership Withdraw")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reason For Withdrawal';
                }
                field("Withdrawal Date"; "Withdrawal Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Withdrawal Fee"; "Withdrawal Fee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Status - Withdrawal App."; "Status - Withdrawal App.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Withdrawal Status';
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000052; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                SubPageLink = "No." = field("No.");
            }
            part(Control40; "Member Picture-Uploaded")
            {
                Caption = 'Picture';
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                SubPageLink = "No." = field("No.");
            }
            part(Control39; "Member Signature-Uploaded")
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
        area(navigation)
        {
            group("&Member")
            {
                Caption = '&Member';
                action("Member Ledger Entries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Ledger Entries';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedOnly = true;
                    RunObject = Page "Member Ledger Entries";
                    RunPageLink = "Customer No." = field("No.");
                    RunPageView = sorting("Customer No.");
                    Visible = false;
                }
            }
            group(ActionGroup1102755023)
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
                action("Account Signatories")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories Details';
                    Image = CustomerContact;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Member Account Signatory list";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Agent Details")
                {
                    ApplicationArea = Basic;
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Agent Account list";
                    RunPageLink = "Account No" = field("No.");
                }
                group("Issued Documents")
                {
                    Caption = 'Issued Documents';
                    Visible = false;
                }
                action("Re-Join")
                {
                    ApplicationArea = Basic;
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are You Sure You Want To Re-Join This Member?', true) then
                            /*/// EXIT;
                             GenJournalLine.RESET;
                             GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
                             GenJournalLine.SETRANGE("Journal Batch Name",'REJOINFEE');
                             GenJournalLine.DELETEALL;
                              GenSetUp.GET();

                              LineNo:=LineNo+10000;
                              GenJournalLine.INIT;
                              GenJournalLine."Journal Template Name":='GENERAL';
                              GenJournalLine."Journal Batch Name":='REJOINFEE';
                              GenJournalLine."Document No.":="No.";
                              GenJournalLine."Line No.":=LineNo;
                              GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                              GenJournalLine."Account No.":="No.";
                              GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                              GenJournalLine."Posting Date":=TODAY;
                              GenJournalLine."External Document No.":='RE-JOINFEE';///+FORMAT("Payroll No");
                              GenJournalLine.Description:='Membership Rejoining Fee';
                              GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Registration Fee";
                              GenJournalLine.Amount:=1500;///GenSetUp."Rejoining Fee";
                              GenJournalLine.VALIDATE(GenJournalLine.Amount);
                              GenJournalLine."Shortcut Dimension 1 Code":=GenJournalLine."Shortcut Dimension 1 Code";
                               GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                               GenJournalLine."Bal. Account No.":=GenSetUp."Rejoining Fees Account";
                             // GenJournalLine.VALIDATE(GenJournalLine."Bal. Account Type");
                              GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                              IF GenJournalLine.Amount<>0 THEN
                              GenJournalLine.INSERT;

                                GenJournalLine.RESET;
                                GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
                                GenJournalLine.SETRANGE("Journal Batch Name",'REJOINFEE');
                                IF GenJournalLine.FIND('-') THEN BEGIN
                                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco",GenJournalLine);
                                END;
                                */

                            Blocked := Blocked::" ";
                        Status := Status::Active;
                        "Withdrawal Posted" := false;
                        Modify;
                        Message('Successfully Rejoin');
                        CurrPage.Close;

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        FosaName := '';

        if "FOSA Account No." <> '' then begin
            if Vend.Get("FOSA Account No.") then begin
                FosaName := Vend.Name;
            end;
        end;

        lblIDVisible := true;
        lblDOBVisible := true;
        lblRegNoVisible := false;
        lblRegDateVisible := false;
        lblGenderVisible := true;
        txtGenderVisible := true;
        lblMaritalVisible := true;
        txtMaritalVisible := true;

        if "Account Category" <> "account category"::Single then begin
            lblIDVisible := false;
            lblDOBVisible := false;
            lblRegNoVisible := true;
            lblRegDateVisible := true;
            lblGenderVisible := false;
            txtGenderVisible := false;
            lblMaritalVisible := false;
            txtMaritalVisible := false;

        end;
        OnAfterGetCurrRecord;

        Statuschange.Reset;
        Statuschange.SetRange(Statuschange."User ID", UserId);
        Statuschange.SetRange(Statuschange."Function", Statuschange."function"::"Account Status");
        if not Statuschange.Find('-') then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;

        Joint2DetailsVisible := false;
        Joint3DetailsVisible := false;
        if "Account Category" <> "account category"::Joint then begin
            Joint2DetailsVisible := false;
        end else
            Joint2DetailsVisible := true;

        if "Account Category" <> "account category"::Joint then begin
            Joint3DetailsVisible := false;
        end else
            Joint3DetailsVisible := true;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        RecordFound: Boolean;
    begin
        RecordFound := Find(Which);
        CurrPage.Editable := RecordFound or (GetFilter("No.") = '');
        exit(RecordFound);
    end;

    trigger OnInit()
    begin
        txtMaritalVisible := true;
        lblMaritalVisible := true;
        txtGenderVisible := true;
        lblGenderVisible := true;
        lblRegDateVisible := true;
        lblRegNoVisible := true;
        lblDOBVisible := true;
        lblIDVisible := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Customer Type" := "customer type"::Member;
        Status := Status::Active;
        "Customer Posting Group" := 'BOSA';
        "Registration Date" := Today;
        Advice := true;
        "Advice Type" := "advice type"::"New Member";
        if GeneralSetup.Get(0) then begin
            "Welfare Contribution" := GeneralSetup."Welfare Contribution";
            "Registration Fee" := GeneralSetup."Registration Fee";

        end;
    end;

    trigger OnOpenPage()
    var
        MapMgt: Codeunit "Online Map Management";
    begin
        ActivateFields;
        /*
        IF NOT MapMgt.TestSetup THEN
          CurrForm.MapPoint.VISIBLE(FALSE);
        */

        Joint2DetailsVisible := false;
        Joint3DetailsVisible := false;

        if "Account Category" <> "account category"::Joint then begin
            Joint2DetailsVisible := false;
        end else
            Joint2DetailsVisible := true;

        if "Account Category" <> "account category"::Joint then begin
            Joint3DetailsVisible := false;
        end else
            Joint3DetailsVisible := true;


        if ("Assigned System ID" <> '') and ("Assigned System ID" <> UserId) then begin
            Error('You do not have permission to view account');
        end;

    end;

    var
        GenSetUp: Record "Sacco General Set-Up";
        CustomizedCalEntry: Record "Customized Calendar Entry";
        Text001: label 'Do you want to allow payment tolerance for entries that are currently open?';
        CustomizedCalendar: Record "Customized Calendar Change";
        Text002: label 'Do you want to remove payment tolerance from entries that are currently open?';
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        PictureExists: Boolean;
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        StatusPermissions: Record "Status Change Permision";
        Charges: Record Charges;
        Vend: Record Vendor;
        Cust: Record Customer;
        LineNo: Integer;
        UsersID: Record User;
        GeneralSetup: Record "Sacco General Set-Up";
        Loans: Record "Loans Register";
        AvailableShares: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        TotalRecovered: Decimal;
        LoanAllocation: Decimal;
        LGurantors: Record "Loans Guarantee Details";
        LoansR: Record "Loans Register";
        DActivity: Code[20];
        DBranch: Code[20];
        Accounts: Record Vendor;
        FosaName: Text[50];
        [InDataSet]
        lblIDVisible: Boolean;
        [InDataSet]
        lblDOBVisible: Boolean;
        [InDataSet]
        lblRegNoVisible: Boolean;
        [InDataSet]
        lblRegDateVisible: Boolean;
        [InDataSet]
        lblGenderVisible: Boolean;
        [InDataSet]
        txtGenderVisible: Boolean;
        [InDataSet]
        lblMaritalVisible: Boolean;
        [InDataSet]
        txtMaritalVisible: Boolean;
        AccNo: Code[20];
        Vendor: Record Vendor;
        TotalAvailable: Decimal;
        TotalFOSALoan: Decimal;
        TotalOustanding: Decimal;
        TotalDefaulterR: Decimal;
        value2: Decimal;
        Value1: Decimal;
        RoundingDiff: Decimal;
        Statuschange: Record "Status Change Permision";
        "WITHDRAWAL FEE": Decimal;
        "AMOUNTTO BE RECOVERED": Decimal;
        "Remaining Amount": Decimal;
        TotalInsuarance: Decimal;
        PrincipInt: Decimal;
        TotalLoansOut: Decimal;
        FileMovementTracker: Record "File Movement Tracker";
        EntryNo: Integer;
        ApprovalsSetup: Record "Approvals Set Up";
        MovementTracker: Record "Movement Tracker";
        ApprovalUsers: Record "Approvals Users Set Up";
        "Change Log": Integer;
        openf: File;
        FMTRACK: Record "File Movement Tracker";
        CurrLocation: Code[30];
        "Number of days": Integer;
        Approvals: Record "Approvals Set Up";
        Description: Text[30];
        Section: Code[10];
        station: Code[10];
        MoveStatus: Record "File Movement Status";
        Joint2DetailsVisible: Boolean;
        Joint3DetailsVisible: Boolean;
        GuarantorAllocationAmount: Decimal;
        CummulativeGuaranteeAmount: Decimal;
        UserSetup: Record "User Setup";
        JointNameVisible: Boolean;
        SurestepFactory: Codeunit "SURESTEP Factory.";
        ReasonforWithdrawal: Option Relocation,"Financial Constraints","House/Group Challages","Join another Institution","Personal Reasons",Other;
        SFactory: Codeunit "SURESTEP Factory.";
        ObjMembershipApp: Record "Membership Applications";
        OnlineUser: Record "Online Users";
        AdminPortal: Codeunit AdminPortal;
        CustMembr: Record Customer;


    procedure ActivateFields()
    begin
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        ActivateFields;
    end;
}

