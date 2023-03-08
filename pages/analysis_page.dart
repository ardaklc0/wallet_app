import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet_app/main.dart';
import 'package:wallet_app/pages/add_account_page.dart';

class Analysis extends ConsumerStatefulWidget {
  const Analysis({Key? key}) : super(key: key);

  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends ConsumerState<Analysis> {
  int _selectedIndex = 2;
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Available Soon",
                style: TextStyle(
                  fontSize: 40
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
