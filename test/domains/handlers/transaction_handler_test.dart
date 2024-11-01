import 'dart:math';

import 'package:digital_bank/domains/handlers/transaction_handler.dart';
import 'package:digital_bank/domains/interfaces/transaction_handler.dart';
import 'package:digital_bank/domains/models/account_model.dart';
import 'package:digital_bank/domains/models/transaction_credit_model.dart';
import 'package:digital_bank/domains/models/transaction_debit_model.dart';
import 'package:test/test.dart';

randomId() => Random().nextDouble().toString();

void main() {
  group(
    'Transaction handler test',
    () {
      late final TransactionHandler transactionHandler;
      late AccountModel? bankAccountA, bankAccountB;
      setUpAll(() {
        transactionHandler = TransactionHandlerImpl();
      });

      setUp(() {
        bankAccountA = AccountModel(randomId(), 'Italo',
            limitTransaction: 50);
        bankAccountB = AccountModel(
            randomId(), 'Francisca',
            limitTransaction: 50);

        bankAccountA?.credit(100);
        bankAccountB?.credit(100);
      });

      tearDown(() {
        bankAccountA = null;
        bankAccountB = null;
      });

      test('Should value debited in account', () {
        final debitTransaction = TransactionDebitModel(
            account: bankAccountA!, value: 10, createdAt: DateTime.now());
        transactionHandler.debit(debitTransaction);
        transactionHandler.debit(debitTransaction);

        expect(bankAccountA!.checkBalance(), 80);
      });

      test('Should value credited in account', () {
        final creditTransaction = TransactionCreditModel(
            account: bankAccountA!, value: 10, createdAt: DateTime.now());
        final debitTransactionB = TransactionDebitModel(
            account: bankAccountB!, value: 10, createdAt: DateTime.now());
        transactionHandler.credit(creditTransaction);
        transactionHandler.debit(debitTransactionB);
        transactionHandler.credit(debitTransactionB);

        expect(bankAccountA!.checkBalance(), 110);
        expect(bankAccountB!.checkBalance(), 100);
      });

      test('Should return historical transaction correctly', () {
        final creditTransaction = TransactionCreditModel(
            account: bankAccountA!, value: 10, createdAt: DateTime.now());
        final debitTransactionB = TransactionDebitModel(
            account: bankAccountB!, value: 10, createdAt: DateTime.now());
        transactionHandler.credit(creditTransaction);
        transactionHandler.debit(debitTransactionB);
        transactionHandler.credit(debitTransactionB);

        expect(transactionHandler.historical(bankAccountA!.id).length, 1);
        expect(transactionHandler.historical(bankAccountB!.id).length, 2);
      });

      test('Must throw exception when balance is less than requested amount',
          () {
        final debitTransaction = TransactionDebitModel(
            account: bankAccountA!, value: 51, createdAt: DateTime.now());

        transactionHandler.debit(debitTransaction);

        expect(() => transactionHandler.debit(debitTransaction),
            throwsA(TypeMatcher<Exception>()));
        expect(transactionHandler.historical(bankAccountA!.id).length, 1);
      });
    },
  );
}
