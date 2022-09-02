#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516364 "Membership App Nominee Detail"
{
    PageType = List;
    SourceTable = "Member App Nominee";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Relationship;Relationship)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    ShowMandatory = true;
                }
                field("Next Of Kin Type";"Next Of Kin Type")
                {
                    ApplicationArea = Basic;
                    OptionCaption = 'Beneficiary,Nominee,Trustee';
                }
                field("Date of Birth";"Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Age;Age)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Address;Address)
                {
                    ApplicationArea = Basic;
                }
                field(Telephone;Telephone)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(Fax;Fax)
                {
                    ApplicationArea = Basic;
                }
                field(Email;Email)
                {
                    ApplicationArea = Basic;
                }
                field("ID No.";"ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("%Allocation";"%Allocation")
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

        MemberApp.Reset;
        MemberApp.SetRange(MemberApp."No.","Account No");
        if MemberApp.Find('-') then begin
         if MemberApp.Status=MemberApp.Status::Approved then begin                        //MESSAGE(FORMAT(MemberApp.Status));
          CurrPage.Editable:=false;
         end else
          CurrPage.Editable:=true;
        end;
        "Maximun Allocation %":=100;
    end;

    var
        MemberApp: Record "Membership Applications";
        ReltnShipTypeEditable: Boolean;
}

