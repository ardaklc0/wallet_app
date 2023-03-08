import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CardRepository extends ChangeNotifier {
  List<Card> cards = [
    Card("İş Bankası", "Arda Kılıç", "2342.0"),
    Card("Ziraat Bankası", "Arda Kılıç", "3534.0"),
    Card("Türkiye Finans", "Arda Kılıç", "9264.0"),
    Card("Nakit", "Arda Kılıç", "482.0"),
  ];

  void addAccount(String name, String owner_name, String budget){
    cards.add(Card(name, owner_name, budget));
    notifyListeners();
  }

  List<Card> takeListOfCards() {
    return cards;
  }

  void expenseAdd(String amount, String card_index) {
    cards[int.parse(card_index)].card_budget =
      (double.parse(cards[int.parse(card_index)].card_budget) -
      double.parse(amount)).toString();
    notifyListeners();
  }


  void incomeAdd(String amount, String card_index) {
    cards[int.parse(card_index)].card_budget =
        (double.parse(cards[int.parse(card_index)].card_budget) +
            double.parse(amount)).toString();
    notifyListeners();
  }

  void changeInformation(String old_card_name,String new_card_name, String new_owner_name_surname, String new_budget) {
    final index = cards.indexWhere((element) => element.card_name == old_card_name);
    cards[index].card_name = new_card_name;
    cards[index].card_budget = new_budget;
    cards[index].owner_name_surname = new_owner_name_surname;
    notifyListeners();
  }
}

final cardsProvider = ChangeNotifierProvider((ref) {
  return CardRepository();
});



class Card {
  String card_name;
  String owner_name_surname;
  String card_budget;

  Card(this.card_name, this.owner_name_surname, this.card_budget);
}