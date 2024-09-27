import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/transaction.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Searching',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
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
                            subtitle: Text(
                                DateFormat('d MMMM').format(transaction.date)),
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
                ),
              ],
            )),
      ),
    );
  }
}
