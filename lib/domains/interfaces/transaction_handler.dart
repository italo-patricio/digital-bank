
import 'package:digital_bank/domains/models/transaction_model.dart';

abstract interface class TransactionHandler {
  credit(TransactionModel transaction);
  debit(TransactionModel transaction);

  List<TransactionModel> historical(String accoundId);
}