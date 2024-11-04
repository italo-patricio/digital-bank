import 'package:digital_bank/data/handlers/transacao_credito.dart';
import 'package:digital_bank/domains/models/conta_model.dart';
import 'package:digital_bank/domains/models/transacao_model.dart';
import 'package:test/test.dart';

void main() {
  group('Transacao credito testes', () {
    test('Transacao credito deve aumentar saldo atual', () {
      final transacao = TransacaoCredito();

      final contaTest = ContaModel(nome: 'Italo', saldo: 100);

      transacao.execute(
        TransacaoModel(contaModel: contaTest, valor: 20, data: DateTime.now()),
      );

      expect(contaTest.saldo, 120.0);
    });
  });
}
