import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData.dark(),
      home: CalculatorSc(),
    );
  }
}

class CalculatorSc extends StatefulWidget {
  @override
  State<CalculatorSc> createState() => _CalculatorScState();
}

class _CalculatorScState extends State<CalculatorSc> {
  String userInput = "";
  String result = "0";

  List<List<String>> buttonRows = [
    ['7', '8', '9', '/'],
    ['4', '5', '6', '*'],
    ['1', '2', '3', '-'],
    ['0', 'AC', '.', '='],
    ['+', 'C'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF006400),
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Color(0xFF008000),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerRight,
                    child: Text(
                      result,
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(color: Colors.white),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: buttonRows.map((row) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: row.map((value) {
                      return customButton(value);
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customButton(String value) {
    return Expanded(
      child: ElevatedButton(
        
        style: ElevatedButton.styleFrom(
          foregroundColor: getColor(value), backgroundColor: getBgColor(value),
        ),
        onPressed: () => handleButtons(value),
        child: Text(
          value,
          style: TextStyle(
            fontSize: value == 'AC' || value == '.' ? 20.0 : 24.0,
            color: getColor(value),
          ),
        ),
      ),
    );
  }

  Color getColor(String text) {
    if (_isOperator(text)) {
      return Color(0xFF00ff00);
    }
    return Colors.white;
  }

  Color getBgColor(String text) {
    if (text == 'C' || text == 'AC') {
      return Color(0xFF00ff00);
    }
    return Color(0xFF008000);
  }

  void handleButtons(String text) {
    if (text == 'AC') {
      setState(() {
        userInput = '';
        result = '0';
      });
    } else if (text == 'C') {
      setState(() {
        userInput = userInput.isNotEmpty ? userInput.substring(0, userInput.length - 1) : '';
        result = '0';
      });
    } else if (text == '=') {
      setState(() {
        result = evaluateExpression();
        userInput = result;
      });
    } else {
      setState(() {
        userInput += text;
      });
    }
  }

  String evaluateExpression() {
    try {
      var parser = Parser();
      var expression = parser.parse(userInput);
      var context = ContextModel();
      var evaluation = expression.evaluate(EvaluationType.REAL, context);
      return evaluation.toString();
    } catch (e) {
      return 'Error';
    }
  }

  bool _isOperator(String value) {
    return value == '/' || value == '*' || value == '+' || value == '-';
  }
}
