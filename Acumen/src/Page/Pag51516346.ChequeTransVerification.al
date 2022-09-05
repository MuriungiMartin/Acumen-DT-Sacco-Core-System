#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516346 "Cheque Trans Verification"
{
    CardPageID = "Cheque Truncation Card";
    Editable = false;
    PageType = List;
    SourceTable = "Cheque Issue Lines-Family";
    SourceTableView = where(dert = const(0));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(test; test)
                {
                    ApplicationArea = Basic;
                }
                // field("Cheque Serial No";"Cheque Serial No")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Account No.";"Account No.")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Account Name";"Account Name")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Date _Refference No.";"Date _Refference No.")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Transaction Code";"Transaction Code")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Branch Code";"Branch Code")
                // {
                //     ApplicationArea = Basic;
                // }
                // field(Amount;Amount)
                // {
                //     ApplicationArea = Basic;
                // }
                // field(dert;dert)
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Cheque No";"Cheque No")
                // {
                //     ApplicationArea = Basic;
                // }
                // field(FrontImage;FrontImage)
                // {
                //     ApplicationArea = Basic;
                // }
                // field(FrontGrayImage;FrontGrayImage)
                // {
                //     ApplicationArea = Basic;
                // }
                // field(BackImages;BackImages)
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Account Balance";"Account Balance")
                // {
                //     ApplicationArea = Basic;
                // }
            }
        }
    }

    actions
    {
    }
}

