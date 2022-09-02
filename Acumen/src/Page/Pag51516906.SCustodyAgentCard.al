#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516906 "SCustody Agent Card"
{
    PageType = Card;
    SourceTable = "Safe Custody Agents Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Agent ID";"Agent ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Agent Member No";"Agent Member No")
                {
                    ApplicationArea = Basic;
                    Editable = PageEditable;
                }
                field("Agent Name";"Agent Name")
                {
                    ApplicationArea = Basic;
                    Editable = PageEditable;
                }
                field("Agent ID/Passport No";"Agent ID/Passport No")
                {
                    ApplicationArea = Basic;
                    Editable = PageEditable;
                }
                field("Agent Mobile No";"Agent Mobile No")
                {
                    ApplicationArea = Basic;
                    Editable = PageEditable;
                }
                field("Agent Postal Code";"Agent Postal Code")
                {
                    ApplicationArea = Basic;
                    Editable = PageEditable;
                }
                field("Agent Postal Address";"Agent Postal Address")
                {
                    ApplicationArea = Basic;
                    Editable = PageEditable;
                }
                field("Agent Physical Address";"Agent Physical Address")
                {
                    ApplicationArea = Basic;
                    Editable = PageEditable;
                }
                field("Access Instructions";"Access Instructions")
                {
                    ApplicationArea = Basic;
                    Editable = PageEditable;
                }
                field("Is Owner";"Is Owner")
                {
                    ApplicationArea = Basic;
                    Editable = PageEditable;
                }
                field("Created By";"Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Appointed";"Date Appointed")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Modified By";"Modified By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Modified On";"Modified On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Withdrawned By";"Withdrawned By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Withdrawned On";"Withdrawned On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Package Access Instructions")
            {
                Caption = 'Package Access Instructions';
                field("Collect Package/Item";"Collect Package/Item")
                {
                    ApplicationArea = Basic;
                    Editable = PageEditable;
                }
                field("Add Package/Item";"Add Package/Item")
                {
                    ApplicationArea = Basic;
                    Editable = PageEditable;
                }
                field("Make Copy of Package/Item";"Make Copy of Package/Item")
                {
                    ApplicationArea = Basic;
                    Editable = PageEditable;
                }
            }
        }
        area(factboxes)
        {
            part(Control15;"Custody Agent Picture")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "Agent ID"=field("Agent ID");
            }
            part(Control14;"Custody Agent Signature")
            {
                ApplicationArea = All;
                Caption = 'Signature';
                SubPageLink = "Agent ID"=field("Agent ID");
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        PageEditable:=true;

        if ObjPackageBooking.Get("Package ID") then begin
          if ObjPackageBooking.Status<>ObjPackageBooking.Status::Open then begin
            PageEditable:=false;
            end;
          end;
    end;

    trigger OnOpenPage()
    begin
        PageEditable:=true;

        if ObjPackageBooking.Get("Package ID") then begin
          if ObjPackageBooking.Status<>ObjPackageBooking.Status::Open then begin
            PageEditable:=false;
            end;
          end;
    end;

    var
        PageEditable: Boolean;
        ObjPackageBooking: Record "Safe Custody Package Register";
}

