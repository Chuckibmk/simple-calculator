import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List calculator_varibles = [
    '%',
    'CE',
    'C',
    'DEL',
    '1/x',
    'x^2',
    '2^x',
    '/',
    '7',
    '8',
    '9',
    'X',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '+/-',
    '0',
    '.',
    '='
  ];

  var scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, contraints) {
      Size size = MediaQuery.of(context).size;
      return Scaffold(
        key: scaffoldkey,
        appBar: AppBar(title: const Text('Calculator'), centerTitle: true, actions: [
          Builder(
              builder: (context) => IconButton(
                    icon: const Icon(Icons.history),
                    onPressed: () {
                      scaffoldkey.currentState?.openEndDrawer();
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ))
        ]),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [
              SizedBox(
                height: 100,
                child: DrawerHeader(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Text('History',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ))),
              ),
              ListTile(
                leading: Icon(
                  Icons.history,
                  color: Colors.grey,
                ),
                title: Text('ANSWER'),
              )
            ],
          ),
        ),
        body: Column(children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              height: size.height / 3,
              child: Column(children: [
                TextFormField(
                  maxLines: 2,
                  style: const TextStyle(fontSize: 40),
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "0"),
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.none,
                  // readOnly: true,
                ),
                TextFormField(
                  maxLines: 1,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "ANS"),
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.none,
                  // readOnly: true,
                ),
              ])),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            height: size.height / 2,
            child: Column(
              children: [
                yspace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calcbtn(context, "%"),
                    calcbtn(context, "CE"),
                    calcbtn(context, "C"),
                    calcbtn(context, "DEL"),
                  ],
                ),
                yspace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calcbtn(context, "1/x"),
                    calcbtn(context, "x^2"),
                    calcbtn(context, "sqrt(x)"),
                    calcbtn(context, "/"),
                  ],
                ),
                yspace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calcbtn(context, "7"),
                    calcbtn(context, "8"),
                    calcbtn(context, "9"),
                    calcbtn(context, "X"),
                  ],
                ),
                yspace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calcbtn(context, "4"),
                    calcbtn(context, "5"),
                    calcbtn(context, "6"),
                    calcbtn(context, "-"),
                  ],
                ),
                yspace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calcbtn(context, "1"),
                    calcbtn(context, "2"),
                    calcbtn(context, "3"),
                    calcbtn(context, "+"),
                  ],
                ),
                yspace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calcbtn(context, "+/-"),
                    calcbtn(context, "0"),
                    calcbtn(context, "."),
                    calcbtn(context, "="),
                  ],
                ),
              ],
            ),
          )
        ]),
      );
    });
  }
}

Widget yspace() {
  return const SizedBox(
    height: 10,
  );
}

Widget xspace() {
  return const SizedBox(
    height: 10,
  );
}

calcbtn(BuildContext context, calcbtn) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 5.0),
    height: 50,
    width: 90,
    child: ElevatedButton(
        style: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.all<Color>(Colors.blueAccent)),
        onPressed: () {},
        child: Text(calcbtn)),
  );
}
