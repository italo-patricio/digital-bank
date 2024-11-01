import 'dart:math';

import 'package:digital_bank/domains/handlers/transaction_handler.dart';
import 'package:digital_bank/domains/handlers/transaction_validator_decorator_handler.dart';
import 'package:digital_bank/domains/interfaces/transaction_handler.dart';
import 'package:digital_bank/domains/models/account_model.dart';
import 'package:digital_bank/domains/models/digital_bank.dart' as digital_bank;
import 'package:digital_bank/domains/models/transaction_credit_model.dart';

String get random => Random().nextInt(10000).toString();

void main(List<String> arguments) {
  final TransactionHandler transactionHandlerDecoratee = TransactionHandlerImpl();
  final TransactionHandler transactionHandler = TransactionValidatorDecoratorHandler(decoratee: transactionHandlerDecoratee);

  final digitalBank =
      digital_bank.DigitalBank(transactionHandler: transactionHandler);

  final accountA = AccountModel(random, 'Italo', limitTransaction: 5000);
  final accountB = AccountModel(random, 'Francisca', limitTransaction: 5000);

  setCreditInitial(transactionHandler, accountA, 100);
  setCreditInitial(transactionHandler, accountB, 100);

  digitalBank.transfer(
    accountFrom: accountA,
    accountTo: accountB,
    value: 20.0,
  );

  showExtractByAccount(accountA, transactionHandler);
}



setCreditInitial(TransactionHandler transactionHandler,AccountModel account, double value) {
  transactionHandler.credit(TransactionCreditModel(account: account, value: value, createdAt: DateTime.now()));
}

showExtractByAccount(AccountModel account, TransactionHandler transactionHander) {
 final historical = transactionHander.historical(account.id);
  print('O cliente ${account.name} teve as seguintes transações:\n');
 for (final hist in historical) {
  print('${hist.type} - ${hist.value} - ${hist.createdAt}');
 }
}