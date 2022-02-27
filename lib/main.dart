import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Expenses',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(secondary: Colors.amber),
        fontFamily: 'OpenSans',
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransactions {
    return _userTransactions
        .where(
          (transaction) => transaction.date.isAfter(
            DateTime.now().subtract(
              const Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  void _sortList() {
    _userTransactions.sort((a, b) => b.date.compareTo(a.date));
  }

  final AppBar _appBar = AppBar(
    title: const Text('My Expenses'),
  );

  void addButtonPress() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewTransaction(_userTransactions, _addTransaction);
      },
    );
  }

  void _addTransaction(Transaction transaction) {
    setState(() {
      _userTransactions.add(transaction);
      Navigator.pop(context);
    });
  }

  void _deteleTransaction(int id) {
    setState(() {
      _userTransactions.removeWhere((data) => data.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    _sortList();
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double displaySize = mediaQuery.size.height -
        mediaQuery.padding.top -
        _appBar.preferredSize.height -
        2;
    return Scaffold(
      appBar: _appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 4, right: 4, left: 4),
            child: Column(
              children: [
                SizedBox(
                  height: displaySize * 0.3,
                  child: Chart(_recentTransactions),
                ),
                const SizedBox(
                  height: 2,
                ),
                SizedBox(
                  height: displaySize * 0.7,
                  child: TransactionList(_userTransactions, _deteleTransaction),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addButtonPress,
        child: const Icon(Icons.add),
      ),
    );
  }
}
