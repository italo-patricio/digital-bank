import 'package:digital_bank/domains/models/account_model.dart';

abstract class TransactionModel {
  final AccountModel account;
  final double value;
  final DateTime createdAt;

  TransactionModel(
      {required this.account, required this.value, required this.createdAt});

  get type;
}
