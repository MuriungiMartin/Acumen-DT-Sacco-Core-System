#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516147 "Medical Claim Entries"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Medical Claim Entries";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No";"Entry No")
                {
                    ApplicationArea = Basic;
                }
                field("Document No.";"Document No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No";"Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name";"Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Claim Date";"Claim Date")
                {
                    ApplicationArea = Basic;
                }
                field("Hospital Visit Date";"Hospital Visit Date")
                {
                    ApplicationArea = Basic;
                }
                field("Claim Limit";"Claim Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Balance Claim Amount";"Balance Claim Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Claimed";"Amount Claimed")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Charged";"Amount Charged")
                {
                    ApplicationArea = Basic;
                }
                field(Comments;Comments)
                {
                    ApplicationArea = Basic;
                }
                field("USER ID";"USER ID")
                {
                    ApplicationArea = Basic;
                }
                field("Claim No";"Claim No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Posted";"Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Time Posted";"Time Posted")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
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

