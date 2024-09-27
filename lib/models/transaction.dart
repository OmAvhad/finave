class Transaction {
  final double amount;
  final String note;
  final DateTime date;

  Transaction({required this.amount, required this.note, DateTime? date})
      : date = date ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'amount': amount, 
      'note': note,
      'date': date.toIso8601String(),
    };
  }

  static Transaction fromJson(Map<String, dynamic> json) {
    return Transaction(
      amount: json['amount'],
      note: json['note'],
      date: DateTime.parse(json['date']), // Include date parsing
    );
  }
}
