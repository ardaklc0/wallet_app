import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet_app/repositories/card_repository.dart';
import 'package:wallet_app/repositories/transaction_repository.dart';
import 'package:intl/intl.dart';


class TransactionSettings extends ConsumerStatefulWidget {
  final index;
  final amount;
  final transaction_name;
  final expense_date;
  String transacted_card;

  TransactionSettings(this.index, this.amount, this.transaction_name, this.expense_date, this.transacted_card, {Key? key}) : super(key: key);

  @override
  _TransactionSettingsState createState() => _TransactionSettingsState();
}

class _TransactionSettingsState extends ConsumerState<TransactionSettings> {
  TextEditingController amount_controller = TextEditingController();
  TextEditingController transaction_name_controller = TextEditingController();
  TextEditingController transacted_card_name = TextEditingController();
  TextEditingController expense_date = TextEditingController();
  String? dropDownValue = CardRepository().takeListOfCards().first.card_name;

  @override
  void initState() {
    amount_controller.text = widget.amount;
    transaction_name_controller.text = widget.transaction_name;
    transacted_card_name.text = widget.transacted_card;

    super.initState();
  }

  @override
  void dispose() {
    amount_controller.dispose();
    transaction_name_controller.dispose();
    transacted_card_name.dispose();
    expense_date.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardRepository = ref.watch(cardsProvider);
    final transactionRepository = ref.watch(transactionProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Please add amount',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0)
                  ),
                ),
                controller: amount_controller,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Please add expense name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0)
                  ),
                ),
                controller: transaction_name_controller,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: DropdownButton<String>(
                  value: dropDownValue,
                  items: cardRepository.cards.map((value) {
                    return DropdownMenuItem<String>(
                        value: value.card_name,
                        child: Text(value.card_name)
                    );
                  }).toList() ,
                  onChanged: (newValue) {
                    setState(() {
                      dropDownValue = newValue;
                      transacted_card_name.text = dropDownValue!;
                    });
                  }
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextField(
                controller: expense_date,
                //editing controller of this TextField
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Enter Date" //label text of field
                ),
                readOnly: true,
                //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2100));

                  if (pickedDate != null) {
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate).replaceAll("-", ".");
                    setState(() {
                      expense_date.text = formattedDate;
                    });
                  } else {}
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      )
                  ),
                  onPressed: () {
                    setState(() {
                      transactionRepository.changeTransaction(
                          widget.index,
                          amount_controller.text,
                          transaction_name_controller.text,
                          DateTime.parse(expense_date.text.replaceAll(".", "-")),
                          transacted_card_name.text
                      );
                    });
                  },
                  child: Text("Finish")
              ),
            )
          ],
        ),
      ),
    );
  }
}



