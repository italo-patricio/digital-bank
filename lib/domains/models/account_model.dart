class AccountModel {
  final String _id;
  final String _name;
  double _balance = 0.0;
  final double _limitTransaction;

  AccountModel(this._id, this._name, {required double limitTransaction})
      : _limitTransaction = limitTransaction;

  String get id => _id;
  String get name => _name;

  double checkBalance() {
    return _balance;
  }

  double get limiteTransaction => _limitTransaction;

  void debit(double value) {
    if (_balance < value || _balance == 0) {
      throw Exception('Balance is zero');
    }

    _balance -= value;
  }

  void credit(double value) {
    _balance += value;
  }
}
