import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    Transaction(
      id: '1',
      title: 'New Bag',
      amount: 99.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: '2',
      title: 'Monthly Shop',
      amount: 20.65,
      date: DateTime.now(),
    ),
  ];

  void _addingNewTransaction(String transTitle, double transAmount) {
    final newTrans = Transaction(
      id: DateTime.now().toString(),
      title: transTitle,
      amount: transAmount,
      date: DateTime.now(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                child: Text('Chart!!'),
                elevation: 4,
                color: Colors.blue,
              ),
            ),
            TransactionList(_userTransaction),
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
