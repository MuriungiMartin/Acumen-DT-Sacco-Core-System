#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516198 "HR Transport Requisition Pass"
{
    PageType = List;
    SourceTable = "HR Transport Allocations";
    SourceTableView = sorting("Allocation No","Requisition No");

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                field("Requisition No";"Requisition No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No";"Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Passenger/s Full Name/s";"Passenger/s Full Name/s")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(From;From)
                {
                    ApplicationArea = Basic;
                }
                field("To";"To")
                {
                    ApplicationArea = Basic;
                }
                field(Dept;Dept)
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

