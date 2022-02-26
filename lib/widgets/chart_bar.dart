import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final Map<String, Object> transaction;
  const ChartBar(this.transaction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.12,
                child: FittedBox(child: Text(transaction['day'].toString())),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.02,
              ),
              SizedBox(
                height: constraints.maxHeight * 0.7,
                width: MediaQuery.of(context).size.width * 0.06,
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: transaction['percentage'] as double,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.purple,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.02,
              ),
              SizedBox(
                height: constraints.maxHeight * 0.14,
                child: FittedBox(
                  child: Text(
                    '\u09F3' + transaction['amount'].toString(),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
