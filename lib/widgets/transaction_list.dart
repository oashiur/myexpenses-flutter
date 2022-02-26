import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransaction;
  final void Function(int) _deleteHandler;
  const TransactionList(this._userTransaction, this._deleteHandler, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _userTransaction.isEmpty ? Image.asset('assets/images/empty.png') : ListView.builder(
            itemCount: _userTransaction.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 4, right: 4, top: 1, bottom: 1),
                child: Card(
                  elevation: 1.5,
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Container(
                          height: 45,
                          width: 65,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.purple, width: 1.5),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              '\u09F3' +
                                  _userTransaction[index].amount.toString(),
                              style: const TextStyle(
                                  color: Colors.purple,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _userTransaction[index].title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                              ),
                              Text(
                                DateFormat('dd/MM/yyyy')
                                    .format(_userTransaction[index].date),
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () =>
                              _deleteHandler(_userTransaction[index].id),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
  }
}
