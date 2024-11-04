import 'package:digital_bank/domains/handlers/transacao.dart';
import 'package:digital_bank/domains/models/transacao_model.dart';

class TransacaoDebito implements ITransacao {
  @override
  execute(TransacaoModel transacaoModel) {
    if (transacaoModel.contaModel.saldo < transacaoModel.valor) {
      throw Exception('Saldo indisponível');
    }

    transacaoModel.contaModel.saldo -= transacaoModel.valor;
  }
}
