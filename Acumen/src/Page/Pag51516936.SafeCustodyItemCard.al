#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516936 "Safe Custody Item Card"
{
    PageType = Card;
    SourceTable = "Safe Custody Item Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Item ID";"Item ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Item Description";"Item Description")
                {
                    ApplicationArea = Basic;
                    Editable = PageEditable;
                }
                field("Registered Owner";"Registered Owner")
                {
                    ApplicationArea = Basic;
                    Editable = PageEditable;
                }
                field("Document Reference";"Document Reference")
                {
                    ApplicationArea = Basic;
                    Editable = PageEditable;
                }
                field("Date Received";"Date Received")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Received By";"Received By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Lodged By(Custodian 1)";"Lodged By(Custodian 1)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Lodged By(Custodian 2)";"Lodged By(Custodian 2)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Lodged";"Date Lodged")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Released On";"Released On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Released By";"Released By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Collected";"Date Collected")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Collected By";"Collected By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Retrieved By(Custodian 1)";"Retrieved By(Custodian 1)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Retrieved By(Custodian 2)";"Retrieved By(Custodian 2)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Retrieved On";"Retrieved On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
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

