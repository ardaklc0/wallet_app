import 'package:flutter/cupertino.dart';
import 'package:wallet_app/repositories/card_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class SpendingRepository extends ChangeNotifier {
  List<Transaction> transactions = [
    Transaction("-400", "Market", 0, DateTime.now(), "İş Bankası"),
    Transaction("-300", "Kıyafet", 0, DateTime.now(), "Ziraat Bankası"),
    Transaction("-500", "Benzin", 0, DateTime.now(), "Türkiye Finans"),

  ];

  void addMinusTransaction(String amount, String transaction_name, int transacted_card_index, DateTime expense_date, String transacted_card) {
    transactions.add(Transaction("-$amount", transaction_name, transacted_card_index, expense_date, transacted_card));
    notifyListeners();
  }

  void addPositiveTransaction(String amount, String transaction_name, int transacted_card_index, DateTime expense_date, String transacted_card) {
    transactions.add(Transaction("+$amount", transaction_name, transacted_card_index, expense_date, transacted_card));
    notifyListeners();
  }

  void changeTransaction(int index, new_amount, new_transaction_name, new_expense_date, new_transacted_card) {
    transactions[index].amount = new_amount;
    transactions[index].transaction_name = new_transaction_name;
    transactions[index].expense_date = new_expense_date;
    transactions[index].transacted_card = new_transacted_card;
    notifyListeners();
  }

}

final transactionProvider = ChangeNotifierProvider((ref) {
  return SpendingRepository();
});


class Transaction {
  String amount;
  String transaction_name;
  int transacted_card_index;
  DateTime expense_date;
  String transacted_card;

  Transaction(this.amount, this.transaction_name, this.transacted_card_index, this.expense_date, this.transacted_card);
}