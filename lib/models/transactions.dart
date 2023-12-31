class TelaTransaction{

  int id = 0;
  String type = '';
  String paymentWay = '';
  String transactionNumber = '';
  String operationId = '';
  int userID = 0;
  double amount = 0;
  DateTime date = DateTime.now();


  TelaTransaction(
      {required this.id,
      required this.type,
      required this.paymentWay,
      required this.transactionNumber,
      required this.operationId,
      required this.userID,
      required this.amount,
      required this.date});



  static TelaTransaction fromJson(Map<String, dynamic> json){
    TelaTransaction u = TelaTransaction(
      id : json["id"],
      amount: (json["amount"] as int).toDouble(),
      userID: json["user_id"],
      type: json["transaction_type"],
      transactionNumber: json["transaction_number"],
      date: DateTime.parse(json["date_transaction"]),
      paymentWay: json["transaction_way"]??'',
      operationId: '',
    );
    return u;
  }

  // map for database
  Map<String, dynamic> toJson(){
    return {
      "amount": amount,
      "user_id": userID,
      "date_transaction": date.toIso8601String(),
      "transaction_number": transactionNumber,
      "transaction_way": paymentWay,
      "operation_id": operationId,
      "transaction_type": type,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TelaTransaction &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          type == other.type &&
          paymentWay == other.paymentWay &&
          transactionNumber == other.transactionNumber &&
          userID == other.userID &&
          amount == other.amount &&
          date == other.date;

  @override
  int get hashCode =>
      id.hashCode ^
      type.hashCode ^
      paymentWay.hashCode ^
      transactionNumber.hashCode ^
      userID.hashCode ^
      amount.hashCode ^
      date.hashCode;

  @override
  String toString() {
    return 'TelaTransaction{id: $id, type: $type, paymentWay: $paymentWay, TransactionNumber: $transactionNumber, userID: $userID, amount: $amount, date: $date}';
  }
}