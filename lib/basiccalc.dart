// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:math';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

class BasicCalcClass extends StatefulWidget {
  final VoidCallback toggleTheme;
  // final BannerAd bannerAd;
  const BasicCalcClass({
    super.key,
    required this.toggleTheme,
    // required this.bannerAd
  });

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

  @override
  Widget build(BuildContext context) {
    // Get the insets from MediaQuery
    EdgeInsets padding = MediaQuery.of(context).viewPadding;
    // Remove the top padding
    padding = padding.copyWith(top: 0);
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        key: scaffoldkey,
        endDrawer: Drawer(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.zero,
              bottomLeft: Radius.zero,
            ),
          ),
          child: Column(
            // padding: EdgeInsets.zero,
            children: [
              // flexible container with child of History answer widget
              Flexible(
                child: anshis(),
              ),

              history.isEmpty
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Text(
                          "There's no history yet",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Trajan Pro'),
                        ),
                      ),
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
        // use SafeArea
        body: Padding(
          padding: padding,
          child: Column(children: [
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
            // child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      shape: BoxShape.circle),
                  child: IconButton(
                    icon: const Icon(Icons.toggle_on),
                    onPressed: () {
                      widget.toggleTheme();
                    },
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Calculator",
                    style: TextStyle(
                        fontFamily: 'Trajan Pro',
                        color: Theme.of(context).colorScheme.onSurface,
                        // color: Color(0xff7C797A),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      // color: Color(0xffF8FAFB),
                      shape: BoxShape.circle),
                  child: Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.history),
                      onPressed: () {
                        // use of scaffold variable store state after openEndDrawer
                        scaffoldkey.currentState?.openEndDrawer();
                      },
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                    ),
                  ),
                )
              ],
            ),
            // ),
            Expanded(
              flex: 1,
              // child: Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 1.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: hisctrl,
                    maxLines: 1,
                    style:
                        const TextStyle(fontSize: 30, fontFamily: 'Trajan Pro'),
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
                    style:
                        const TextStyle(fontSize: 30, fontFamily: 'Trajan Pro'),
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
                ],
              ),
              // ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
              ),
            ),
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
      dynamic question;
      if (operator == '+') {
        question = '$currentValue $operator $nextValue'.toString();
        currentValue += nextValue;
      } else if (operator == '-') {
        question = '$currentValue $operator $nextValue'.toString();
        currentValue -= nextValue;
      } else if (operator == 'x') {
        question = '$currentValue $operator $nextValue'.toString();
        currentValue *= nextValue;
      } else if (operator == '÷') {
        question = '$currentValue $operator $nextValue'.toString();
        if (nextValue != 0) {
          currentValue /= nextValue;
        } else {
          ans = "Cannot Divide by Zero";
          ques.text = ans;
          return;
        }
      } else {
        question = '$currentValue'.toString();
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
  void evaluate(operator) {
    setState(() {
      dynamic question;
      if (operator == '±') {
        hisctrl.text = '- $currentValue';
        question = '(- $currentValue)'.toString();

        currentValue = -currentValue;
      } else if (operator == '1/x') {
        if (currentValue != 0) {
          hisctrl.text = '1/ $currentValue';
          question = '1/ $currentValue'.toString();

          currentValue = 1 / currentValue;
        } else {
          ans = 'Cannot Divide by Zero';
          ques.text = ans;
          return;
        }
      } else if (operator == 'x²') {
        hisctrl.text = '$currentValue ²';
        question = '$currentValue ²'.toString();

        currentValue = pow(currentValue, 2);
      } else if (operator == '√x') {
        hisctrl.text = '√ $currentValue';
        question = '√ $currentValue'.toString();

        currentValue = sqrt(currentValue);
        if (currentValue.toString() == 'NaN') {
          ans = 'Invalid Input';
          ques.text = ans;
          return;
        }
      } else if (operator == '%') {
        hisctrl.text = '$currentValue %';
        question = '$currentValue %'.toString();

        currentValue = currentValue / 100;
      }
      addHistory(question, currentValue.toString());
      ans = currentValue.toString();
      ques.text = ans;
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
                fontFamily: 'Trajan Pro',
                fontSize: 20,
              ),
            ),
            subtitle: Text(
              entry['answer'] ?? '',
              style: const TextStyle(fontSize: 30, fontFamily: 'Trajan Pro'),
            ),
          );
        });
  }

  // method for the button and calculation logic after onpress
  calcbtn(dynamic btnText) {
    // Get the screen width and height
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate the button size based on screen size
    double buttonHeight = screenHeight * 0.08; // 10% of screen height

    return Expanded(
      flex: 1,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
          minimumSize: MaterialStateProperty.all<Size>(
            Size(150, buttonHeight), // width, height
          ),
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
              if (eqn.isNotEmpty) {
                // if (operator.isNotEmpty && eqn.isNotEmpty) {
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
            } else if (['√x', '1/x', 'x²', '±', '%'].contains(btnText)) {
              operator = btnText;
              currentValue = num.tryParse(eqn) ?? 0;
              evaluate(operator);
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
        child: Text(
          btnText,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 15,
              fontFamily: 'Trajan Pro',
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
