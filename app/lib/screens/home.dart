import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/transaction.dart';
import '../widgets/expense_dialog.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? transactionList = prefs.getStringList('transactions');
    if (transactionList != null) {
      setState(() {
        transactions = transactionList
            .map((transaction) => Transaction.fromJson(jsonDecode(transaction)))
            .toList();
      });
    }
  }

  Future<void> _saveExpense(Transaction transaction) async {
    Navigator.of(context).pop();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    transactions.add(transaction);

    List<String> transactionList = transactions.map((transaction) {
      return jsonEncode(transaction.toMap());
    }).toList();

    await prefs.setStringList('transactions', transactionList);

    setState(() {});

    // show animation after saving
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Expense added successfully'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _openExpenseDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ExpenseDialog(
          onSave: (amount, note) {
            _saveExpense(Transaction(amount: amount, note: note));
          },
        );
      },
    );
  }

  IconData _getRandomIcon() {
    final List<IconData> icons = [
      Icons.food_bank,
      Icons.shopping_cart,
      Icons.train,
      Icons.local_hospital,
      Icons.home,
      Icons.local_gas_station,
      Icons.fastfood,
      Icons.local_grocery_store,
      Icons.local_laundry_service,
      Icons.local_pharmacy,
      Icons.local_shipping,
      Icons.local_taxi,
      Icons.local_atm,
      Icons.local_bar,
      Icons.local_cafe,
      Icons.local_dining,
      Icons.local_drink,
      Icons.local_florist,
      Icons.local_mall,
      Icons.local_movies,
      Icons.local_offer,
      Icons.local_parking,
      Icons.local_play,
      Icons.local_see,
      Icons.local_printshop,
      Icons.local_post_office,
      Icons.local_printshop,
      Icons.local_pizza,
      Icons.local_police,
      Icons.local_library,
      Icons.local_hotel,
      Icons.local_fire_department,
      Icons.local_convenience_store,
    ];
    return icons[Random().nextInt(icons.length)];
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRI1jWcj1oJKWekoAjIlsLulhheKr-82aDEQw&s',
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(children: [
                    const Text(
                      'Total Expensess',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '₹${transactions.fold<double>(0, (sum, item) => sum + item.amount)}',
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            Expanded(
                child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              top: 20, start: 20, end: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Recent Transactions',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // pull the ExpandableListView
                                  Navigator.pushNamed(context, '/history');
                                },
                                child: const Text(
                                  'View all',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            children: transactions
                                .map((transaction) {
                                  return ListTile(
                                    leading: Icon(
                                      _getRandomIcon(),
                                      size: 30,
                                    ),
                                    title: Text(transaction.note),
                                    subtitle: Text(DateFormat('d MMMM')
                                        .format(transaction.date)),
                                    trailing: Text(
                                      '₹${transaction.amount}',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  );
                                })
                                .toList()
                                .reversed
                                .toList(),
                          ),
                        )
                      ],
                    )))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: 'Profile',
          ),
        ],
        // currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/history');
              break;
            case 2:
              Navigator.pushNamed(context, '/analytics');
              break;
            case 3:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openExpenseDialog,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
