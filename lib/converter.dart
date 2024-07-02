import 'package:calculator/converter/data.dart';
import 'package:calculator/converter/length.dart';
import 'package:calculator/converter/mass.dart';
import 'package:calculator/converter/speed.dart';
import 'package:calculator/converter/temp.dart';
import 'package:calculator/converter/time.dart';
import 'package:calculator/converter/volume.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'converter/area.dart';

class Converter extends StatefulWidget {
  const Converter({super.key});

  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter>
    with SingleTickerProviderStateMixin {
  final List<TextEditingController> forms =
      List.generate(16, (index) => TextEditingController());

  Map<String, List<String>> selectedValuesMap = {
    'Area': ['Acres (ac)', 'Square meters (m²)'],
    'Length': ['Inches (in)', 'Centimeters (cm)'],
  };

  List<List<dynamic>> nmbrs = [
    ['7', '8', '9', '\u232B'],
    ['4', '5', '6', 'C'],
    ['1', '2', '3', ''],
    ['', '0', '.', '']
    // ['±', '0', '.', '↓']
  ];

  // dynamic val1 = '';
  // dynamic val2 = '';

  // num currentValue = 0;
  // dynamic operator = '';

  late TabController _tabController;

  void _updateSelectedValues(String tabKey, List<String> values) {
    setState(() {
      selectedValuesMap[tabKey] = values;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    for (var f in forms) {
      f.dispose();
    }
    super.dispose();
  }

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
            TabBar(
              isScrollable: true,
              controller: _tabController,
              tabs: const [
                Tab(text: 'Area'),
                Tab(text: 'Length'),
                Tab(text: 'Temperature'),
                Tab(text: 'Volume'),
                Tab(text: 'Mass'),
                Tab(text: 'Data'),
                Tab(text: 'Speed'),
                Tab(text: 'Time')
              ],
            ),
            SizedBox(
              height: size.height / 3,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Area(
                    area1: forms.sublist(0, 2),
                    dd1: selectedValuesMap['Area']!,
                    ovc: (values) => _updateSelectedValues('Area', values),
                  ),
                  Length(
                    len1: forms.sublist(2, 4),
                    ldd: selectedValuesMap['Length']!,
                    lovc: (values) => _updateSelectedValues('Area', values),
                  ),
                  Temp(temp1: forms.sublist(4, 6)),
                  Volume(vol1: forms.sublist(6, 8)),
                  Mass(mass1: forms.sublist(8, 10)),
                  Data(data1: forms.sublist(10, 12)),
                  Speed(spd1: forms.sublist(12, 14)),
                  Time(time1: forms.sublist(14, 16))
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              height: size.height / 2,
              child: Column(
                children: [
                  for (var nb in nmbrs)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var n in nb)
                          convbtn(
                              n,
                              forms.sublist(_tabController.index * 2,
                                  _tabController.index * 2 + 2)),
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

  // void convert (){
  //   if(){

  //   }
  // }

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

  convbtn(dynamic btntext, List<TextEditingController> form_entry) {
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
              // val1 = '';
              // val2 = '';
              form_entry[0].clear();
              form_entry[1].clear();
            } else if (btntext == '\u232B') {
              if (form_entry[0].text.isNotEmpty) {
                form_entry[0].text = form_entry[0]
                    .text
                    .substring(0, form_entry[0].text.length - 1);
                // form_entry[0].text = val1;
              }
              // } else if (btntext == '±') {
              //   num ne = num.tryParse(val1) ?? 0;
              //   dynamic neg = -1 * ne;
              //   form1.text = neg.toString();
            } else {
              form_entry[0].text += btntext;
              // form_entry[0].text = val1;
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
