#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516179 "HR Employee Kin SF"
{
    Caption = 'HR Employee Kin & Beneficiaries';
    PageType = List;
    SourceTable = "HR Employee Kin";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                }
                field(Relationship;Relationship)
                {
                    ApplicationArea = Basic;
                }
                field(SurName;SurName)
                {
                    ApplicationArea = Basic;
                }
                field("Other Names";"Other Names")
                {
                    ApplicationArea = Basic;
                }
                field("ID No/Passport No";"ID No/Passport No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Birth";"Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Occupation;Occupation)
                {
                    ApplicationArea = Basic;
                }
                field(Address;Address)
                {
                    ApplicationArea = Basic;
                }
                field("E-mail";"E-mail")
                {
                    ApplicationArea = Basic;
                }
                field("Office Tel No";"Office Tel No")
                {
                    ApplicationArea = Basic;
                }
                field("Home Tel No";"Home Tel No")
                {
                    ApplicationArea = Basic;
                }
                field(Comment;Comment)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Next of Kin")
            {
                Caption = '&Next of Kin';
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name"=const("Employee Relative"),
                                  "No."=field("Employee Code"),
                                  "Table Line No."=field("Line No.");
                }
            }
        }
    }

    var
        D: Date;
}

