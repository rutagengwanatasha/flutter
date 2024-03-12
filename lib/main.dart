import 'package:flutter/material.dart';
import 'Natasha/NavBar.dart'; 
import 'Natasha/CalculatorSc.dart';
void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NatMIS'),
        shadowColor: const Color.fromARGB(255, 228, 158, 153),
      ),
      drawer: NavBar(),
    );
  }
}
