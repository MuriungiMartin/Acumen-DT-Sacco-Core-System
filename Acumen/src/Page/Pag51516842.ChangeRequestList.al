#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516842 "Change Request List"
{
    ApplicationArea = Basic;
    CardPageID = "Change Request Card";
    Editable = false;
    PageType = List;
    SourceTable = "Change Request";
    SourceTableView = where(Changed=const(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No;No)
                {
                    ApplicationArea = Basic;
                }
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                }
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile No";"Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field("No. Series";"No. Series")
                {
                    ApplicationArea = Basic;
                }
                field(Address;Address)
                {
                    ApplicationArea = Basic;
                }
                field(Branch;Branch)
                {
                    ApplicationArea = Basic;
                }
                field(Picture;Picture)
                {
                    ApplicationArea = Basic;
                }
                field(signinature;signinature)
                {
                    ApplicationArea = Basic;
                }
                field(City;City)
                {
                    ApplicationArea = Basic;
                }
                field("E-mail";"E-mail")
                {
                    ApplicationArea = Basic;
                }
                field("Personal No";"Personal No")
                {
                    ApplicationArea = Basic;
                }
                field("ID No";"ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Marital Status";"Marital Status")
                {
                    ApplicationArea = Basic;
                }
                field("Passport No.";"Passport No.")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("Account Type";"Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account Category";"Account Category")
                {
                    ApplicationArea = Basic;
                }
                field(Email;Email)
                {
                    ApplicationArea = Basic;
                }
                field(Section;Section)
                {
                    ApplicationArea = Basic;
                }
                field("Card No";"Card No")
                {
                    ApplicationArea = Basic;
                }
                field("Home Address";"Home Address")
                {
                    ApplicationArea = Basic;
                }
                field(Loaction;Loaction)
                {
                    ApplicationArea = Basic;
                }
                field("Sub-Location";"Sub-Location")
                {
                    ApplicationArea = Basic;
                }
                field(District;District)
                {
                    ApplicationArea = Basic;
                }
                field("Reason for change";"Reason for change")
                {
                    ApplicationArea = Basic;
                }
                field("Signing Instructions";"Signing Instructions")
                {
                    ApplicationArea = Basic;
                }
                field("S-Mobile No";"S-Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Approve";"ATM Approve")
                {
                    ApplicationArea = Basic;
                }
                field("Card Expiry Date";"Card Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field("Card Valid From";"Card Valid From")
                {
                    ApplicationArea = Basic;
                }
                field("Card Valid To";"Card Valid To")
                {
                    ApplicationArea = Basic;
                }
                field("Date ATM Linked";"Date ATM Linked")
                {
                    ApplicationArea = Basic;
                }
                field("ATM No.";"ATM No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

