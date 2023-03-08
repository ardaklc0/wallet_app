import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet_app/main.dart';
import 'package:wallet_app/pages/analysis_page.dart';
import 'package:wallet_app/repositories/card_repository.dart';


class AddAccount extends ConsumerStatefulWidget {
  const AddAccount({Key? key}) : super(key: key);

  @override
  _AddAccountState createState() => _AddAccountState();
}

class _AddAccountState extends ConsumerState<AddAccount> {
  int _selectedIndex = 1;
  TextEditingController card_name_controller = TextEditingController();
  TextEditingController owner_name_surname_controller = TextEditingController();
  TextEditingController card_budget_controller = TextEditingController();
  
  @override
  void initState() {
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
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          return _goToMainPage(context);
        case 1:
          return _goToAddAccountPage(context);
        case 2:
          return _goToAnalysisPage(context);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Homepage"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "Add Account"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.auto_graph),
              label: "Analysis"
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        onTap: _onItemTapped,
      ),
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Enter your card name",
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
                  hintText: "Enter your name and surname",
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
                  hintText: "Enter the amount of money",
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
                  ref.read(cardsProvider).addAccount(
                    card_name_controller.text, owner_name_surname_controller.text, card_budget_controller.text
                  );
                  _goToMainPage(context);
                },
                child: Text("Finish")
              ),
            )
          ],
        ),
      )
    );
  }
}

void _goToMainPage(BuildContext context) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
    return const MyApp();
  }));
}

void _goToAddAccountPage(BuildContext context) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
    return const AddAccount();
  }));
}

void _goToAnalysisPage(BuildContext context) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
    return const Analysis();
  }));
}
