import 'package:flutter/material.dart';
import './chart_bar.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTrans;

  Chart(this.recentTrans);

  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalAmount = 0.0;

      for (var i = 0; i < recentTrans.length; i++) {
        if (recentTrans[i].date.day == weekDay.day &&
            recentTrans[i].date.month == weekDay.month &&
            recentTrans[i].date.year == weekDay.year) {
          totalAmount += recentTrans[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmount,
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactionValues.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                e['day'],
                e['amount'],
                maxSpending == 0.0
                    ? 0.0
                    : (e['amount'] as double) / maxSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
