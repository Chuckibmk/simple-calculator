import 'package:flutter/material.dart';

class Converter extends StatefulWidget {
  const Converter({super.key});

  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  final form1 = TextEditingController();
  final form2 = TextEditingController();

  // dynamic activeform;

  List<List<dynamic>> nmbrs = [
    ['7', '8', '9', '\u232B'],
    ['4', '5', '6', 'C'],
    ['1', '2', '3', '↑'],
    ['±', '0', '.', '↓']
  ];

  dynamic val1 = '';
  dynamic val2 = '';

  num currentValue = 0;
  dynamic operator = '';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      Size size = MediaQuery.of(context).size;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Converter'),
          centerTitle: true,
          // actions: [],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                height: size.height / 3,
                child: Column(children: [
                  TextFormField(
                    controller: form1,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 35),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "",
                    ),
                    enableInteractiveSelection: false,
                    readOnly: true,
                    showCursor: true,
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.none,
                  ),
                  TextFormField(
                    controller: form2,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 35),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "",
                    ),
                    enableInteractiveSelection: false,
                    readOnly: true,
                    showCursor: true,
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.none,
                  ),
                ])),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              height: size.height / 2,
              child: Column(
                children: [
                  for (var nb in nmbrs)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var n in nb) convbtn(n),
                      ],
                    )
                ],
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

  // void convert(){
  //   setState(() {
  //     if(operator == '±'){

  //     }
  //   });
  // }

  convbtn(dynamic btntext) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      height: 50,
      width: 95,
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: const BorderSide(color: Colors.black)))),
        onPressed: () {
          setState(() {
            if (btntext == 'C') {
              val1 = '';
              val2 = '';
              form1.clear();
              form2.clear();
            } else if (btntext == '\u232B') {
              if (val1.isNotEmpty) {
                val1 = val1.substring(0, val1.length - 1);
                form1.text = val1;
              }
              // } else if (btntext == '±') {
              //   num ne = num.tryParse(val1) ?? 0;
              //   dynamic neg = -1 * ne;
              //   form1.text = neg.toString();
            } else {
              val1 += btntext;
              form1.text = val1;
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Text(
            btntext,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
