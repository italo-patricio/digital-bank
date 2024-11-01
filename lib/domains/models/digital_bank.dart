import 'package:digital_bank/domains/interfaces/transaction_handler.dart';
import 'package:digital_bank/domains/models/account_model.dart';
import 'package:digital_bank/domains/models/transaction_credit_model.dart';
import 'package:digital_bank/domains/models/transaction_debit_model.dart';

class DigitalBank {
  final TransactionHandler _transactionHandler;

  DigitalBank({required TransactionHandler transactionHandler})
      : _transactionHandler = transactionHandler;

  void transfer({
    required AccountModel accountFrom,
    required AccountModel accountTo,
    required double value,
  }) async {
    _transactionHandler.debit(TransactionDebitModel(
        account: accountFrom, value: value, createdAt: DateTime.now()));

    // deposit na contaB
    _transactionHandler.credit(TransactionCreditModel(
        account: accountTo, value: value, createdAt: DateTime.now()));
  }
}
