import 'package:digital_bank/domains/interfaces/transaction_handler.dart';
import 'package:digital_bank/domains/models/transaction_model.dart';

class TransactionValidatorDecoratorHandler implements TransactionHandler {
  final TransactionHandler _decoratee;

  TransactionValidatorDecoratorHandler({required TransactionHandler decoratee})
      : _decoratee = decoratee;

  @override
  credit(TransactionModel transaction) {
    return _decoratee.credit(transaction);
  }

  @override
  debit(TransactionModel transaction) {
    final historical = _decoratee.historical(transaction.account.id);
    final account = transaction.account;

    final transactionAmountedToday = historical.fold(0.0, (result, t) {
      if (t.type == 'debit' &&
          t.createdAt.difference(transaction.createdAt).inDays == 0) {
        result += t.value;
      }

      return result;
    });

    if (transactionAmountedToday > account.limiteTransaction ||
        (transactionAmountedToday + transaction.value) >
            account.limiteTransaction) {
      throw Exception('Value exceed limit today transfer');
    }

    return _decoratee.debit(transaction);
  }

  @override
  List<TransactionModel> historical(String accoundId) {
    return _decoratee.historical(accoundId);
  }
}
