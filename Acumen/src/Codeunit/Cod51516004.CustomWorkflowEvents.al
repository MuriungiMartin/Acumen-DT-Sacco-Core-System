#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516004 "Custom Workflow Events"
{

    trigger OnRun()
    begin
    end;

    var
        WFHandler: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";


    procedure AddEventsToLib()
    begin

        //---------------------------------------------1. Approval Events--------------------------------------------------------------
          //Payment Header
          WFHandler.AddEventToLibrary(RunWorkflowOnSendPaymentDocForApprovalCode,
                                      Database::"Payments Header",'Approval of a Payment Document is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelPaymentApprovalRequestCode,
                                      Database::"Payments Header",'An Approval request for a Payment Document is Canceled.',0,false);

          //Membership Application
          WFHandler.AddEventToLibrary(RunWorkflowOnSendMembershipApplicationForApprovalCode,
                                      Database::"Membership Applications",'Approval of Membership Application is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelMembershipApplicationApprovalRequestCode,
                                      Database::"Membership Applications",'An Approval request for  Membership Application is canceled.',0,false);
          //Loan Application
          WFHandler.AddEventToLibrary(RunWorkflowOnSendLoanApplicationForApprovalCode,
                                      Database::"Loans Register",'Approval of a Loan Application is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelLoanApplicationApprovalRequestCode,
                                      Database::"Loans Register",'An Approval request for a Loan Application is canceled.',0,false);
          //Loan Disbursement
          WFHandler.AddEventToLibrary(RunWorkflowOnSendLoanDisbursementForApprovalCode,
                                      Database::"Loan Disburesment-Batching",'Approval of a Loan Disbursement is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelLoanDisbursementApprovalRequestCode,
                                      Database::"Loan Disburesment-Batching",'An Approval request for a Loan Disbursement is canceled.',0,false);

          //Standing Orders
          WFHandler.AddEventToLibrary(RunWorkflowOnSendStandingOrderForApprovalCode,
                                      Database::"Standing Orders",'Approval of a Standing Order is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelStandingOrderApprovalRequestCode,
                                      Database::"Standing Orders",'An Approval request for a Standing Order is canceled.',0,false);

        //Membership Withdrawal
          WFHandler.AddEventToLibrary(RunWorkflowOnSendMWithdrawalForApprovalCode,
                                      Database::"Membership Exit",'Approval of a Membership Withdrawal is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelMWithdrawalApprovalRequestCode,
                                      Database::"Membership Exit",'An Approval request for a Membership Withdrawal is canceled.',0,false);
        //ATM Card Application
          WFHandler.AddEventToLibrary(RunWorkflowOnSendATMCardForApprovalCode,
                                      Database::"ATM Card Applications",'Approval of  ATM Card is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelATMCardApprovalRequestCode,
                                      Database::"ATM Card Applications",'An Approval request for  ATM Card is canceled.',0,false);
        //Guarantor Recovery
          WFHandler.AddEventToLibrary(RunWorkflowOnSendGuarantorRecoveryForApprovalCode,
                                      Database::"Loan Recovery Header",'Approval of Guarantor Recovery is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelGuarantorRecoveryApprovalRequestCode,
                                      Database::"Loan Recovery Header",'An Approval request for Guarantor Recovery is canceled.',0,false);

        //Change Request
          WFHandler.AddEventToLibrary(RunWorkflowOnSendChangeRequestForApprovalCode,
                                      Database::"Change Request",'Approval of Change Request is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelChangeRequestApprovalRequestCode,
                                      Database::"Change Request",'An Approval request for Change Request is canceled.',0,false);

        //Treasury Transactions
          WFHandler.AddEventToLibrary(RunWorkflowOnSendTTransactionsForApprovalCode,
                                      Database::"Treasury Transactions",'Approval of Treasury Transaction is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelTTransactionsApprovalRequestCode,
                                      Database::"Treasury Transactions",'An Approval request for Treasury Transaction is canceled.',0,false);

         //FOSA Account Application
          WFHandler.AddEventToLibrary(RunWorkflowOnSendFAccountApplicationForApprovalCode,
                                      Database::"FOSA Account Applicat. Details",'Approval of FOSA Account Application is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelFAccountApplicationApprovalRequestCode,
                                      Database::"FOSA Account Applicat. Details",'An Approval request for FOSA Account Application is canceled.',0,false);
          //Stores Requisition
          WFHandler.AddEventToLibrary(RunWorkflowOnSendSReqApplicationForApprovalCode,
                                      Database::"Store Requistion Header P",'Approval of Stores Requisition Application is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelSReqApplicationApprovalRequestCode,
                                      Database::"Store Requistion Header P",'An Approval request for Stores Requisition Application is canceled.',0,false);

        //Sacco Transfer
          WFHandler.AddEventToLibrary(RunWorkflowOnSendSaccoTransferForApprovalCode,
                                      Database::"Sacco Transfers",'Approval of Sacco Transfer is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelSaccoTransferApprovalRequestCode,
                                      Database::"Sacco Transfers",'An Approval request for Sacco Transfer is canceled.',0,false);

        //Cheque Discounting
          WFHandler.AddEventToLibrary(RunWorkflowOnSendChequeDiscountingForApprovalCode,
                                      Database::"Cheque Discounting",'Approval of Cheque Discounting is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelChequeDiscountingApprovalRequestCode,
                                      Database::"Cheque Discounting",'An Approval request for Cheque Discounting is canceled.',0,false);
        //Imprest Requisition
          WFHandler.AddEventToLibrary(RunWorkflowOnSendImprestRequisitionForApprovalCode,
                                      Database::"Imprest Header",'Approval of Imprest Requisition is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelImprestRequisitionApprovalRequestCode,
                                      Database::"Imprest Header",'An Approval request for Imprest Requisition is canceled.',0,false);
        //Imprest Surrender
          WFHandler.AddEventToLibrary(RunWorkflowOnSendImprestSurrenderForApprovalCode,
                                      Database::"Imprest Surrender Header",'Approval of Imprest Surrender is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelImprestSurrenderApprovalRequestCode,
                                      Database::"Imprest Surrender Header",'An Approval request for Imprest Surrender is canceled.',0,false);
        //Leave Application
          WFHandler.AddEventToLibrary(RunWorkflowOnSendLeaveApplicationForApprovalCode,
                                      Database::"HR Leave Application",'Approval of Leave Application is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelLeaveApplicationApprovalRequestCode,
                                      Database::"HR Leave Application",'An Approval request for Leave Application is canceled.',0,false);

        //Bulk Withdrawal
          WFHandler.AddEventToLibrary(RunWorkflowOnSendBulkWithdrawalForApprovalCode,
                                      Database::"Bulk Withdrawal Application",'Approval of  Bulk Withdrawal is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelBulkWithdrawalApprovalRequestCode,
                                      Database::"Bulk Withdrawal Application",'An Approval request for  Bulk Withdrawal is canceled.',0,false);

        //Package Lodging
          WFHandler.AddEventToLibrary(RunWorkflowOnSendPackageLodgeForApprovalCode,
                                      Database::"Safe Custody Package Register",'Approval of  Package Lodging is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelPackageLodgeApprovalRequestCode,
                                      Database::"Safe Custody Package Register",'An Approval request for  Package Lodging is canceled.',0,false);

        //Package Retrieval
          WFHandler.AddEventToLibrary(RunWorkflowOnSendPackageRetrievalForApprovalCode,
                                      Database::"Package Retrieval Register",'Approval of  Package Retrieval is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelPackageRetrievalApprovalRequestCode,
                                      Database::"Package Retrieval Register",'An Approval request for  Package Retrieval is canceled.',0,false);

        //House Change
          WFHandler.AddEventToLibrary(RunWorkflowOnSendHouseChangeForApprovalCode,
                                      Database::"House Group Change Request",'Approval of  House Change is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelHouseChangeApprovalRequestCode,
                                      Database::"House Group Change Request",'An Approval request for  House Change is canceled.',0,false);

        //CRM Training
          WFHandler.AddEventToLibrary(RunWorkflowOnSendCRMTrainingForApprovalCode,
                                      Database::"CRM Trainings",'Approval of  CRM Training is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelCRMTrainingApprovalRequestCode,
                                      Database::"CRM Trainings",'An Approval request for  CRM Training is canceled.',0,false);

        //Petty Cash
          WFHandler.AddEventToLibrary(RunWorkflowOnSendPettyCashForApprovalCode,
                                      Database::"Payment Header.",'Approval of  Petty Cash is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelPettyCashApprovalRequestCode,
                                      Database::"Payment Header.",'An Approval request for  Petty Cash is canceled.',0,false);

        //Staff Claims
          WFHandler.AddEventToLibrary(RunWorkflowOnSendStaffClaimsForApprovalCode,
                                      Database::"Staff Claims Header",'Approval of  Staff Claims is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelStaffClaimsApprovalRequestCode,
                                      Database::"Staff Claims Header",'An Approval request for  Staff Claims is canceled.',0,false);

        //Member Agent/NOK Change
          WFHandler.AddEventToLibrary(RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode,
                                      Database::"Member Agent/Next Of Kin Chang",'Approval of  Member Agent/NOK Change is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequestCode,
                                      Database::"Member Agent/Next Of Kin Chang",'An Approval request for  Member Agent/NOK Change is canceled.',0,false);

        //House Registration
          WFHandler.AddEventToLibrary(RunWorkflowOnSendHouseRegistrationForApprovalCode,
                                      Database::"House Groups Registration",'Approval of  House Registration is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelHouseRegistrationApprovalRequestCode,
                                      Database::"House Groups Registration",'An Approval request for House Registration is canceled.',0,false);

        //Loan PayOff
          WFHandler.AddEventToLibrary(RunWorkflowOnSendLoanPayOffForApprovalCode,
                                      Database::"Loan PayOff",'Approval of  Loan PayOff is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelLoanPayOffApprovalRequestCode,
                                      Database::"Loan PayOff",'An Approval request for Loan PayOff  is canceled.',0,false);

        //Fixed Deposit Placement
          WFHandler.AddEventToLibrary(RunWorkflowOnSendFixedDepositForApprovalCode,
                                      Database::"Fixed Deposit Placement",'Approval of  Fixed Deposit is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelFixedDepositApprovalRequestCode,
                                      Database::"Fixed Deposit Placement",'An Approval request for Fixed Deposit  is canceled.',0,false);

        //Purchase Requisition
          WFHandler.AddEventToLibrary(RunWorkflowOnSendPurchaseRequisitionForApprovalCode,
                                      Database::"Purchase Header",'Approval of  Purchase Requisition is Requested.',0,false);
          WFHandler.AddEventToLibrary(RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode,
                                      Database::"Purchase Header",'An Approval request for  Purchase Requisition is canceled.',0,false);
        //STO
        WFHandler.AddEventToLibrary(RunWorkflowOnSendSTOForApprovalCode,
                                    Database::"Standing Orders",'Approval for STO is Requested.',0,false);


          //-------------------------------------------End Approval Events-------------------------------------------------------------
    end;


    procedure AddEventsPredecessor()
    begin
        //--------------------------------------1.Approval,Rejection,Delegation Predecessors------------------------------------------------
          //Payment Header
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendPaymentDocForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendPaymentDocForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendPaymentDocForApprovalCode);

          //Membership Application
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendMembershipApplicationForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendMembershipApplicationForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendMembershipApplicationForApprovalCode);
          //Loan Application
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendLoanApplicationForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendLoanApplicationForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendLoanApplicationForApprovalCode);
          //Loan Disbursement
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendLoanDisbursementForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendLoanDisbursementForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendLoanDisbursementForApprovalCode);

        //Standing Order
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendStandingOrderForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendStandingOrderForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendStandingOrderForApprovalCode);

        //Membership Withdrawal
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendMWithdrawalForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendMWithdrawalForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendMWithdrawalForApprovalCode);

        //ATM Card Applications
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendATMCardForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendATMCardForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendATMCardForApprovalCode);

        //Guarantor Recovery
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendGuarantorRecoveryForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendGuarantorRecoveryForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendGuarantorRecoveryForApprovalCode);

        //Change Request
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendChangeRequestForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendChangeRequestForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendChangeRequestForApprovalCode);

        //Treasury Transaction
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendTTransactionsForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendTTransactionsForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendTTransactionsForApprovalCode);

        //FOSA Account Application
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendFAccountApplicationForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendFAccountApplicationForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendFAccountApplicationForApprovalCode);

        //Stores Requisition
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendSReqApplicationForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendSReqApplicationForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendSReqApplicationForApprovalCode);

        //Sacco Transfer
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendSaccoTransferForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendSaccoTransferForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendSaccoTransferForApprovalCode);

        //Cheque Discounting
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendChequeDiscountingForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendChequeDiscountingForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendChequeDiscountingForApprovalCode);

        //Imprest Requisition
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendImprestRequisitionForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendImprestRequisitionForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendImprestRequisitionForApprovalCode);

        //Imprest Surrender
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendImprestSurrenderForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendImprestSurrenderForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendImprestSurrenderForApprovalCode);

        //Leave Application
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendLeaveApplicationForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendLeaveApplicationForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendLeaveApplicationForApprovalCode);

        //Bulk Withdrawal
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendBulkWithdrawalForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendBulkWithdrawalForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendBulkWithdrawalForApprovalCode);

        //Package Lodging
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendPackageLodgeForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendPackageLodgeForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendPackageLodgeForApprovalCode);

        //Package Retrieval
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendPackageRetrievalForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendPackageRetrievalForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendPackageRetrievalForApprovalCode);

        //House Change
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendHouseChangeForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendHouseChangeForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendHouseChangeForApprovalCode);

        //CRM Training
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendCRMTrainingForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendCRMTrainingForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendCRMTrainingForApprovalCode);

        //Petty Cash
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendPettyCashForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendPettyCashForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendPettyCashForApprovalCode);

        //Staff Claims
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendStaffClaimsForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendStaffClaimsForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendStaffClaimsForApprovalCode);

        //Member Agent/NOK Change
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode);

        //House Registration
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendHouseRegistrationForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendHouseRegistrationForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendHouseRegistrationForApprovalCode);

        //Loan Payoff
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendLoanPayOffForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendLoanPayOffForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendLoanPayOffForApprovalCode);

        //Fixed Deposit
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendFixedDepositForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendFixedDepositForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendFixedDepositForApprovalCode);

        //Purchase Requisition
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendPurchaseRequisitionForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendPurchaseRequisitionForApprovalCode);
            WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendPurchaseRequisitionForApprovalCode);
        //sto
           WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendSTOForApprovalCode);
           WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendSTOForApprovalCode);
           WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendSTOForApprovalCode);








        //---------------------------------------End Approval,Rejection,Delegation Predecessors---------------------------------------------
    end;


    procedure RunWorkflowOnSendPaymentDocForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPaymentDocForApproval'));
    end;


    procedure RunWorkflowOnCancelPaymentApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPaymentApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendPaymentDocForApproval', '', false, false)]

    procedure RunWorkflowOnSendPaymentDocForApproval(var PaymentHeader: Record "Payments Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPaymentDocForApprovalCode,PaymentHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelPaymentApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelPaymentApprovalRequest(var PaymentHeader: Record "Payments Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPaymentApprovalRequestCode,PaymentHeader);
    end;


    procedure RunWorkflowOnSendMembershipApplicationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendMembershipApplicationForApproval'));
    end;


    procedure RunWorkflowOnCancelMembershipApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelMembershipApplicationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendMembershipApplicationForApproval', '', false, false)]

    procedure RunWorkflowOnSendMembershipApplicationForApproval(var MembershipApplication: Record "Membership Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendMembershipApplicationForApprovalCode,MembershipApplication);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelMembershipApplicationApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelMembershipApplicationApprovalRequest(var MembershipApplication: Record "Membership Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelMembershipApplicationApprovalRequestCode,MembershipApplication);
    end;


    procedure RunWorkflowOnSendLoanApplicationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLoanApplicationForApproval'));
    end;


    procedure RunWorkflowOnCancelLoanApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLoanApplicationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendLoanApplicationForApproval', '', false, false)]

    procedure RunWorkflowOnSendLoanApplicationForApproval(var LoanApplication: Record "Loans Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanApplicationForApprovalCode,LoanApplication);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelLoanApplicationApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelLoanApplicationApprovalRequest(var LoanApplication: Record "Loans Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanApplicationApprovalRequestCode,LoanApplication);
    end;


    procedure RunWorkflowOnSendLoanDisbursementForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLoanDisbursementForApproval'));
    end;


    procedure RunWorkflowOnCancelLoanDisbursementApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLoanDisbursementApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendLoanDisbursementForApproval', '', false, false)]

    procedure RunWorkflowOnSendLoanDisbursementForApproval(var LoanDisbursement: Record "Loan Disburesment-Batching")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanDisbursementForApprovalCode,LoanDisbursement);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelLoanDisbursementApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelLoanDisbursementApprovalRequest(var LoanDisbursement: Record "Loan Disburesment-Batching")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanDisbursementApprovalRequestCode,LoanDisbursement);
    end;


    procedure RunWorkflowOnSendStandingOrderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendStandingOrderForApproval'));
    end;


    procedure RunWorkflowOnCancelStandingOrderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelStandingOrderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendStandingOrderForApproval', '', false, false)]

    procedure RunWorkflowOnSendStandingOrderForApproval(var StandingOrder: Record "Standing Orders")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendStandingOrderForApprovalCode,StandingOrder);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelStandingOrderApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelStandingOrderApprovalRequest(var StandingOrder: Record "Standing Orders")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelStandingOrderApprovalRequestCode,StandingOrder);
    end;


    procedure RunWorkflowOnSendMWithdrawalForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendMWithdrawalForApproval'));
    end;


    procedure RunWorkflowOnCancelMWithdrawalApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelMWithdrawalApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendMWithdrawalForApproval', '', false, false)]

    procedure RunWorkflowOnSendMWithdrawalForApproval(var MWithdrawal: Record "Membership Exit")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendMWithdrawalForApprovalCode,MWithdrawal);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelMWithdrawalApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelMWithdrawalApprovalRequest(var MWithdrawal: Record "Membership Exit")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelMWithdrawalApprovalRequestCode,MWithdrawal);
    end;


    procedure RunWorkflowOnSendATMCardForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendATMCardForApproval'));
    end;


    procedure RunWorkflowOnCancelATMCardApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelATMCardApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendATMCardForApproval', '', false, false)]

    procedure RunWorkflowOnSendATMCardForApproval(var ATMCard: Record "ATM Card Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendATMCardForApprovalCode,ATMCard);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelATMCardApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelATMCardApprovalRequest(var ATMCard: Record "ATM Card Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelATMCardApprovalRequestCode,ATMCard);
    end;


    procedure RunWorkflowOnSendGuarantorRecoveryForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendGuarantorRecoveryForApproval'));
    end;


    procedure RunWorkflowOnCancelGuarantorRecoveryApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelGuarantorRecoveryApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendGuarantorRecoveryForApproval', '', false, false)]

    procedure RunWorkflowOnSendGuarantorRecoveryForApproval(var GuarantorRecovery: Record "Loan Recovery Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendGuarantorRecoveryForApprovalCode,GuarantorRecovery);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelGuarantorRecoveryApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelGuarantorRecoveryApprovalRequest(var GuarantorRecovery: Record "Loan Recovery Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelGuarantorRecoveryApprovalRequestCode,GuarantorRecovery);
    end;


    procedure RunWorkflowOnSendChangeRequestForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendChangeRequestForApproval'));
    end;


    procedure RunWorkflowOnCancelChangeRequestApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelChangeRequestApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendChangeRequestForApproval', '', false, false)]

    procedure RunWorkflowOnSendChangeRequestForApproval(var ChangeRequest: Record "Change Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendChangeRequestForApprovalCode,ChangeRequest);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelChangeRequestApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelChangeRequestApprovalRequest(var ChangeRequest: Record "Change Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelChangeRequestApprovalRequestCode,ChangeRequest);
    end;


    procedure RunWorkflowOnSendTTransactionsForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendTTransactionsForApproval'));
    end;


    procedure RunWorkflowOnCancelTTransactionsApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelTTransactionsApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendTTransactionsForApproval', '', false, false)]

    procedure RunWorkflowOnSendTTransactionsForApproval(var TTransactions: Record "Treasury Transactions")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendTTransactionsForApprovalCode,TTransactions);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelTTransactionsApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelTTransactionsApprovalRequest(var TTransactions: Record "Treasury Transactions")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelTTransactionsApprovalRequestCode,TTransactions);
    end;


    procedure RunWorkflowOnSendFAccountApplicationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendFAccountApplicationForApproval'));
    end;


    procedure RunWorkflowOnCancelFAccountApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelFAccountApplicationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendFAccountApplicationForApproval', '', false, false)]

    procedure RunWorkflowOnSendFAccountApplicationForApproval(var FAccount: Record "FOSA Account Applicat. Details")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendFAccountApplicationForApprovalCode,FAccount);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelFAccountApplicationApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelFAccountApplicationApprovalRequest(var FAccount: Record "FOSA Account Applicat. Details")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelFAccountApplicationApprovalRequestCode,FAccount);
    end;


    procedure RunWorkflowOnSendSReqApplicationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendSReqApplicationForApproval'));
    end;


    procedure RunWorkflowOnCancelSReqApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelSReqApplicationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendSReqApplicationForApproval', '', false, false)]

    procedure RunWorkflowOnSendSReqApplicationForApproval(var SReq: Record "Store Requistion Header P")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendSReqApplicationForApprovalCode,SReq);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelSReqApplicationApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelSReqApplicationApprovalRequest(var SReq: Record "Store Requistion Header P")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelSReqApplicationApprovalRequestCode,SReq);
    end;


    procedure RunWorkflowOnSendSaccoTransferForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendSaccoTransferForApproval'));
    end;


    procedure RunWorkflowOnCancelSaccoTransferApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelSaccoTransferApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendSaccoTransferForApproval', '', false, false)]

    procedure RunWorkflowOnSendSaccoTransferForApproval(var SaccoTransfer: Record "Sacco Transfers")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendSaccoTransferForApprovalCode,SaccoTransfer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelSaccoTransferApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelSaccoTransferApprovalRequest(var SaccoTransfer: Record "Sacco Transfers")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelSaccoTransferApprovalRequestCode,SaccoTransfer);
    end;


    procedure RunWorkflowOnSendChequeDiscountingForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendChequeDiscountingForApproval'));
    end;


    procedure RunWorkflowOnCancelChequeDiscountingApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelChequeDiscountingApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendChequeDiscountingForApproval', '', false, false)]

    procedure RunWorkflowOnSendChequeDiscountingForApproval(var ChequeDiscounting: Record "Cheque Discounting")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendChequeDiscountingForApprovalCode,ChequeDiscounting);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelChequeDiscountingApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelChequeDiscountingApprovalRequest(var ChequeDiscounting: Record "Cheque Discounting")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelChequeDiscountingApprovalRequestCode,ChequeDiscounting);
    end;


    procedure RunWorkflowOnSendImprestRequisitionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendImprestRequisitionForApproval'));
    end;


    procedure RunWorkflowOnCancelImprestRequisitionApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelImprestRequisitionApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendImprestRequisitionForApproval', '', false, false)]

    procedure RunWorkflowOnSendImprestRequisitionForApproval(var ImprestRequisition: Record "Imprest Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendImprestRequisitionForApprovalCode,ImprestRequisition);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelImprestRequisitionApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelImprestRequisitionApprovalRequest(var ImprestRequisition: Record "Imprest Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelImprestRequisitionApprovalRequestCode,ImprestRequisition);
    end;


    procedure RunWorkflowOnSendImprestSurrenderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendImprestSurrenderForApproval'));
    end;


    procedure RunWorkflowOnCancelImprestSurrenderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelImprestSurrenderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendImprestSurrenderForApproval', '', false, false)]

    procedure RunWorkflowOnSendImprestSurrenderForApproval(var ImprestSurrender: Record "Imprest Surrender Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendImprestSurrenderForApprovalCode,ImprestSurrender);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelImprestSurrenderApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelImprestSurrenderApprovalRequest(var ImprestSurrender: Record "Imprest Surrender Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelImprestSurrenderApprovalRequestCode,ImprestSurrender);
    end;


    procedure RunWorkflowOnSendLeaveApplicationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLeaveApplicationForApproval'));
    end;


    procedure RunWorkflowOnCancelLeaveApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLeaveApplicationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendLeaveApplicationForApproval', '', false, false)]

    procedure RunWorkflowOnSendLeaveApplicationForApproval(var LeaveApplication: Record "HR Leave Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLeaveApplicationForApprovalCode,LeaveApplication);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelLeaveApplicationApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelLeaveApplicationApprovalRequest(var LeaveApplication: Record "HR Leave Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLeaveApplicationApprovalRequestCode,LeaveApplication);
    end;


    procedure RunWorkflowOnSendPVForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPVForApproval'));
    end;


    procedure RunWorkflowOnCancelPVApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPVApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendPVForApproval', '', false, false)]

    procedure RunWorkflowOnSendPVForApproval(var PaymentsHeader: Record "Payments Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPVForApprovalCode,PaymentsHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelPVApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelPVApprovalRequest(var PaymentsHeader: Record "Payments Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPVApprovalRequestCode,PaymentsHeader);
    end;


    procedure RunWorkflowOnSendBulkWithdrawalForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendBulkWithdrawalForApproval'));
    end;


    procedure RunWorkflowOnCancelBulkWithdrawalApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelBulkWithdrawalApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendBulkWithdrawalForApproval', '', false, false)]

    procedure RunWorkflowOnSendBulkWithdrawalForApproval(var BulkWithdrawal: Record "Bulk Withdrawal Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendBulkWithdrawalForApprovalCode,BulkWithdrawal);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelBulkWithdrawalApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelBulkWithdrawalApprovalRequest(var BulkWithdrawal: Record "Bulk Withdrawal Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelBulkWithdrawalApprovalRequestCode,BulkWithdrawal);
    end;


    procedure RunWorkflowOnSendPackageLodgeForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPackageLodgeForApproval'));
    end;


    procedure RunWorkflowOnCancelPackageLodgeApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPackageLodgeApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendPackageLodgeForApproval', '', false, false)]

    procedure RunWorkflowOnSendPackageLodgeForApproval(var PackageLodge: Record "Safe Custody Package Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPackageLodgeForApprovalCode,PackageLodge);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelPackageLodgeApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelPackageLodgeApprovalRequest(var PackageLodge: Record "Safe Custody Package Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPackageLodgeApprovalRequestCode,PackageLodge);
    end;


    procedure RunWorkflowOnSendPackageRetrievalForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPackageRetrievalForApproval'));
    end;


    procedure RunWorkflowOnCancelPackageRetrievalApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPackageRetrievalApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendPackageRetrievalForApproval', '', false, false)]

    procedure RunWorkflowOnSendPackageRetrievalForApproval(var PackageRetrieval: Record "Package Retrieval Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPackageRetrievalForApprovalCode,PackageRetrieval);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelPackageRetrievalApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelPackageRetrievalApprovalRequest(var PackageRetrieval: Record "Package Retrieval Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPackageRetrievalApprovalRequestCode,PackageRetrieval);
    end;


    procedure RunWorkflowOnSendPurchaseRequisitionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPurchaseRequisitionForApproval'));
    end;


    procedure RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPurchaseRequisitionApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendPurchaseRequisitionForApproval', '', false, false)]

    procedure RunWorkflowOnSendPurchaseRequisitionForApproval(var PRequest: Record "Purchase Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPurchaseRequisitionForApprovalCode,PRequest);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelPurchaseRequisitionApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelPurchaseRequisitionApprovalRequest(var PRequest: Record "Purchase Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode,PRequest);
    end;


    procedure RunWorkflowOnSendHouseChangeForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHouseChangeForApproval'));
    end;


    procedure RunWorkflowOnCancelHouseChangeApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHouseChangeApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendHouseChangeForApproval', '', false, false)]

    procedure RunWorkflowOnSendHouseChangeForApproval(var HouseChange: Record "House Group Change Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHouseChangeForApprovalCode,HouseChange);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelHouseChangeApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelHouseChangeApprovalRequest(var HouseChange: Record "House Group Change Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelHouseChangeApprovalRequestCode,HouseChange);
    end;


    procedure RunWorkflowOnSendCRMTrainingForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendCRMTrainingForApproval'));
    end;


    procedure RunWorkflowOnCancelCRMTrainingApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelCRMTrainingApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendCRMTrainingForApproval', '', false, false)]

    procedure RunWorkflowOnSendCRMTrainingForApproval(var CRMTraining: Record "CRM Trainings")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendCRMTrainingForApprovalCode,CRMTraining);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelCRMTrainingApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelCRMTrainingApprovalRequest(var CRMTraining: Record "CRM Trainings")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelCRMTrainingApprovalRequestCode,CRMTraining);
    end;


    procedure RunWorkflowOnSendPettyCashForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPettyCashForApproval'));
    end;


    procedure RunWorkflowOnCancelPettyCashApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPettyCashApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendPettyCashForApproval', '', false, false)]

    procedure RunWorkflowOnSendPettyCashForApproval(var PettyCash: Record "Payment Header.")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPettyCashForApprovalCode,PettyCash);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelPettyCashApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelPettyCashApprovalRequest(var PettyCash: Record "Payment Header.")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPettyCashApprovalRequestCode,PettyCash);
    end;


    procedure RunWorkflowOnSendStaffClaimsForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendStaffClaimsForApproval'));
    end;


    procedure RunWorkflowOnCancelStaffClaimsApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelStaffClaimsApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendStaffClaimsForApproval', '', false, false)]

    procedure RunWorkflowOnSendStaffClaimsForApproval(var StaffClaims: Record "Staff Claims Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendStaffClaimsForApprovalCode,StaffClaims);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelPettyCashApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelStaffClaimsApprovalRequest(var StaffClaims: Record "Staff Claims Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelStaffClaimsApprovalRequestCode,StaffClaims);
    end;


    procedure RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendMemberAgentNOKChangeForApproval'));
    end;


    procedure RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendMemberAgentNOKChangeForApproval', '', false, false)]

    procedure RunWorkflowOnSendMemberAgentNOKChangeForApproval(var MemberAgentNOKChange: Record "Member Agent/Next Of Kin Chang")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode,MemberAgentNOKChange);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelMemberAgentNOKChangeApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequest(var MemberAgentNOKChange: Record "Member Agent/Next Of Kin Chang")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequestCode,MemberAgentNOKChange);
    end;


    procedure RunWorkflowOnSendHouseRegistrationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHouseRegistrationForApproval'));
    end;


    procedure RunWorkflowOnCancelHouseRegistrationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHouseRegistrationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendHouseRegistrationForApproval', '', false, false)]

    procedure RunWorkflowOnSendHouseRegistrationForApproval(var HouseRegistration: Record "House Groups Registration")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHouseRegistrationForApprovalCode,HouseRegistration);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelHouseRegistrationApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelHouseRegistrationApprovalRequest(var HouseRegistration: Record "House Groups Registration")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelHouseRegistrationApprovalRequestCode,HouseRegistration);
    end;


    procedure RunWorkflowOnSendLoanPayOffForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLoanPayOffForApproval'));
    end;


    procedure RunWorkflowOnCancelLoanPayOffApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLoanPayOffApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendLoanPayOffForApproval', '', false, false)]

    procedure RunWorkflowOnSendLoanPayOffForApproval(var LoanPayOff: Record "Loan PayOff")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanPayOffForApprovalCode,LoanPayOff);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelLoanPayOffApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelLoanPayOffApprovalRequest(var LoanPayOff: Record "Loan PayOff")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanPayOffApprovalRequestCode,LoanPayOff);
    end;


    procedure RunWorkflowOnSendFixedDepositForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendFixedDepositForApproval'));
    end;


    procedure RunWorkflowOnCancelFixedDepositApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelFixedDepositApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendFixedDepositForApproval', '', false, false)]

    procedure RunWorkflowOnSendFixedDepositForApproval(var FixedDeposit: Record "Fixed Deposit Placement")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendFixedDepositForApprovalCode,FixedDeposit);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelFixedDepositApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelFixedDepositApprovalRequest(var FixedDeposit: Record "Fixed Deposit Placement")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelFixedDepositApprovalRequestCode,FixedDeposit);
    end;


    procedure RunWorkflowOnSendSTOForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendSTOForApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendSTOforApproval', '', false, false)]

    procedure RunWorkflowOnSendSTOForApproval(var STO: Record "Standing Orders")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendSTOForApprovalCode,STO);
    end;
}

