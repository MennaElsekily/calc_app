import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String result = "0";
  String finalresult = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String opr = '';

  void buttonpressed(String btnval) {
    if (btnval == "C") {
      result = "0";
      finalresult = "0";
      num1 = 0.0;
      num2 = 0.0;
      opr = '';
    } else if (btnval == "+" || btnval == "-" || btnval == "X" || btnval == "÷") {
      num1 = double.tryParse(finalresult) ?? 0.0;
      opr = btnval;

      if (result == "0") {
        result = finalresult + ' $opr ';
      } else {
        result += finalresult + ' $opr ';
      }

      finalresult = "0";
    } else if (btnval == ".") {
      if (!finalresult.contains('.')) {
        finalresult += btnval;
        if (result == "0") {
          result = finalresult;
        } else {
          result += btnval;
        }
      }
    } else if (btnval == "±") {
      if (finalresult.startsWith('-')) {
        finalresult = finalresult.substring(1);
      } else if (finalresult != "0") {
        finalresult = '-' + finalresult;
      }

      int lastSpace = result.lastIndexOf(' ');
      if (lastSpace == -1) {
        result = finalresult;
      } else {
        result = result.substring(0, lastSpace + 1) + finalresult;
      }
    } else if (btnval == "%") {
      num2 = double.tryParse(finalresult) ?? 0.0;
      finalresult = (num2 / 100).toStringAsFixed(4);

      int lastSpace = result.lastIndexOf(' ');
      if (lastSpace == -1) {
        result = finalresult;
      } else {
        result = result.substring(0, lastSpace + 1) + finalresult;
      }
    } else if (btnval == "=") {
      num2 = double.tryParse(finalresult) ?? 0.0;

      if (opr == "+") {
        finalresult = (num1 + num2).toStringAsFixed(4);
      } else if (opr == "-") {
        finalresult = (num1 - num2).toStringAsFixed(4);
      } else if (opr == "X") {
        finalresult = (num1 * num2).toStringAsFixed(4);
      } else if (opr == "÷") {
        if (num2 == 0) {
          finalresult = "Error";
        } else {
          finalresult = (num1 / num2).toStringAsFixed(4);
        }
      }

      result = result + finalresult;
      opr = '';
    } else {
      if (finalresult == "0") {
        finalresult = btnval;
      } else {
        finalresult += btnval;
      }

      if (result == "0") {
        result = finalresult;
      } else {
        result += btnval;
      }
    }

    setState(() {
      // Just update UI, variables already set above
    });
  }

  Widget buttonform(String buttontxt, Color buttonclr, Color textclr) {
    if (buttontxt != "0") {
      return ElevatedButton(
        onPressed: () {
          buttonpressed(buttontxt);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonclr,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        ),
        child: Text(
          buttontxt,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: textclr,
          ),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          buttonpressed(buttontxt);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonclr,
          padding: const EdgeInsets.fromLTRB(15, 14, 130, 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Text(
          buttontxt,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: textclr,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      result,
                      style: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      finalresult,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buttonform("C", const Color.fromARGB(255, 146, 161, 176), Colors.black),
                          buttonform("±", const Color.fromARGB(255, 146, 161, 176), Colors.black),
                          buttonform("%", const Color.fromARGB(255, 146, 161, 176), Colors.black),
                          buttonform("÷", const Color.fromARGB(255, 146, 161, 176), Colors.deepPurple),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buttonform("7", const Color.fromARGB(255, 146, 161, 176), Colors.black),
                          buttonform("8", const Color.fromARGB(255, 146, 161, 176), Colors.black),
                          buttonform("9", const Color.fromARGB(255, 146, 161, 176), Colors.black),
                          buttonform("X", const Color.fromARGB(255, 146, 161, 176), Colors.deepPurple),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buttonform("4", const Color.fromARGB(255, 146, 161, 176), Colors.black),
                          buttonform("5", const Color.fromARGB(255, 146, 161, 176), Colors.black),
                          buttonform("6", const Color.fromARGB(255, 146, 161, 176), Colors.black),
                          buttonform("-", const Color.fromARGB(255, 146, 161, 176), Colors.deepPurple),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buttonform("1", const Color.fromARGB(255, 146, 161, 176), Colors.black),
                          buttonform("2", const Color.fromARGB(255, 146, 161, 176), Colors.black),
                          buttonform("3", const Color.fromARGB(255, 146, 161, 176), Colors.black),
                          buttonform("+", const Color.fromARGB(255, 146, 161, 176), Colors.deepPurple),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buttonform("0", const Color.fromARGB(255, 146, 161, 176), Colors.black),
                          buttonform(".", const Color.fromARGB(255, 146, 161, 176), Colors.black),
                          buttonform("=", const Color.fromARGB(255, 66, 191, 71), Colors.white),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
