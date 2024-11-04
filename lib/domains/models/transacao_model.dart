import 'package:digital_bank/domains/models/conta_model.dart';

class TransacaoModel {
  final ContaModel contaModel;
  final double valor;
  final DateTime data;

  TransacaoModel({
    required this.contaModel,
    required this.valor,
    required this.data,
  });
}
