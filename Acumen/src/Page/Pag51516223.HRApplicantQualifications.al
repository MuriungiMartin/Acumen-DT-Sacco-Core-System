#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516223 "HR Applicant Qualifications"
{
    Caption = 'Applicant Qualifications';
    PageType = List;
    SaveValues = true;
    ShowFilter = true;
    SourceTable = "HR Applicant Qualifications";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Qualification Type";"Qualification Type")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Qualification Code";"Qualification Code")
                {
                    ApplicationArea = Basic;
                }
                field("Qualification Description";"Qualification Description")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("From Date";"From Date")
                {
                    ApplicationArea = Basic;
                }
                field("To Date";"To Date")
                {
                    ApplicationArea = Basic;
                }
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                }
                field("Institution/Company";"Institution/Company")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Score ID";"Score ID")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
            }
        }
    }

    actions
    {
    }
}

