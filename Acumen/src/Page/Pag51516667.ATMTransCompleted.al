#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516667 "ATM Trans Completed"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = ATMTransCompleted;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Id;Id)
                {
                    ApplicationArea = Basic;
                }
                field(serviceName;serviceName)
                {
                    ApplicationArea = Basic;
                }
                field(messageID;messageID)
                {
                    ApplicationArea = Basic;
                }
                field(OPTransactionDate;OPTransactionDate)
                {
                    ApplicationArea = Basic;
                }
                field(OPTerminalID;OPTerminalID)
                {
                    ApplicationArea = Basic;
                }
                field(OPChannel;OPChannel)
                {
                    ApplicationArea = Basic;
                }
                field(OPTransactionType;OPTransactionType)
                {
                    ApplicationArea = Basic;
                }
                field(OPOriginalMessageID;OPOriginalMessageID)
                {
                    ApplicationArea = Basic;
                }
                field(PostingDebitAccount;PostingDebitAccount)
                {
                    ApplicationArea = Basic;
                }
                field(PostingTotalAmount;PostingTotalAmount)
                {
                    ApplicationArea = Basic;
                }
                field(PostingCurrency;PostingCurrency)
                {
                    ApplicationArea = Basic;
                }
                field(PostingCreditAccount;PostingCreditAccount)
                {
                    ApplicationArea = Basic;
                }
                field(PostingChargeAmount;PostingChargeAmount)
                {
                    ApplicationArea = Basic;
                }
                field(PostingChargeCurrency;PostingChargeCurrency)
                {
                    ApplicationArea = Basic;
                }
                field(PostingFeeAmount;PostingFeeAmount)
                {
                    ApplicationArea = Basic;
                }
                field(PostingFeeCurrency;PostingFeeCurrency)
                {
                    ApplicationArea = Basic;
                }
                field(PostingNarrative;PostingNarrative)
                {
                    ApplicationArea = Basic;
                }
                field(PostingNarrative1;PostingNarrative1)
                {
                    ApplicationArea = Basic;
                }
                field(PostingNarrative2;PostingNarrative2)
                {
                    ApplicationArea = Basic;
                }
                field(InstitutionInstitutionCode;InstitutionInstitutionCode)
                {
                    ApplicationArea = Basic;
                }
                field(InstitutionInstitutionName;InstitutionInstitutionName)
                {
                    ApplicationArea = Basic;
                }
                field(AccountDebitAccount;AccountDebitAccount)
                {
                    ApplicationArea = Basic;
                }
                field(AccountCreditAccount;AccountCreditAccount)
                {
                    ApplicationArea = Basic;
                }
                field(PostedStatus;PostedStatus)
                {
                    ApplicationArea = Basic;
                }
                field(PostingComments;PostingComments)
                {
                    ApplicationArea = Basic;
                }
                field(SavingsAccountNumber;SavingsAccountNumber)
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

