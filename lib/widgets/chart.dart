import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;
  const Chart(this._recentTransactions, {Key? key}) : super(key: key);

  int get totalSpend {
    int total = 0;
    for (var transaction in _recentTransactions) {
      total = total + transaction.amount;
    }
    return total;
  }

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      DateTime weekday = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0;
      for (var i = 0; i < _recentTransactions.length; i++) {
        if (weekday.day == _recentTransactions[i].date.day) {
          totalSum = totalSum + _recentTransactions[i].amount;
        }
      }
      double percentage = totalSpend <= 0 ? 0.0 : totalSum / totalSpend;
      return {
        'day': DateFormat.E().format(weekday),
        'amount': totalSum,
        'percentage': percentage
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransaction
            .map(
              (transaction) => Flexible(
                fit: FlexFit.tight,
                child: ChartBar(transaction),
              ),
            )
            .toList(),
      ),
    );
  }
}
