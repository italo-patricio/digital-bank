import 'package:digital_bank/domains/models/transaction_model.dart';

class TransactionCreditModel extends TransactionModel {
  TransactionCreditModel({required super.account, required super.value, required super.createdAt});

  @override
  get type => 'credit';

}