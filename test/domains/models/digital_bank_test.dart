import 'dart:math';

import 'package:digital_bank/domains/handlers/transaction_handler.dart';
import 'package:digital_bank/domains/models/account_model.dart';
import 'package:digital_bank/domains/models/digital_bank.dart';
import 'package:test/test.dart';

randomId() => Random().nextDouble().toString();

void main() {
  group('Digital bank test', () {
    late DigitalBank? digitalBank;

    setUp(() {
      digitalBank = DigitalBank(transactionHandler: TransactionHandlerImpl());
    });

    tearDown(() {
      digitalBank = null;
    });

    test('Should credit value in accountB and debit value in accountA',
        () async {
      final bankAccountA =
          AccountModel(randomId(), 'Italo', limitTransaction: 50);
      final bankAccountB =
          AccountModel(randomId(), 'Francisca', limitTransaction: 50);

      bankAccountA.credit(100);
      bankAccountB.credit(100);

      digitalBank!.transfer(
          accountFrom: bankAccountA, accountTo: bankAccountB, value: 20);

      expect(bankAccountB.checkBalance(), 120);
      expect(bankAccountA.checkBalance(), 80);
    });

    test('Should througth exception debit in account with value 0.0', () async {
      final bankAccountA =
          AccountModel(randomId(), 'Italo', limitTransaction: 500);
      final bankAccountB =
          AccountModel(randomId(), 'Francisca', limitTransaction: 500);

      bankAccountB.credit(100);

      expect(
        () => digitalBank!.transfer(
          accountFrom: bankAccountA,
          accountTo: bankAccountB,
          value: 20.0,
        ),
        throwsA(TypeMatcher<Exception>()),
      );
    });

    test(
        'Should througth exception debit in account when limit transaction reached',
        () async {
      final bankAccountA =
          AccountModel(randomId(), 'Italo', limitTransaction: 50);
      final bankAccountB =
          AccountModel(randomId(), 'Francisca', limitTransaction: 50);

      bankAccountA.credit(100);
      bankAccountB.credit(100);

      digitalBank!.transfer(
        accountFrom: bankAccountA,
        accountTo: bankAccountB,
        value: 20.0,
      );
      digitalBank!.transfer(
        accountFrom: bankAccountA,
        accountTo: bankAccountB,
        value: 20.0,
      );

      expect(
        () => digitalBank!.transfer(
          accountFrom: bankAccountA,
          accountTo: bankAccountB,
          value: 20.0,
        ),
        throwsA(TypeMatcher<Exception>()),
      );
    });
  });
}
