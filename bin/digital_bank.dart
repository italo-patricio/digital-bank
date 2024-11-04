import 'dart:math';

String get random => Random().nextInt(10000).toString();

void main(List<String> arguments) {

}



// setCreditInitial(TransactionHandler transactionHandler,AccountModel account, double value) {
//   transactionHandler.credit(TransactionCreditModel(account: account, value: value, createdAt: DateTime.now()));
// }

// showExtractByAccount(AccountModel account, TransactionHandler transactionHander) {
//  final historical = transactionHander.historical(account.id);
//   print('O cliente ${account.name} teve as seguintes transações:\n');
//  for (final hist in historical) {
//   print('${hist.type} - ${hist.value} - ${hist.createdAt}');
//  }
// }