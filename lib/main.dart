import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _display = '';
  double _firstOperand = 0;
  double _secondOperand = 0;
  String _operator = '';
  bool _isSecondOperand = false;

  void _onDigitPress(String digit) {
    setState(() {
      _display += digit;
      if (_isSecondOperand) {
        _secondOperand = double.tryParse(_display.split(_operator).last) ?? 0;
      } else {
        _firstOperand = double.tryParse(_display) ?? 0;
      }
    });
  }

  void _onOperatorPress(String operator) {
    setState(() {
      if (_operator.isEmpty || !_isSecondOperand) {
        _operator = operator;
        _display += operator;
        _isSecondOperand = true;
      } else {
        _calculate();
        _operator = operator;
        _display = '$_firstOperand$operator';
      }
    });
  }

  void _calculate() {
    double result;
    switch (_operator) {
      case '+':
        result = _firstOperand + _secondOperand;
        break;
      case '-':
        result = _firstOperand - _secondOperand;
        break;
      case '*':
        result = _firstOperand * _secondOperand;
        break;
      case '/':
        result = _firstOperand / _secondOperand;
        break;
      default:
        return;
    }
    setState(() {
      _display = result.toString();
      _firstOperand = result;
      _isSecondOperand = false;
      _operator = '';
    });
  }

  void _onClearPress() {
    setState(() {
      _display = '';
      _firstOperand = 0;
      _secondOperand = 0;
      _operator = '';
      _isSecondOperand = false;
    });
  }

  Widget _buildButton(String text, {Color color = Colors.grey}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: EdgeInsets.all(24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            if (text == 'C') {
              _onClearPress();
            } else if (text == '+' || text == '-' || text == '*' || text == '/') {
              _onOperatorPress(text);
            } else if (text == '=') {
              _calculate();
            } else {
              _onDigitPress(text);
            }
          },
          child: Text(
            text,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            alignment: Alignment.centerRight,
            child: Text(
              _display,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(thickness: 1, color: Colors.black),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('/', color: Colors.orange),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('*', color: Colors.orange),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('-', color: Colors.orange),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('0'),
                    _buildButton('C', color: Colors.red),
                    _buildButton('=', color: Colors.green),
                    _buildButton('+', color: Colors.orange),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
