import 'package:flutter/material.dart';

class ExpenseDialog extends StatelessWidget {
  final Function(double amount, String note) onSave;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  ExpenseDialog({required this.onSave, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                      elevation: 0),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            Column(children: <Widget>[
              const Text('Add Expenses'),
              TextField(
                controller: _amountController,
                autofocus: true,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 45),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: '0',
                  border: InputBorder.none,
                ),
              ),
              Container(
                width: 140,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 180, 177, 182),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _noteController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'Add a note',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.centerRight,
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                    ),
                    onPressed: () {
                      double amount = double.parse(_amountController.text);
                      String note = _noteController.text;
                      onSave(amount, note);
                      _amountController.clear();
                      _noteController.clear();
                    },
                    child: const Icon(Icons.arrow_forward),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
