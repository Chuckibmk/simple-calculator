// import 'dart:ui';

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
  var scaffoldkey = GlobalKey<ScaffoldState>();

  final ques = TextEditingController();
  final hisctrl = TextEditingController();

  List<List<dynamic>> calculator_varibles = [
    ['%', 'CE', 'C', '\u232B'],
    ['1/x', 'x²', '√x', '÷'],
    ['7', '8', '9', 'x'],
    ['4', '5', '6', '-'],
    ['1', '2', '3', '+'],
    ['±', '0', '.', '=']
  ];

  List<Map<String, String>> history = [];

  dynamic eqn = '';
  dynamic ans = '';
  num currentValue = 0;
  dynamic operator = '';
  bool isNewOperation = true;

  void addHistory(String question, String answer) {
    history.add({'question': question, 'answer': answer});
  }

  void emptyHistory() {
    history.clear();
  }

  num nextValue = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      Size size = MediaQuery.of(context).size;
      return Scaffold(
        key: scaffoldkey,
        appBar: AppBar(
            title: const Text('Calculator'),
            centerTitle: true,
            actions: [
              Builder(
                  builder: (context) => IconButton(
                        icon: const Icon(Icons.history),
                        onPressed: () {
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
              Flexible(child: anshis()),
              yspace(),
              history.isEmpty
                  ? SizedBox()
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
                  for (var rw in calculator_varibles)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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

  Widget anshis() {
    history.isEmpty
        ? const SizedBox(
            height: 100,
            child: DrawerHeader(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                // decoration: BoxDecoration(color: Colors.blue),
                child: Text("There's no history yet",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ))),
          )
        : null;

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
