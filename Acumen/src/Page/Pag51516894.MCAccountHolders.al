#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516894 "MC Account Holders"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = Customer;
    SourceTableView = where("Customer Posting Group" = const('MICRO'),
                            "Global Dimension 1 Code" = const('MICRO'),
                            "BRID No" = const('NO'));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field("Old Account No."; "Old Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                }
                field("Address 2"; "Address 2")
                {
                    ApplicationArea = Basic;
                }
                field(City; City)
                {
                    ApplicationArea = Basic;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = Basic;
                }
                field(Blocked; Blocked)
                {
                    ApplicationArea = Basic;
                }
                field("Balance (LCY)"; "Balance (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                }
                field("Group Code"; "Group Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Personal Details")
            {
            }
            group(Communication)
            {
            }
        }
        area(factboxes)
        {
            part(Control1000000002; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("No.");
            }
            part(Control1000000001; "Member Picture-Uploaded")
            {
                Caption = 'Picture';
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                SubPageLink = "No." = field("No.");
            }
            part(Control1000000000; "Member Signature-Uploaded")
            {
                Caption = 'Signature';
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
    }

    var
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        CustomizedCalEntry: Record "Customized Calendar Entry";
        CustomizedCalendar: Record "Customized Calendar Change";
        PictureExists: Boolean;
        AccountTypes: Record "Account Types-Saving Products";
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        StatusPermissions: Record "Status Change Permision";
        Charges: Record "Loan Charges";
        ForfeitInterest: Boolean;
        InterestBuffer: Record "Payroll Posting Groups.";
        FDType: Record "Fixed Deposit Type";
        Vend: Record Vendor;
        Cust: Record Customer;
        LineNo: Integer;
        UsersID: Record User;
        DActivity: Code[20];
        DBranch: Code[20];
        MinBalance: Decimal;
        OBalance: Decimal;
        OInterest: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        TotalRecovered: Decimal;
        LoansR: Record "Loans Register";
        LoanAllocation: Decimal;
        LGurantors: Record "Loans Guarantee Details";
        Loans: Record "Loans Register";
        DefaulterType: Code[20];
        LastWithdrawalDate: Date;
        AccountType: Record "Account Types-Saving Products";
        ReplCharge: Decimal;
        Acc: Record Vendor;
}

