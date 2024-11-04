import 'package:digital_bank/domains/models/transacao_model.dart';

abstract interface class ITransacao {
  execute(TransacaoModel transacaoModel);
}
