import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class NewTransaction extends StatefulWidget {
  final List<Transaction> _userTransactions;
  final void Function(Transaction) _addHandler;
  const NewTransaction(this._userTransactions, this._addHandler, {Key? key})
      : super(key: key);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _amountEditingController =
      TextEditingController();
  final DateTime _today = DateTime.now();
  final int _date = DateTime.now().day;
  DateTime _pickedDate = DateTime.now();

  void _datePicker() {
    showDatePicker(
            context: context,
            initialDate: _today,
            firstDate: DateTime(DateTime.now().year - 1),
            lastDate: _today,
            confirmText: 'PICK',
            helpText: 'DATE OF TRANSACTION',
            fieldLabelText: 'HI')
        .then((date) {
      if (date == null) {
        return;
      } else {
        setState(() {
          _pickedDate = date;
        });
      }
    });
  }

  void _addTransaction() {
    String _title = _textEditingController.text;
    dynamic _amount = _amountEditingController.text;
    if (_amount.isNotEmpty) {
      _amount = int.parse(_amount);
    }
    if (_title.isNotEmpty && _amount > 0) {
      Transaction _newTransaction = Transaction(
        id: widget._userTransactions.isEmpty
            ? 1
            : widget._userTransactions.last.id + 1,
        title: _textEditingController.text,
        amount: int.parse(_amountEditingController.text),
        date: _pickedDate,
      );

      widget._addHandler(_newTransaction);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(hintText: 'Title'),
            textInputAction: TextInputAction.next,
          ),
          TextField(
            onEditingComplete: _addTransaction,
            //onSubmitted: _addTransaction,
            controller: _amountEditingController,
            decoration: const InputDecoration(hintText: 'Amount'),
            keyboardType: TextInputType.number,

          ),
          Row(
            children: [
              _pickedDate.day == _date
                  ? const Text(
                      'today',
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )
                  : Text(
                      'Picked Date: ${DateFormat('dd/MM/yyyy').format(_pickedDate)}',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
              const Spacer(),
              TextButton(
                onPressed: _datePicker,
                child: const Text(
                  'Choose Date',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: _addTransaction,
            child: const Text(
              'Add',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
