import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';
import 'buttons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final colorbut = const Color.fromARGB(255, 207, 208, 209);
  String userinput = "";
  String answer = "";
  String predictedoutput = "";
  String evaluatedexp = "";
  int correctanswer = 0;
  int wronganswer = 0;

  final List<String> buttons = [
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
    '+',
    '3',
    '2',
    '1',
    '-',
    '0',
    '.',
    'ANS',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.deepPurple,
            elevation: 0,
            title: const Text(
              'My Calculator',
              style: TextStyle(),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Center(child: Text('Achienevemets')),
                          content: SingleChildScrollView(
                            child: Column(children: [
                              Text(
                                "Correct predictions\t\t\t" +
                                    correctanswer.toString(),
                                style: const TextStyle(color: Colors.green),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                  "Wrong predictions\t\t\t" +
                                      wronganswer.toString(),
                                  style: const TextStyle(color: Colors.red)),
                            ]),
                          ),
                        );
                      });
                },
                icon: const Icon(Icons.grade),
                iconSize: 30,
              ),
              const Padding(padding: EdgeInsets.all(10))
            ]),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[200],
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        userinput,
                        style: const TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        answer,
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemBuilder: (BuildContext context, index) {
                      if (buttons[index] == "=") {
                        return Button(
                          buttontapped: () {
                            setState(() {
                              equalPressed();
                            });
                          },
                          buttontext: buttons[index],
                          color: Colors.green,
                          textcolor: Colors.black,
                        );
                      } else if (buttons[index] == "C") {
                        return Button(
                          buttontapped: () {
                            setState(() {
                              userinput = "";
                              answer = "";
                            });
                          },
                          buttontext: buttons[index],
                          color: Colors.redAccent,
                          textcolor: Colors.black,
                        );
                      } else if (buttons[index] == "DEL") {
                        return Button(
                          buttontapped: () {
                            setState(() {
                              userinput = userinput.substring(
                                0,
                                userinput.length - 1,
                              );
                            });
                          },
                          buttontext: buttons[index],
                          color: Colors.redAccent,
                          textcolor: Colors.black,
                        );
                      } else if (buttons[index] == "ANS") {
                        return Button(
                          buttontapped: () {
                            setState(() {
                              userinput = answer;
                            });
                          },
                          buttontext: buttons[index],
                          color: Colors.green,
                          textcolor: Colors.black,
                        );
                      } else {
                        return Button(
                          buttontapped: () {
                            setState(() {
                              userinput += buttons[index];
                            });
                          },
                          buttontext: buttons[index],
                          color: isOperator(buttons[index])
                              ? Colors.deepPurple
                              : colorbut,
                          textcolor: isOperator(buttons[index])
                              ? Colors.white
                              : Colors.black,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void equalPressed() {
    String finalinput = userinput;
    finalinput = finalinput.replaceAll("x", "*");
    Parser p = Parser();
    Expression exp = p.parse(finalinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    evaluatedexp = eval.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Predicted Output'),
          content: SingleChildScrollView(
            child: TextField(
              onChanged: (value) {
                predictedoutput;
              },
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                String predictedOutput = predictedoutput;
                if (predictedOutput == evaluatedexp) {
                  correctanswer += 1;
                  setState(() {
                    answer = evaluatedexp;
                  });
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Success'),
                        content: const Text('The predicted output is correct.'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  correctanswer += 1;
                  setState(() {
                    answer = evaluatedexp;
                  });
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Success',
                            style: TextStyle(
                              color: Colors.green,
                            )),
                        content: const Text('The predicted output is correct.'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
some new changes
  bool isOperator(String x) {
    if (x == "%" || x == "/" || x == "+" || x == "-" || x == "x" || x == "=") {
      return true;
    } else {
      return false;
    }
  }
}
