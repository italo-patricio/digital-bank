import 'package:digital_bank/domains/interfaces/transacao.dart';
import 'package:digital_bank/domains/models/transacao_model.dart';

class TransacaoCredito implements ITransacao {
  @override
  execute(TransacaoModel transacaoModel) {
    transacaoModel.contaModel.saldo += transacaoModel.valor;
  }
}
