// import 'dart:ui';

// import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'dart:math';

// import 'package:flutter/widgets.dart';

class BasicCalcClass extends StatefulWidget {
  const BasicCalcClass({super.key});

  @override
  State<BasicCalcClass> createState() => _BasicCalcClassState();
}

class _BasicCalcClassState extends State<BasicCalcClass> {
  //scaffold variable for drawer control, stores the state of the drawer
  var scaffoldkey = GlobalKey<ScaffoldState>();

  //variables for question and History textcontroller
  final ques = TextEditingController();
  final hisctrl = TextEditingController();

  //dynamic List containing calculator symbols used for buttons,
  // note there're Lists inside the main List
  List<List<dynamic>> calculator_Varibles = [
    ['%', 'CE', 'C', '\u232B'],
    ['1/x', 'x²', '√x', '÷'],
    ['7', '8', '9', 'x'],
    ['4', '5', '6', '-'],
    ['1', '2', '3', '+'],
    ['±', '0', '.', '=']
  ];

  // List map used to store calculated history, where a map accepts two strings(equation and answer) and the map is arranged in a list
  List<Map<String, String>> history = [];

  //variable containing current eqn
  dynamic eqn = '';

  // variable containing current ans
  dynamic ans = '';

  // variable to hold current value from textform
  num currentValue = 0;

  // variable to hold next value from textform after operator click
  num nextValue = 0;

  // variable containing operator
  dynamic operator = '';

  // bool variable to check if a new operation started
  bool isNewOperation = true;

  // void method to add two strings(Map) to history List
  void addHistory(String question, String answer) {
    history.add({'question': question, 'answer': answer});
  }

  // void method to clear history List
  void emptyHistory() {
    history.clear();
  }

  ThemeMode _themeMode = ThemeMode.system;

  void _toggkeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(builder: (context, constraints) {
      Size size = MediaQuery.of(context).size;
      return Scaffold(
        key: scaffoldkey,
        appBar: AppBar(
            title: const Text('Calculator'),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Switch(
                  value: isDarkMode,
                  onChanged: (isOn) {
                    isOn
                        ? _toggkeTheme(ThemeMode.dark)
                        : _toggkeTheme(ThemeMode.light);
                  },
                );
              },
            ),
            actions: [
              Builder(
                  builder: (context) => IconButton(
                        icon: const Icon(Icons.history),
                        onPressed: () {
                          // use of scaffold variable store state after openEndDrawer
                          scaffoldkey.currentState?.openEndDrawer();
                        },
                        tooltip: MaterialLocalizations.of(context)
                            .openAppDrawerTooltip,
                      ))
            ]),
        endDrawer: Drawer(
          child: Column(
            // padding: EdgeInsets.zero,
            children: [
              // flexible container with child of History answer widget
              Flexible(child: anshis()),
              // yspace(),
              history.isEmpty
                  ? const SizedBox(
                      child: DrawerHeader(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: Text("There's no history yet",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              ))),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        xspace(),
                        IconButton(
                            iconSize: 30,
                            onPressed: () {
                              setState(() {
                                emptyHistory();
                              });
                            },
                            icon: const Icon(Icons.delete_forever))
                      ],
                    ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                height: size.height / 3,
                child: Column(children: [
                  TextFormField(
                    controller: hisctrl,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 35),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "",
                    ),
                    enableInteractiveSelection: false,
                    readOnly: true,
                    showCursor: false,
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.none,
                  ),
                  TextFormField(
                    controller: ques,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 40),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      // hintText: "0",
                    ),
                    enableInteractiveSelection: false,
                    readOnly: true,
                    showCursor: false,
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.none,
                  ),
                ])),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              height: size.height / 2,
              child: Column(
                children: [
                  // yspace(),
                  // loop through the Lists in the calculator_Varibles List, in order to get the arrangement
                  for (var rw in calculator_Varibles)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // loop through the Strings in each list and calling the calcbtn method to show each button
                        for (var label in rw) calcbtn(label),
                      ],
                    ),
                ],
              ),
            )
          ]),
        ),
      );
    });
  }

  Widget yspace() {
    return const SizedBox(
      height: 10,
    );
  }

  Widget xspace() {
    return const SizedBox(
      width: 10,
    );
  }

  //void calculate method that handles basic calculation logic
  void calculate() {
    setState(() {
      nextValue = num.tryParse(eqn) ?? 0;
      dynamic question = '$currentValue $operator $nextValue'.toString();
      if (operator == '+') {
        currentValue += nextValue;
      } else if (operator == '-') {
        currentValue -= nextValue;
      } else if (operator == 'x') {
        currentValue *= nextValue;
      } else if (operator == '÷') {
        if (nextValue != 0) {
          currentValue /= nextValue;
        } else {
          ans = "Cannot Divide by Zero";
          ques.text = ans;
          return;
        }
      }
      addHistory(question, currentValue.toString());
      ans = currentValue.toString();
      ques.text = ans;
      hisctrl.text = question;
      eqn = ans;
      operator = '';
      isNewOperation = true;
    });
  }

  //void evaluate method that handles basic evaluation Logic
  void evaluate() {
    setState(() {
      dynamic question = '$operator $currentValue'.toString();
      if (operator == '±') {
        currentValue = -1 * currentValue;
      } else if (operator == '1/x') {
        currentValue = 1 / currentValue;
      } else if (operator == 'x²') {
        currentValue = pow(currentValue, 2);
      } else if (operator == '√x') {
        currentValue = sqrt(currentValue);
        if (currentValue.toString() == 'NaN') {
          ans = 'Invalid Input';
          ques.text = ans;
          return;
        }
      }
      addHistory(question, currentValue.toString());
      ans = currentValue.toString();
      ques.text = ans;
      hisctrl.text = question;
      eqn = ans;
      operator = '';
      isNewOperation = false;
    });
  }

  // Answers history widget
  Widget anshis() {
    return ListView.builder(
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: history.length,
        itemBuilder: (context, index) {
          var entry = history[index];
          return ListTile(
            onTap: () {
              setState(() {
                hisctrl.text = entry['question'] ?? '';
                ques.text = entry['answer'] ?? '';
                eqn = entry['answer'] ?? '';
              });
              Navigator.pop(context);
            },
            title: Text(
              entry['question'] ?? '',
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
            subtitle: Text(
              entry['answer'] ?? '',
              style: const TextStyle(
                fontSize: 40,
              ),
            ),
          );
        });
  }

  // method for the button and calculation logic after onpress
  calcbtn(dynamic btnText) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      height: 50,
      width: 95,
      child: ElevatedButton(
          // child: InkWell(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: const BorderSide(color: Colors.black))),
          ),
          onPressed: () {
            setState(() {
              if (btnText == 'C') {
                eqn = '';
                ans = '';
                currentValue = 0;
                operator = '';
                ques.clear();
                hisctrl.clear();
                isNewOperation = true;
              } else if (btnText == 'CE') {
                eqn = '';
                ques.clear();
              } else if (btnText == '\u232B') {
                if (eqn.isNotEmpty) {
                  eqn = eqn.substring(0, eqn.length - 1);
                  ques.text = eqn;
                }
              } else if (btnText == '=') {
                if (operator.isNotEmpty && eqn.isNotEmpty) {
                  calculate();
                }
              } else if (['+', '-', 'x', '÷'].contains(btnText)) {
                if (operator.isNotEmpty) {
                  calculate();
                }
                if (eqn.isNotEmpty) {
                  currentValue = num.tryParse(eqn) ?? 0;
                  operator = btnText;
                  hisctrl.text = '$currentValue $operator';
                  eqn = '';
                  ques.clear();
                } else if (ans.isNotEmpty) {
                  currentValue = num.tryParse(ans) ?? 0;
                  operator = btnText;
                  hisctrl.text = '$currentValue $operator';
                  eqn = '';
                  ques.clear();
                }
              } else if (['1/x', 'x²', '√x', '±'].contains(btnText)) {
                operator = btnText;
                currentValue = num.tryParse(eqn) ?? 0;
                hisctrl.text = '$operator $currentValue';
                evaluate();
                // eqn = '';
                // ques.text = eqn;
              } else {
                if (isNewOperation) {
                  eqn = '';
                  isNewOperation = false;
                }
                eqn += btnText;
                ques.text = eqn;
              }
            });
          },
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Text(
                btnText,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ))),
    );
  }
}
