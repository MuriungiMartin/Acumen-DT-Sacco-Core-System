#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516005 "Custom Workflow Responses"
{

    trigger OnRun()
    begin
    end;

    var
        WFEventHandler: Codeunit "Workflow Event Handling";
        SurestepWFEvents: Codeunit "Custom Workflow Events";
        WFResponseHandler: Codeunit "Workflow Response Handling";


    procedure AddResponsesToLib()
    begin
    end;


    procedure AddResponsePredecessors()
    begin

          //Payment Header
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendPaymentDocForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendPaymentDocForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendPaymentDocForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelPaymentApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelPaymentApprovalRequestCode);

          //Membership Application
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendMembershipApplicationForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendMembershipApplicationForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendMembershipApplicationForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelMembershipApplicationApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelMembershipApplicationApprovalRequestCode);
          //Loan Application
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendLoanApplicationForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendLoanApplicationForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendLoanApplicationForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelLoanApplicationApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelLoanApplicationApprovalRequestCode);

          //Loan Disbursement
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendLoanDisbursementForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendLoanDisbursementForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendLoanDisbursementForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelLoanDisbursementApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelLoanDisbursementApprovalRequestCode);



        //Standing Order
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendStandingOrderForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendStandingOrderForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendStandingOrderForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelStandingOrderApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelStandingOrderApprovalRequestCode);

        //Membership Withdrawal
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendMWithdrawalForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendMWithdrawalForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendMWithdrawalForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelMWithdrawalApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelMWithdrawalApprovalRequestCode);

        //ATM Card Application
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendATMCardForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendATMCardForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendATMCardForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelATMCardApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelATMCardApprovalRequestCode);

        //Guarantor Recovery
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendGuarantorRecoveryForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendGuarantorRecoveryForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendGuarantorRecoveryForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelGuarantorRecoveryApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelGuarantorRecoveryApprovalRequestCode);

        //Change Request
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendChangeRequestForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendChangeRequestForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendChangeRequestForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelChangeRequestApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelChangeRequestApprovalRequestCode);

        //Treasury Transactions
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendTTransactionsForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendTTransactionsForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendTTransactionsForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelTTransactionsApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelTTransactionsApprovalRequestCode);


         //FOSA Account Application
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendFAccountApplicationForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendFAccountApplicationForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendFAccountApplicationForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelFAccountApplicationApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelFAccountApplicationApprovalRequestCode);



        //Stores Requisition

          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendSReqApplicationForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendSReqApplicationForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendSReqApplicationForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelSReqApplicationApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelSReqApplicationApprovalRequestCode);

        //Sacco Transfer
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendSaccoTransferForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendSaccoTransferForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendSaccoTransferForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelSaccoTransferApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelSaccoTransferApprovalRequestCode);
        //Cheque Discounting
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendChequeDiscountingForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendChequeDiscountingForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendChequeDiscountingForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelChequeDiscountingApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelChequeDiscountingApprovalRequestCode);

        //Imprest Requisition
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendImprestRequisitionForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendImprestRequisitionForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendImprestRequisitionForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelImprestRequisitionApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelImprestRequisitionApprovalRequestCode);

        //Imprest Surrender
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendImprestSurrenderForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendImprestSurrenderForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendImprestSurrenderForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelImprestSurrenderApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelImprestSurrenderApprovalRequestCode);

        //Leave Application
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendLeaveApplicationForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendLeaveApplicationForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendLeaveApplicationForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelLeaveApplicationApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelLeaveApplicationApprovalRequestCode);
        //Bulk Withdrawal
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendBulkWithdrawalForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendBulkWithdrawalForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendBulkWithdrawalForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelBulkWithdrawalApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelBulkWithdrawalApprovalRequestCode);

        //Package Lodge
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendPackageLodgeForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendPackageLodgeForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendPackageLodgeForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelPackageLodgeApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelPackageLodgeApprovalRequestCode);

        //Package Retrieval
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendPackageRetrievalForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendPackageRetrievalForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendPackageRetrievalForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelPackageRetrievalApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelPackageRetrievalApprovalRequestCode);

        //House Change
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendHouseChangeForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendHouseChangeForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendHouseChangeForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelHouseChangeApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelHouseChangeApprovalRequestCode);

        //CRM Training
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendCRMTrainingForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendCRMTrainingForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendCRMTrainingForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelCRMTrainingApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelCRMTrainingApprovalRequestCode);

        //Petty Cash
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendPettyCashForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendPettyCashForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendPettyCashForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelPettyCashApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelPettyCashApprovalRequestCode);

        //Staff Claims
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendStaffClaimsForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendStaffClaimsForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendStaffClaimsForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelStaffClaimsApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelStaffClaimsApprovalRequestCode);

        //Member Agent/NOK Change
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequestCode);

        //House Registration
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendHouseRegistrationForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendHouseRegistrationForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendHouseRegistrationForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelHouseRegistrationApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelHouseRegistrationApprovalRequestCode);

        //Loan Payoff
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendLoanPayOffForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendLoanPayOffForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendLoanPayOffForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelLoanPayOffApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelLoanPayOffApprovalRequestCode);

        //Fixed Deposit
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendFixedDepositForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnSendFixedDepositForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                   SurestepWFEvents.RunWorkflowOnSendFixedDepositForApprovalCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelFixedDepositApprovalRequestCode);
          WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                   SurestepWFEvents.RunWorkflowOnCancelFixedDepositApprovalRequestCode);

        //-----------------------------End AddOn--------------------------------------------------------------------------------------
    end;


    procedure ReleasePaymentVoucher(var PaymentHeader: Record "Payments Header")
    var
        PHeader: Record "Payments Header";
    begin
        PHeader.Reset;
          PHeader.SetRange(PHeader."No.",PaymentHeader."No.");
          if PHeader.FindFirst then begin
            PHeader.Status:=PHeader.Status::Approved;
            PHeader.Modify;
          end;
    end;


    procedure ReOpenPaymentVoucher(var PaymentHeader: Record "Payments Header")
    var
        PHeader: Record "Payments Header";
    begin
          PHeader.Reset;
          PHeader.SetRange(PHeader."No.",PaymentHeader."No.");
          if PHeader.FindFirst then begin
            PHeader.Status:=PHeader.Status::Pending;
            PHeader.Modify;
          end;
    end;


    procedure ReleaseMembershipApplication(var MembershipApplication: Record "Membership Applications")
    var
        MembershipApp: Record "Membership Applications";
    begin

          MembershipApp.Reset;
          MembershipApp.SetRange(MembershipApp."No.",MembershipApplication."No.");
          if MembershipApp.FindFirst then begin
            MembershipApp.Status:=MembershipApp.Status::Approved;
            MembershipApp.Modify;
          end;
    end;


    procedure ReOpenMembershipApplication(var MemberApplication: Record "Membership Applications")
    var
        MembershipApp: Record "Membership Applications";
    begin
          MembershipApp.Reset;
          MembershipApp.SetRange(MembershipApp."No.",MemberApplication."No.");
          if MembershipApp.FindFirst then begin
            MembershipApp.Status:=MembershipApp.Status::Open;
            MembershipApp.Modify;
          end;
    end;


    procedure ReleaseLoanApplication(var LoanApplication: Record "Loans Register")
    var
        LoanB: Record "Loans Register";
    begin
          LoanB.Reset;
          LoanB.SetRange(LoanB."Loan  No.",LoanApplication."Loan  No.");
          if LoanB.FindFirst then begin
            LoanB."Loan Status":=LoanB."loan status"::Approved;
            LoanB."Approval Status":=LoanB."approval status"::Approved;
            LoanB.Modify;
          end;
    end;


    procedure ReOpenLoanApplication(var LoanApplication: Record "Loans Register")
    var
        LoanB: Record "Loans Register";
    begin
          LoanB.Reset;
          LoanB.SetRange(LoanB."Loan  No.",LoanApplication."Loan  No.");
          if LoanB.FindFirst then begin
            LoanB."Loan Status":=LoanB."loan status"::Application;
            LoanB."Approval Status":=LoanB."approval status"::Open;
            LoanB.Modify;
          end;
    end;


    procedure ReleaseLoanDisbursement(var LoanDisbursement: Record "Loan Disburesment-Batching")
    var
        LoanD: Record "Loan Disburesment-Batching";
    begin
          LoanD.Reset;
          LoanD.SetRange(LoanD."Batch No.",LoanDisbursement."Batch No.");
          if LoanD.FindFirst then begin
            LoanD.Status:=LoanD.Status::Approved;
            LoanD.Modify;
          end;
    end;


    procedure ReOpenLoanDisbursement(var LoanDisbursement: Record "Loan Disburesment-Batching")
    var
        LoanD: Record "Loan Disburesment-Batching";
    begin
          LoanD.Reset;
          LoanD.SetRange(LoanD."Batch No.",LoanDisbursement."Batch No.");
          if LoanD.FindFirst then begin
            LoanD.Status:=LoanD.Status::Open;
            LoanD.Modify;
          end;
    end;


    procedure ReleaseStandingOrder(var StandingOrder: Record "Standing Orders")
    var
        Sto: Record "Standing Orders";
    begin
          Sto.Reset;
          Sto.SetRange(Sto."No.",StandingOrder."No.");
          if Sto.FindFirst then begin
            Sto.Status:=Sto.Status::Approved;
            Sto.Modify;
          end;
    end;


    procedure ReOpenStandingOrder(var StandingOrder: Record "Standing Orders")
    var
        Sto: Record "Standing Orders";
    begin
          Sto.Reset;
          Sto.SetRange(Sto."No.",StandingOrder."No.");
          if Sto.FindFirst then begin
            Sto.Status:=Sto.Status::Open;
            Sto.Modify;
          end;
    end;


    procedure ReleaseMWithdrawal(var MWithdrawal: Record "Membership Exit")
    var
        Withdrawal: Record "Membership Exit";
    begin
          Withdrawal.Reset;
          Withdrawal.SetRange(Withdrawal."No.",MWithdrawal."No.");
          if Withdrawal.FindFirst then begin
            Withdrawal.Status:=Withdrawal.Status::Approved;
            Withdrawal.Modify;
          end;
    end;


    procedure ReOpenMWithdrawal(var MWithdrawal: Record "Membership Exit")
    var
        Withdrawal: Record "Membership Exit";
    begin
          Withdrawal.Reset;
          Withdrawal.SetRange(Withdrawal."No.",MWithdrawal."No.");
          if Withdrawal.FindFirst then begin
            Withdrawal.Status:=Withdrawal.Status::Open;
            Withdrawal.Modify;
          end;
    end;


    procedure ReleaseATMCard(var ATMCard: Record "ATM Card Applications")
    var
        ATM: Record "ATM Card Applications";
    begin
          ATMCard.Reset;
          ATMCard.SetRange(ATMCard."No.",ATMCard."No.");
          if ATMCard.FindFirst then begin
            ATMCard.Status:=ATMCard.Status::Approved;
            ATMCard.Modify;
          end;
    end;


    procedure ReOpenATMCard(var ATMCard: Record "ATM Card Applications")
    var
        ATM: Record "ATM Card Applications";
    begin
          ATMCard.Reset;
          ATMCard.SetRange(ATMCard."No.",ATMCard."No.");
          if ATMCard.FindFirst then begin
            ATMCard.Status:=ATMCard.Status::Open;
            ATMCard.Modify;
          end;
    end;


    procedure ReleaseGuarantorRecovery(var GuarantorRecovery: Record "Loan Recovery Header")
    var
        GuarantorR: Record "Loan Recovery Header";
    begin
          GuarantorRecovery.Reset;
          GuarantorRecovery.SetRange(GuarantorRecovery."Document No",GuarantorRecovery."Document No");
          if GuarantorRecovery.FindFirst then begin
            GuarantorRecovery.Status:=GuarantorRecovery.Status::Approved;
            GuarantorRecovery.Modify;
          end;
    end;


    procedure ReOpenGuarantorRecovery(var GuarantorRecovery: Record "Loan Recovery Header")
    var
        GuarantorR: Record "Loan Recovery Header";
    begin
          GuarantorRecovery.Reset;
          GuarantorRecovery.SetRange(GuarantorRecovery."Document No",GuarantorRecovery."Document No");
          if GuarantorRecovery.FindFirst then begin
            GuarantorRecovery.Status:=GuarantorRecovery.Status::Open;
            GuarantorRecovery.Modify;
          end;
    end;


    procedure ReleaseChangeRequest(var ChangeRequest: Record "Change Request")
    var
        ChReq: Record "Change Request";
    begin
          ChangeRequest.Reset;
          ChangeRequest.SetRange(ChangeRequest.No,ChangeRequest.No);
          if ChangeRequest.FindFirst then begin
            ChangeRequest.Status:=ChangeRequest.Status::Approved;
            ChangeRequest.Modify;
          end;
    end;


    procedure ReOpenChangeRequest(var ChangeRequest: Record "Change Request")
    var
        ChReq: Record "Change Request";
    begin
          ChangeRequest.Reset;
          ChangeRequest.SetRange(ChangeRequest.No,ChangeRequest.No);
          if ChangeRequest.FindFirst then begin
            ChangeRequest.Status:=ChangeRequest.Status::Open;
            ChangeRequest.Modify;
          end;
    end;


    procedure ReleaseTTransactions(var TTransactions: Record "Treasury Transactions")
    var
        TTrans: Record "Treasury Transactions";
    begin
          TTransactions.Reset;
          TTransactions.SetRange(TTransactions.No,TTransactions.No);
          if TTransactions.FindFirst then begin
            TTransactions.Status:=TTransactions.Status::Approved;
            TTransactions.Modify;
          end;
    end;


    procedure ReOpenTTransactions(var TTransactions: Record "Treasury Transactions")
    var
        TTrans: Record "Treasury Transactions";
    begin
          TTransactions.Reset;
          TTransactions.SetRange(TTransactions.No,TTransactions.No);
          if TTransactions.FindFirst then begin
            TTransactions.Status:=TTransactions.Status::Open;
            TTransactions.Modify;
          end;
    end;


    procedure ReleaseFAccount(var FAccount: Record "FOSA Account Applicat. Details")
    var
        FOSAACC: Record "FOSA Account Applicat. Details";
    begin
          FAccount.Reset;
          FAccount.SetRange(FAccount."No.",FAccount."No.");
          if FAccount.FindFirst then begin
            FAccount.Status:=FAccount.Status::Approved;
            FAccount.Modify;

            if FAccount.Get(FOSAACC."No.") then begin
              FAccount.Status:=FAccount.Status::Approved;
              FAccount.Modify;
              end;
          end;
    end;


    procedure ReOpenFAccount(var FAccount: Record "FOSA Account Applicat. Details")
    var
        FOSAACC: Record "FOSA Account Applicat. Details";
    begin
          FAccount.Reset;
          FAccount.SetRange(FAccount."No.",FAccount."No.");
          if FAccount.FindFirst then begin
            FAccount.Status:=FAccount.Status::Open;
            FAccount.Modify;
          end;
    end;


    procedure ReleaseSReq(var SReq: Record "Store Requistion Header P")
    var
        Stores: Record "Store Requistion Header P";
    begin
          SReq.Reset;
          SReq.SetRange(SReq."No.",SReq."No.");
          if SReq.FindFirst then begin
            SReq.Status:=SReq.Status::Released;
            SReq.Modify;

            if SReq.Get(Stores."No.") then begin
              SReq.Status:=SReq.Status::Released;
              SReq.Modify;
              end;
          end;
    end;


    procedure ReOpenSReq(var SReq: Record "Store Requistion Header P")
    var
        Stores: Record "Store Requistion Header P";
    begin
          SReq.Reset;
          SReq.SetRange(SReq."No.",SReq."No.");
          if SReq.FindFirst then begin
            SReq.Status:=SReq.Status::Open;
            SReq.Modify;
          end;
    end;


    procedure ReleaseSaccoTransfer(var SaccoTransfer: Record "Sacco Transfers")
    var
        STransfer: Record "Sacco Transfers";
    begin
          STransfer.Reset;
          STransfer.SetRange(STransfer.No,SaccoTransfer.No);
          if STransfer.FindFirst then begin
            STransfer.Status:=SaccoTransfer.Status::Approved;
            STransfer.Modify;
          end;
    end;


    procedure ReOpenSaccoTransfer(var SaccoTransfer: Record "Sacco Transfers")
    var
        STransfer: Record "Sacco Transfers";
    begin
          STransfer.Reset;
          STransfer.SetRange(STransfer.No,SaccoTransfer.No);
          if STransfer.FindFirst then begin
            STransfer.Status:=SaccoTransfer.Status::Open;
            STransfer.Modify;
          end;
    end;


    procedure ReleaseChequeDiscounting(var ChequeDiscounting: Record "Cheque Discounting")
    var
        CDiscounting: Record "Cheque Discounting";
    begin
          CDiscounting.Reset;
          CDiscounting.SetRange(CDiscounting."Transaction No",ChequeDiscounting."Transaction No");
          if CDiscounting.FindFirst then begin
            CDiscounting.Status:=ChequeDiscounting.Status::Approved;
            CDiscounting.Modify;
          end;
    end;


    procedure ReOpenChequeDiscounting(var ChequeDiscounting: Record "Cheque Discounting")
    var
        CDiscounting: Record "Cheque Discounting";
    begin
          CDiscounting.Reset;
          CDiscounting.SetRange(CDiscounting."Transaction No",ChequeDiscounting."Transaction No");
          if CDiscounting.FindFirst then begin
            CDiscounting.Status:=ChequeDiscounting.Status::Open;
            CDiscounting.Modify;
          end;
    end;


    procedure ReleaseImprestRequisition(var ImprestRequisition: Record "Imprest Header")
    var
        ImprestReq: Record "Imprest Header";
    begin
          ImprestReq.Reset;
          ImprestReq.SetRange(ImprestReq."No.",ImprestRequisition."No.");
          if ImprestReq.FindFirst then begin
            ImprestReq.Status:=ImprestRequisition.Status::Approved;
            ImprestReq.Modify;
          end;
    end;


    procedure ReOpenImprestRequisition(var ImprestRequisition: Record "Imprest Header")
    var
        ImprestReq: Record "Imprest Header";
    begin
          ImprestReq.Reset;
          ImprestReq.SetRange(ImprestReq."No.",ImprestRequisition."No.");
          if ImprestReq.FindFirst then begin
            ImprestReq.Status:=ImprestRequisition.Status::Open;
            ImprestReq.Modify;
          end;
    end;


    procedure ReleaseImprestSurrender(var ImprestSurrender: Record "Imprest Surrender Header")
    var
        ImprestSurr: Record "Imprest Surrender Header";
    begin
          ImprestSurr.Reset;
          ImprestSurr.SetRange(ImprestSurr.No,ImprestSurrender.No);
          if ImprestSurr.FindFirst then begin
            ImprestSurr.Status:=ImprestSurrender.Status::Approved;
            ImprestSurr.Modify;
          end;
    end;


    procedure ReOpenImprestSurrender(var ImprestSurrender: Record "Imprest Surrender Header")
    var
        ImprestSurr: Record "Imprest Surrender Header";
    begin
          ImprestSurr.Reset;
          ImprestSurr.SetRange(ImprestSurr.No,ImprestSurrender.No);
          if ImprestSurr.FindFirst then begin
            ImprestSurr.Status:=ImprestSurrender.Status::Open;
            ImprestSurr.Modify;
          end;
    end;


    procedure ReleaseLeaveApplication(var LeaveApplication: Record "HR Leave Application")
    var
        LeaveApp: Record "HR Leave Application";
    begin
          LeaveApp.Reset;
          LeaveApp.SetRange(LeaveApp."Application Code",LeaveApplication."Application Code");
          if LeaveApp.FindFirst then begin
            LeaveApp.Status:=LeaveApplication.Status::Approved;
            LeaveApp.Modify;
          end;
    end;


    procedure ReOpenLeaveApplication(LeaveApplication: Record "HR Leave Application")
    var
        LeaveApp: Record "HR Leave Application";
    begin
          LeaveApp.Reset;
          LeaveApp.SetRange(LeaveApp."Application Code",LeaveApplication."Application Code");
          if LeaveApp.FindFirst then begin
            LeaveApp.Status:=LeaveApplication.Status::New;
            LeaveApp.Modify;
          end;
    end;


    procedure ReleaseBulkWithdrawal(var BulkWithdrawal: Record "Bulk Withdrawal Application")
    var
        BulkWith: Record "Bulk Withdrawal Application";
    begin
          BulkWithdrawal.Reset;
          BulkWithdrawal.SetRange(BulkWithdrawal."Transaction No",BulkWithdrawal."Transaction No");
          if BulkWithdrawal.FindFirst then begin
            BulkWithdrawal.Status:=BulkWithdrawal.Status::Approved;
            BulkWithdrawal.Modify;
          end;
    end;


    procedure ReOpenBulkWithdrawal(var BulkWithdrawal: Record "Bulk Withdrawal Application")
    var
        BulkWith: Record "Bulk Withdrawal Application";
    begin
          BulkWithdrawal.Reset;
          BulkWithdrawal.SetRange(BulkWithdrawal."Transaction No",BulkWithdrawal."Transaction No");
          if BulkWithdrawal.FindFirst then begin
            BulkWithdrawal.Status:=BulkWithdrawal.Status::Open;
            BulkWithdrawal.Modify;
          end;
    end;


    procedure ReleasePackageLodge(var PackageLodge: Record "Safe Custody Package Register")
    var
        PLodge: Record "Safe Custody Package Register";
    begin
          PackageLodge.Reset;
          PackageLodge.SetRange(PackageLodge."Package ID",PackageLodge."Package ID");
          if PackageLodge.FindFirst then begin
            PackageLodge.Status:=PackageLodge.Status::Approved;
            PackageLodge.Modify;
          end;
    end;


    procedure ReOpenPackageLodge(var PackageLodge: Record "Safe Custody Package Register")
    var
        PLodge: Record "Safe Custody Package Register";
    begin
          PackageLodge.Reset;
          PackageLodge.SetRange(PackageLodge."Package ID",PackageLodge."Package ID");
          if PackageLodge.FindFirst then begin
            PackageLodge.Status:=PackageLodge.Status::Open;
            PackageLodge.Modify;
          end;
    end;


    procedure ReleasePackageRetrieval(var PackageRetrieval: Record "Package Retrieval Register")
    var
        PRetrieval: Record "Package Retrieval Register";
    begin
          PackageRetrieval.Reset;
          PackageRetrieval.SetRange(PackageRetrieval."Request No",PackageRetrieval."Request No");
          if PackageRetrieval.FindFirst then begin
            PackageRetrieval.Status:=PackageRetrieval.Status::Approved;
            PackageRetrieval.Modify;
          end;
    end;


    procedure ReOpenPackageRetrieval(var PackageRetrieval: Record "Package Retrieval Register")
    var
        PRetrieval: Record "Package Retrieval Register";
    begin
          PackageRetrieval.Reset;
          PackageRetrieval.SetRange(PackageRetrieval."Request No",PackageRetrieval."Request No");
          if PackageRetrieval.FindFirst then begin
            PackageRetrieval.Status:=PackageRetrieval.Status::Open;
            PackageRetrieval.Modify;
          end;
    end;


    procedure ReleaseHouseChange(var HouseChange: Record "House Group Change Request")
    var
        HChange: Record "House Group Change Request";
    begin
          HouseChange.Reset;
          HouseChange.SetRange(HouseChange."Document No",HouseChange."Document No");
          if HouseChange.FindFirst then begin
            HouseChange.Status:=HouseChange.Status::Approved;
            HouseChange.Modify;
          end;
    end;


    procedure ReOpenHouseChange(var HouseChange: Record "House Group Change Request")
    var
        HChange: Record "House Group Change Request";
    begin
          HouseChange.Reset;
          HouseChange.SetRange(HouseChange."Document No",HouseChange."Document No");
          if HouseChange.FindFirst then begin
            HouseChange.Status:=HouseChange.Status::Open;
            HouseChange.Modify;
          end;
    end;


    procedure ReleaseCRMTraining(var CRMTraining: Record "CRM Trainings")
    var
        CTraining: Record "CRM Trainings";
    begin
          CRMTraining.Reset;
          CRMTraining.SetRange(CRMTraining.Code,CRMTraining.Code);
          if CRMTraining.FindFirst then begin
            CRMTraining.Status:=CRMTraining.Status::Approved;
            CRMTraining.Modify;
          end;
    end;


    procedure ReOpenCRMTraining(var CRMTraining: Record "CRM Trainings")
    var
        CTraining: Record "CRM Trainings";
    begin
          CRMTraining.Reset;
          CRMTraining.SetRange(CRMTraining.Code,CRMTraining.Code);
          if CRMTraining.FindFirst then begin
            CRMTraining.Status:=CRMTraining.Status::Open;
            CRMTraining.Modify;
          end;
    end;


    procedure ReleasePettyCash(var PettyCash: Record "Payment Header.")
    var
        PettyC: Record "Payment Header.";
    begin
          PettyCash.Reset;
          PettyCash.SetRange(PettyCash."No.",PettyCash."No.");
          if PettyCash.FindFirst then begin
            PettyCash.Status:=PettyCash.Status::Approved;
            PettyCash.Modify;
          end;
    end;


    procedure ReOpenPettyCash(var PettyCash: Record "Payment Header.")
    var
        PettyC: Record "Payment Header.";
    begin
          PettyCash.Reset;
          PettyCash.SetRange(PettyCash."No.",PettyCash."No.");
          if PettyCash.FindFirst then begin
            PettyCash.Status:=PettyCash.Status::New;
            PettyCash.Modify;
          end;
    end;


    procedure ReleaseStaffClaims(var StaffClaims: Record "Staff Claims Header")
    var
        SClaims: Record "Staff Claims Header";
    begin
          StaffClaims.Reset;
          StaffClaims.SetRange(StaffClaims."No.",StaffClaims."No.");
          if StaffClaims.FindFirst then begin
            StaffClaims.Status:=StaffClaims.Status::Approved;
            StaffClaims.Modify;
          end;
    end;


    procedure ReOpenStaffClaims(var StaffClaims: Record "Staff Claims Header")
    var
        SClaims: Record "Staff Claims Header";
    begin
          StaffClaims.Reset;
          StaffClaims.SetRange(StaffClaims."No.",StaffClaims."No.");
          if StaffClaims.FindFirst then begin
            StaffClaims.Status:=StaffClaims.Status::"1st Approval";
            StaffClaims.Modify;
          end;
    end;


    procedure ReleaseMemberAgentNOKChange(var MemberAgentNOKChange: Record "Member Agent/Next Of Kin Chang")
    var
        MAgentNOKChange: Record "Member Agent/Next Of Kin Chang";
    begin
          MemberAgentNOKChange.Reset;
          MemberAgentNOKChange.SetRange(MemberAgentNOKChange."Document No",MemberAgentNOKChange."Document No");
          if MemberAgentNOKChange.FindFirst then begin
            MemberAgentNOKChange.Status:=MemberAgentNOKChange.Status::Approved;
            MemberAgentNOKChange.Modify;
          end;
    end;


    procedure ReOpenMemberAgentNOKChange(var MemberAgentNOKChange: Record "Member Agent/Next Of Kin Chang")
    var
        MAgentNOKChange: Record "Member Agent/Next Of Kin Chang";
    begin
          MemberAgentNOKChange.Reset;
          MemberAgentNOKChange.SetRange(MemberAgentNOKChange."Document No",MemberAgentNOKChange."Document No");
          if MemberAgentNOKChange.FindFirst then begin
            MemberAgentNOKChange.Status:=MemberAgentNOKChange.Status::Open;
            MemberAgentNOKChange.Modify;
          end;
    end;


    procedure ReleaseHouseRegistration(var HouseRegistration: Record "House Groups Registration")
    var
        HRegistration: Record "House Groups Registration";
    begin
          HouseRegistration.Reset;
          HouseRegistration.SetRange(HouseRegistration."Cell Group Code",HouseRegistration."Cell Group Code");
          if HouseRegistration.FindFirst then begin
            HouseRegistration.Status:=HouseRegistration.Status::Approved;
            HouseRegistration.Modify;
          end;
    end;


    procedure ReOpenHouseRegistration(var HouseRegistration: Record "House Groups Registration")
    var
        HRegistration: Record "House Groups Registration";
    begin
          HouseRegistration.Reset;
          HouseRegistration.SetRange(HouseRegistration."Cell Group Code",HouseRegistration."Cell Group Code");
          if HouseRegistration.FindFirst then begin
            HouseRegistration.Status:=HouseRegistration.Status::Open;
            HouseRegistration.Modify;
          end;
    end;


    procedure ReleaseLoanPayOff(var LoanPayOff: Record "Loan PayOff")
    var
        LPayOff: Record "Loan PayOff";
    begin
          LoanPayOff.Reset;
          LoanPayOff.SetRange(LoanPayOff."Document No",LoanPayOff."Document No");
          if LoanPayOff.FindFirst then begin
            LoanPayOff.Status:=LoanPayOff.Status::Approved;
            LoanPayOff.Modify;
          end;
    end;


    procedure ReOpenLoanPayOff(var LoanPayOff: Record "Loan PayOff")
    var
        LPayOff: Record "Loan PayOff";
    begin
          LoanPayOff.Reset;
          LoanPayOff.SetRange(LoanPayOff."Document No",LoanPayOff."Document No");
          if LoanPayOff.FindFirst then begin
            LoanPayOff.Status:=LoanPayOff.Status::Open;
            LoanPayOff.Modify;
          end;
    end;


    procedure ReleaseFixedDeposit(var FixedDeposit: Record "Fixed Deposit Placement")
    var
        FDeposit: Record "Fixed Deposit Placement";
    begin
          FixedDeposit.Reset;
          FixedDeposit.SetRange(FixedDeposit."Document No",FixedDeposit."Document No");
          if FixedDeposit.FindFirst then begin
            FixedDeposit.Status:=FixedDeposit.Status::Approved;
            FixedDeposit.Modify;
          end;
    end;


    procedure ReOpenFixedDeposit(var FixedDeposit: Record "Fixed Deposit Placement")
    var
        FDeposit: Record "Fixed Deposit Placement";
    begin
          FixedDeposit.Reset;
          FixedDeposit.SetRange(FixedDeposit."Document No",FixedDeposit."Document No");
          if FixedDeposit.FindFirst then begin
            FixedDeposit.Status:=FixedDeposit.Status::Open;
            FixedDeposit.Modify;
          end;
    end;


    procedure ReleasePR(var PRequest: Record "Purchase Header")
    begin
          PRequest.Reset;
          PRequest.SetRange(PRequest."No.",PRequest."No.");
          if PRequest.FindFirst then begin
            PRequest.Status:=PRequest.Status::Released;
            PRequest.Modify;

          end;
    end;


    procedure ReleaseTrunch(var Trunch: Record "Loan trunch Disburesment")
    var
        ObjTrunch: Record "Loan trunch Disburesment";
    begin
          ObjTrunch.Reset;
          ObjTrunch.SetRange(ObjTrunch."Document No",Trunch."Document No");
          if ObjTrunch.FindFirst then begin
            ObjTrunch.Status:=ObjTrunch.Status::Approved;
            ObjTrunch.Modify;
          end;
    end;


    procedure ReOpenTrunch(var Trunch: Record "Loan trunch Disburesment")
    var
        ObjTrunch: Record "Loan trunch Disburesment";
    begin
          ObjTrunch.Reset;
          ObjTrunch.SetRange(ObjTrunch."Document No",Trunch."Document No");
          if ObjTrunch.FindFirst then begin
            ObjTrunch.Status:=ObjTrunch.Status::Open;
            ObjTrunch.Modify;
          end;
    end;
}

