import 'package:digital_bank/domains/interfaces/transaction_handler.dart';
import 'package:digital_bank/domains/models/transaction_model.dart';

class TransactionHandlerImpl implements TransactionHandler {
  final Map<String, List<TransactionModel>> _transactionHistorical;

  TransactionHandlerImpl() : _transactionHistorical = {};

  @override
  debit(TransactionModel transaction) {
    final account = transaction.account;
    final value = transaction.value;
    account.debit(value);

    _addTransaction(transaction);
  }

  @override
  credit(TransactionModel transaction) {
    final account = transaction.account;
    final value = transaction.value;
    account.credit(value);

    _addTransaction(transaction);
  }

  _addTransaction(TransactionModel transaction) {
    final transactionsByAccount =
        _transactionHistorical[transaction.account.id];

    if (transactionsByAccount != null) {
      _transactionHistorical[transaction.account.id]!.add(transaction);
    } else {
      _transactionHistorical.putIfAbsent(
          transaction.account.id, () => [transaction]);
    }
  }

  @override
  List<TransactionModel> historical(String accoundId) {
    return _transactionHistorical[accoundId]?.toList() ?? [];
  }
}

