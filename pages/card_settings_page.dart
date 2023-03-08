import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet_app/main.dart';
import 'package:wallet_app/repositories/card_repository.dart';
import 'package:wallet_app/repositories/transaction_repository.dart';
import 'package:intl/intl.dart';


class CardSettings extends ConsumerStatefulWidget {
  String card_name;
  String card_budget;
  String owner_name_surname;
  CardSettings(this.card_name, this.card_budget, this.owner_name_surname, {Key? key}) : super(key: key);

  @override
  _CardSettingsState createState() => _CardSettingsState();
}

class _CardSettingsState extends ConsumerState<CardSettings> {
  TextEditingController card_name_controller = TextEditingController();
  TextEditingController owner_name_surname_controller = TextEditingController();
  TextEditingController card_budget_controller = TextEditingController();

  @override
  void initState() {
    card_name_controller.text = widget.card_name;
    card_budget_controller.text = widget.card_budget;
    owner_name_surname_controller.text = widget.owner_name_surname;
    super.initState();
  }

  @override
  void dispose() {
    card_name_controller.dispose();
    owner_name_surname_controller.dispose();
    card_budget_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0)
                  ),
                ),
                controller: card_name_controller,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0)
                  ),
                ),
                controller: owner_name_surname_controller,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0)
                  ),
                ),
                controller: card_budget_controller,
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
                      ref.watch(cardsProvider).changeInformation(
                          widget.card_name,
                          card_name_controller.text,
                          owner_name_surname_controller.text,
                          card_budget_controller.text
                      );
                    });
                    _goToMainPage(context);
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


void _goToMainPage(BuildContext context) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
    return const MyApp();
  }));
}