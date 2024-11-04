import 'package:digital_bank/data/handlers/transacao_debito.dart';
import 'package:digital_bank/domains/models/conta_model.dart';
import 'package:digital_bank/domains/models/transacao_model.dart';
import 'package:test/test.dart';

void main() {
  group('Transacao debito testes', () {
    test('Transacao debito deve reduzir saldo atual', () {
      final transacaoDebito = TransacaoDebito();

      final contaTest = ContaModel(nome: 'Italo', saldo: 100);

      transacaoDebito.execute(
        TransacaoModel(contaModel: contaTest, valor: 20, data: DateTime.now()),
      );

      expect(contaTest.saldo, 80.0);
    });
    
    test('Transacao debito deve gerar exception por saldo indisponivel', () {
      final transacaoDebito = TransacaoDebito();

      final contaTest = ContaModel(nome: 'Italo', saldo: 0.0);

      expect(() => transacaoDebito.execute(
        TransacaoModel(contaModel: contaTest, valor: 20, data: DateTime.now()),
      ), throwsA(TypeMatcher<Exception>()));
    });
  });
}
