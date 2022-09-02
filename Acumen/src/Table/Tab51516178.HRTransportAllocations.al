#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516178 "HR Transport Allocations"
{

    fields
    {
        field(1;"Allocation No";Code[20])
        {
        }
        field(2;"Employee No";Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                   if  HREmp.Get("Employee No") then begin
                     "Passenger/s Full Name/s":=HREmp.FullName;
                      Dept:=HREmp."Global Dimension 2 Code";
                   end;
            end;
        }
        field(3;"Passenger/s Full Name/s";Text[70])
        {
        }
        field(4;Dept;Text[70])
        {
        }
        field(5;"Requisition No";Code[10])
        {
            TableRelation = "HR Transport Requisition";

            trigger OnValidate()
            begin
                        HRTransportRequests.Reset;
                        HRTransportRequests.Get("Requisition No");
                        "Employee No":=HRTransportRequests."User ID";
                       // VALIDATE("Employee No");
                        From:=HRTransportRequests."From Destination";//HRTransportRequests."start date";
                        "To":=HRTransportRequests."To Destination";//HRTransportRequests.Status;

                        HRTransportRequests.Comment:=true;
                        HRTransportRequests.Modify;
            end;
        }
        field(6;From;Text[30])
        {
        }
        field(7;"To";Text[30])
        {
        }
    }

    keys
    {
        key(Key1;"Allocation No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HREmp: Record "HR Employees";
        HRTransportRequests: Record "HR Transport Requisition";
        HRTransportAllocationH: Record "HR Transport Allocations";
}

