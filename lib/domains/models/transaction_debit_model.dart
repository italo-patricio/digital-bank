import 'package:digital_bank/domains/models/transaction_model.dart';

class TransactionDebitModel extends TransactionModel {
  TransactionDebitModel({required super.account, required super.value, required super.createdAt});

  @override
  get type => 'debit';

}