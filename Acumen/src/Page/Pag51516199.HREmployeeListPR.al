#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516199 "HR Employee-List PR"
{
    Editable = false;
    PageType = List;
    SourceTable = "HR Employees";
    SourceTableView = sorting("No.")
                      order(ascending)
                      where(Status=filter(Active));

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
                field("First Name";"First Name")
                {
                    ApplicationArea = Basic;
                }
                field("Last Name";"Last Name")
                {
                    ApplicationArea = Basic;
                }
                field(Initials;Initials)
                {
                    ApplicationArea = Basic;
                }
                field("Length Of Service";"Length Of Service")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Join";"Date Of Join")
                {
                    ApplicationArea = Basic;
                }
                field("Search Name";"Search Name")
                {
                    ApplicationArea = Basic;
                }
                field("Postal Address";"Postal Address")
                {
                    ApplicationArea = Basic;
                }
                field("Postal Address2";"Postal Address2")
                {
                    ApplicationArea = Basic;
                }
                field("Postal Address3";"Postal Address3")
                {
                    ApplicationArea = Basic;
                }
                field("Post Code";"Post Code")
                {
                    ApplicationArea = Basic;
                }
                field("Residential Address";"Residential Address")
                {
                    ApplicationArea = Basic;
                }
                field("Residential Address2";"Residential Address2")
                {
                    ApplicationArea = Basic;
                }
                field("Residential Address3";"Residential Address3")
                {
                    ApplicationArea = Basic;
                }
                field("Post Code2";"Post Code2")
                {
                    ApplicationArea = Basic;
                }
                field(City;City)
                {
                    ApplicationArea = Basic;
                }
                field(County;County)
                {
                    ApplicationArea = Basic;
                }
                field("Home Phone Number";"Home Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field("Cellular Phone Number";"Cellular Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field("Work Phone Number";"Work Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field("Ext.";"Ext.")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail";"E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field("ID Number";"ID Number")
                {
                    ApplicationArea = Basic;
                }
                field("Union Code";"Union Code")
                {
                    ApplicationArea = Basic;
                }
                field("UIF Number";"UIF Number")
                {
                    ApplicationArea = Basic;
                }
                field(Gender;Gender)
                {
                    ApplicationArea = Basic;
                }
                field("Country Code";"Country Code")
                {
                    ApplicationArea = Basic;
                }
                field("Statistics Group Code";"Statistics Group Code")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field(Office;Office)
                {
                    ApplicationArea = Basic;
                }
                field("Resource No.";"Resource No.")
                {
                    ApplicationArea = Basic;
                }
                field(Comment;Comment)
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified";"Last Date Modified")
                {
                    ApplicationArea = Basic;
                }
                field("Fax Number";"Fax Number")
                {
                    ApplicationArea = Basic;
                }
                field("Company E-Mail";"Company E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field(Title;Title)
                {
                    ApplicationArea = Basic;
                }
                field("Salespers./Purch. Code";"Salespers./Purch. Code")
                {
                    ApplicationArea = Basic;
                }
                field("No. Series";"No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("Known As";"Known As")
                {
                    ApplicationArea = Basic;
                }
                field(Position;Position)
                {
                    ApplicationArea = Basic;
                }
                field("Full / Part Time";"Full / Part Time")
                {
                    ApplicationArea = Basic;
                }
                field("Contract Type";"Contract Type")
                {
                    ApplicationArea = Basic;
                }
                field("Contract End Date";"Contract End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Notice Period";"Notice Period")
                {
                    ApplicationArea = Basic;
                }
                field("Union Member?";"Union Member?")
                {
                    ApplicationArea = Basic;
                }
                field("Shift Worker?";"Shift Worker?")
                {
                    ApplicationArea = Basic;
                }
                field("Contracted Hours";"Contracted Hours")
                {
                    ApplicationArea = Basic;
                }
                field("Pay Period";"Pay Period")
                {
                    ApplicationArea = Basic;
                }
                field("Cost Code";"Cost Code")
                {
                    ApplicationArea = Basic;
                }
                field("UIF Contributor?";"UIF Contributor?")
                {
                    ApplicationArea = Basic;
                }
                field("Marital Status";"Marital Status")
                {
                    ApplicationArea = Basic;
                }
                field("Ethnic Origin";"Ethnic Origin")
                {
                    ApplicationArea = Basic;
                }
                field("First Language (R/W/S)";"First Language (R/W/S)")
                {
                    ApplicationArea = Basic;
                }
                field("Driving Licence";"Driving Licence")
                {
                    ApplicationArea = Basic;
                }
                field("Vehicle Registration Number";"Vehicle Registration Number")
                {
                    ApplicationArea = Basic;
                }
                field(Disabled;Disabled)
                {
                    ApplicationArea = Basic;
                }
                field("Health Assesment?";"Health Assesment?")
                {
                    ApplicationArea = Basic;
                }
                field("Health Assesment Date";"Health Assesment Date")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Birth";"Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Age;Age)
                {
                    ApplicationArea = Basic;
                }
                field("End Of Probation Date";"End Of Probation Date")
                {
                    ApplicationArea = Basic;
                }
                field("Pension Scheme Join";"Pension Scheme Join")
                {
                    ApplicationArea = Basic;
                }
                field("Time Pension Scheme";"Time Pension Scheme")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Scheme Join";"Medical Scheme Join")
                {
                    ApplicationArea = Basic;
                }
                field("Time Medical Scheme";"Time Medical Scheme")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Leaving";"Date Of Leaving")
                {
                    ApplicationArea = Basic;
                }
                field(Paterson;Paterson)
                {
                    ApplicationArea = Basic;
                }
                field(Peromnes;Peromnes)
                {
                    ApplicationArea = Basic;
                }
                field(Hay;Hay)
                {
                    ApplicationArea = Basic;
                }
                field(Castellion;Castellion)
                {
                    ApplicationArea = Basic;
                }
                field("Allow Overtime";"Allow Overtime")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Scheme No.";"Medical Scheme No.")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Scheme Head Member";"Medical Scheme Head Member")
                {
                    ApplicationArea = Basic;
                }
                field("Number Of Dependants";"Number Of Dependants")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Scheme Name";"Medical Scheme Name")
                {
                    ApplicationArea = Basic;
                }
                field("Receiving Car Allowance ?";"Receiving Car Allowance ?")
                {
                    ApplicationArea = Basic;
                }
                field("Second Language (R/W/S)";"Second Language (R/W/S)")
                {
                    ApplicationArea = Basic;
                }
                field("Additional Language";"Additional Language")
                {
                    ApplicationArea = Basic;
                }
                field("Cell Phone Reimbursement?";"Cell Phone Reimbursement?")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Reimbursed";"Amount Reimbursed")
                {
                    ApplicationArea = Basic;
                }
                field("UIF Country";"UIF Country")
                {
                    ApplicationArea = Basic;
                }
                field("Direct/Indirect";"Direct/Indirect")
                {
                    ApplicationArea = Basic;
                }
                field("Primary Skills Category";"Primary Skills Category")
                {
                    ApplicationArea = Basic;
                }
                field(Level;Level)
                {
                    ApplicationArea = Basic;
                }
                field("Termination Category";"Termination Category")
                {
                    ApplicationArea = Basic;
                }
                field("Job Specification";"Job Specification")
                {
                    ApplicationArea = Basic;
                }
                field(DateOfBirth;DateOfBirth)
                {
                    ApplicationArea = Basic;
                }
                field(DateEngaged;DateEngaged)
                {
                    ApplicationArea = Basic;
                }
                field(Citizenship;Citizenship)
                {
                    ApplicationArea = Basic;
                }
                field("Name Of Manager";"Name Of Manager")
                {
                    ApplicationArea = Basic;
                }
                field("User ID";"User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Disabling Details";"Disabling Details")
                {
                    ApplicationArea = Basic;
                }
                field("Disability Grade";"Disability Grade")
                {
                    ApplicationArea = Basic;
                }
                field("Passport Number";"Passport Number")
                {
                    ApplicationArea = Basic;
                }
                field("2nd Skills Category";"2nd Skills Category")
                {
                    ApplicationArea = Basic;
                }
                field("3rd Skills Category";"3rd Skills Category")
                {
                    ApplicationArea = Basic;
                }
                field(PensionJoin;PensionJoin)
                {
                    ApplicationArea = Basic;
                }
                field(DateLeaving;DateLeaving)
                {
                    ApplicationArea = Basic;
                }
                field(Region;Region)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        /*
        IF (DepCode <> '') THEN
           SETFILTER("Department Code", ' = %1', DepCode);
        IF (OfficeCode <> '') THEN
           SETFILTER(Office, ' = %1', OfficeCode);
             */

    end;

    var
        Mail: Codeunit Mail;
        PictureExists: Boolean;
        DepCode: Code[10];
        OfficeCode: Code[10];


    procedure SetNewFilter(var DepartmentCode: Code[10];var "Office Code": Code[10])
    begin
        DepCode := DepartmentCode;
        OfficeCode := "Office Code";
    end;
}

