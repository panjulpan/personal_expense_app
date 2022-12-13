import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        errorColor: Colors.red,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        // textTheme: ThemeData.light().textTheme.copyWith(
        //       titleLarge: TextStyle(
        //         fontFamily: 'OpenSans',
        //         fontWeight: FontWeight.bold,
        //         fontSize: 18,
        //       ),
        //       button: TextStyle(
        //         color: Colors.white,
        //       ),
        //     ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: '1',
    //   title: 'New Bag',
    //   amount: 99.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '2',
    //   title: 'Monthly Shop',
    //   amount: 20.65,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTrans {
    return _userTransaction.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addingNewTransaction(
      String transTitle, double transAmount, DateTime chosenDate) {
    final newTrans = Transaction(
      id: DateTime.now().toString(),
      title: transTitle,
      amount: transAmount,
      date: chosenDate,
    );

    setState(() {
      _userTransaction.add(newTrans);
    });
  }

  void _openInputModal(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: NewTransaction(_addingNewTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTrans(String id) {
    setState(() {
      _userTransaction.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            onPressed: () => _openInputModal(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Chart(_recentTrans),
            TransactionList(_userTransaction, _deleteTrans),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openInputModal(context),
      ),
    );
  }
}
