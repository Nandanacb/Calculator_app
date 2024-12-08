import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var userQuestion = '';
  var userAnswer = '';

  List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 30, 29, 29),
        body: Column(children: [
          SizedBox(height: 50),
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                userQuestion,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 100),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              userAnswer,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white),
            ),
          ),
          SizedBox(height: 70),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                      itemCount: buttons.length,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                userQuestion = '';
                                userAnswer = '';
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      const Color.fromARGB(255, 168, 170, 164)),
                              child: Center(
                                  child: Text(
                                buttons[index],
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              )),
                            ),
                          );
                        } else if (index == 1) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                userQuestion = userQuestion.substring(
                                    0, userQuestion.length - 1);
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      const Color.fromARGB(255, 168, 170, 164)),
                              child: Center(
                                  child: Text(
                                buttons[index],
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              )),
                            ),
                          );
                        } else if (index == buttons.length - 1) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                equalPressed();
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color.fromARGB(255, 234, 159, 46)),
                              child: Center(
                                  child: Text(
                                buttons[index],
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
                              )),
                            ),
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                userQuestion += buttons[index];
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: isOperator(buttons[index])
                                      ? Colors.orange
                                      : Colors.deepPurple[50]),
                              child: Center(
                                  child: Text(
                                buttons[index],
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: isOperator(buttons[index])
                                        ? Colors.white
                                        : Colors.black),
                              )),
                            ),
                          );
                        }
                      })))
        ]));
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '+' || x == '-' || x == '=') {
      return true;
    } else {
      return false;
    }
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
