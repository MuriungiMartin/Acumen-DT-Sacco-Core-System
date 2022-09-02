#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516670 "Members Nominee Details Temp"
{
    PageType = ListPart;
    SourceTable = "Members Nominee Temp";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Add New";"Add New")
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field("ID No.";"ID No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID No.(New)";"ID No.(New)")
                {
                    ApplicationArea = Basic;
                }
                field(Address;Address)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Address(New)";"Address(New)")
                {
                    ApplicationArea = Basic;
                }
                field(Relationship;Relationship)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Relationship(New)";"Relationship(New)")
                {
                    ApplicationArea = Basic;
                }
                field("%Allocation";"%Allocation")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("%Allocation(New)";"%Allocation(New)")
                {
                    ApplicationArea = Basic;
                }
                field("Next Of Kin Type";"Next Of Kin Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Next Of Kin Type(New)";"Next Of Kin Type(New)")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Birth";"Date of Birth")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date of Birth(New)";"Date of Birth(New)")
                {
                    ApplicationArea = Basic;
                }
                field(Telephone;Telephone)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Telephone(New)";"Telephone(New)")
                {
                    ApplicationArea = Basic;
                }
                field(Email;Email)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Email(New)";"Email(New)")
                {
                    ApplicationArea = Basic;
                }
                field("Total Allocation";"Total Allocation")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Allocation(New)";"Total Allocation(New)")
                {
                    ApplicationArea = Basic;
                }
                field(Remove;Remove)
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
        if Name='' then
          NewEdittable:=true;
        if "Add New"=true then
          Nameedittable:=true;
    end;

    var
        NewEdittable: Boolean;
        Nameedittable: Boolean;
}

