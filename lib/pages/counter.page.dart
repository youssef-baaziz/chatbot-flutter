import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Counter",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Text(
          "Counter =>  $counter",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.remove),
            onPressed: () {
              setState(() {
                this.counter--;
              });
            },
          ),
          SizedBox(
            width: 15,
          ),
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              setState(() {
                this.counter++;
              });
            },
          )
        ],
      ),
    );
  }
}
