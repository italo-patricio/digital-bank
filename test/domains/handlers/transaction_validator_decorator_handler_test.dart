import 'dart:math';

import 'package:digital_bank/domains/handlers/transaction_handler.dart';
import 'package:digital_bank/domains/handlers/transaction_validator_decorator_handler.dart';
import 'package:digital_bank/domains/interfaces/transaction_handler.dart';
import 'package:digital_bank/domains/models/account_model.dart';
import 'package:digital_bank/domains/models/transaction_credit_model.dart';
import 'package:test/test.dart';

randomId() => Random().nextInt(1000000).toString();

void main() {
  group(
    'Transaction validator decorator handler test',
    () {
      late TransactionHandler transactionHandler;
      late AccountModel accountA, accountB;
      setUp(() {
        final TransactionHandler transactionHandlerDecorate =
            TransactionHandlerImpl();

        transactionHandler = TransactionValidatorDecoratorHandler(
            decoratee: transactionHandlerDecorate);

        accountA = AccountModel(randomId(), 'Italo', limitTransaction: 1000);
        accountB =
            AccountModel(randomId(), 'Francisca', limitTransaction: 1000);
        transactionHandler.credit(TransactionCreditModel(
            account: accountA, value: 2000, createdAt: DateTime.now()));
        transactionHandler.credit(TransactionCreditModel(
            account: accountB, value: 2000, createdAt: DateTime.now()));
      });

      test('Should validate limit transfer per day', () {
        expect(
            () => transactionHandler.debit(TransactionCreditModel(
                account: accountA, value: 2000, createdAt: DateTime.now())),
            throwsA(TypeMatcher<Exception>()));
      });

      test('Should execute debit in account', () {
        transactionHandler.debit(TransactionCreditModel(
            account: accountA, value: 1000, createdAt: DateTime.now()));

        expect(accountA.checkBalance(), 1000);
      });
    },
  );
}
