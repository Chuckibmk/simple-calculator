import 'package:calculator/converter/data.dart';
import 'package:calculator/converter/length.dart';
import 'package:calculator/converter/mass.dart';
import 'package:calculator/converter/speed.dart';
import 'package:calculator/converter/temp.dart';
import 'package:calculator/converter/time.dart';
import 'package:calculator/converter/volume.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
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
    'Temp': ['Fahrenheit (℉)', 'Celsius (℃)'],
    'Volume': ['US gallons (gal)', 'Liters (l)'],
    'Mass': ['Pounds (lb)', 'Kilograms (kg)'],
    'Data': ['Kilobytes (KB)', 'Megabytes (MB)'],
    'Speed': ['Meters per second (m/s)', 'Inches per second (in/s)'],
    'Time': ['Seconds (s)', 'Hours (h)']
  };

  final List<String> tabKeys = [
    'Area',
    'Length',
    'Temp',
    'Volume',
    'Mass',
    'Data',
    'Speed',
    'Time'
  ];

  String getKeyForIndex(int index) {
    return tabKeys[index];
  }

  List<String> getSelectedValuesForIndex(int index) {
    String key = getKeyForIndex(index);
    return selectedValuesMap[key] ?? [];
  }

  List<List<dynamic>> nmbrs = [
    ['7', '8', '9', '\u232B'],
    ['4', '5', '6', 'C'],
    ['1', '2', '3', ''],
    ['', '0', '.', '']
    // ['±', '0', '.', '↓']
  ];

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
                    lovc: (values) => _updateSelectedValues('Length', values),
                  ),
                  Temp(
                    temp1: forms.sublist(4, 6),
                    tdd: selectedValuesMap['Temp']!,
                    tovc: (values) => _updateSelectedValues('Temp', values),
                  ),
                  Volume(
                    vol1: forms.sublist(6, 8),
                    vdd: selectedValuesMap['Volume']!,
                    vovc: (values) => _updateSelectedValues('Volume', values),
                  ),
                  Mass(
                    mass1: forms.sublist(8, 10),
                    mdd: selectedValuesMap['Mass']!,
                    movc: (values) => _updateSelectedValues('Mass', values),
                  ),
                  Data(
                    data1: forms.sublist(10, 12),
                    dtdd: selectedValuesMap['Data']!,
                    dovc: (values) => _updateSelectedValues('Data', values),
                  ),
                  Speed(
                    spd1: forms.sublist(12, 14),
                    sdd: selectedValuesMap['Speed']!,
                    sovc: (values) => _updateSelectedValues('Speed', values),
                  ),
                  Time(
                    time1: forms.sublist(14, 16),
                    tidd: selectedValuesMap['Time']!,
                    tiovc: (values) => _updateSelectedValues('Time', values),
                  )
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
                                  _tabController.index * 2 + 2),
                              getSelectedValuesForIndex(_tabController.index),
                              _tabController.index),
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

  convbtn(dynamic btntext, List<TextEditingController> formEntry,
      List<String> dropdownValues, dynamic tabin) {
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
              formEntry[0].clear();
              formEntry[1].clear();
            } else if (btntext == '\u232B') {
              if (formEntry[0].text.isNotEmpty) {
                formEntry[0].text = formEntry[0]
                    .text
                    .substring(0, formEntry[0].text.length - 1);
              }
            } else {
              formEntry[0].text += btntext;
              num val1 = num.tryParse(formEntry[0].text) ?? 0;
              formEntry[1].text =
                  convert(tabin, val1, dropdownValues[0], dropdownValues[1])
                      .toString();
              // print(dropdownValues[0]);
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

  convert(dynamic tabin, num val1, String x, String y) {
    if (tabin == 0) {
      num ans;
      if (x == 'Acres (ac)') {
        Map<String, double> acres = {
          'Acres (ac)': 1,
          'Ares (a)': 40.468564224,
          'Hectares (ha)': 0.4046856422,
          'Square Centimeters (cm²)': 40468564.224,
          'Square feet (ft²)': 43560,
          'Square inches (in²)': 6272640,
          'Square meters (m²)': 4046.856
        };
        if (acres.containsKey(y)) {
          ans = val1 * acres[y]!;
          return ans;
        }
      } else if (x == 'Ares (a)') {
        Map<String, double> ares = {
          'Acres (ac)': 0.0247105,
          'Ares (a)': 1,
          'Hectares (ha)': 0.01,
          'Square Centimeters (cm²)': 1000000,
          'Square feet (ft²)': 1076.39,
          'Square inches (in²)': 155000.31,
          'Square meters (m²)': 100
        };
        if (ares.containsKey(y)) {
          ans = val1 * ares[y]!;
          return ans;
        }
      } else if (x == 'Hectares (ha)') {
        Map<String, double> hectares = {
          'Acres (ac)': 2.47105,
          'Ares (a)': 100,
          'Hectares (ha)': 1,
          'Square Centimeters (cm²)': 100000000,
          'Square feet (ft²)': 107639,
          'Square inches (in²)': 1550003100,
          'Square meters (m²)': 10000
        };
        if (hectares.containsKey(y)) {
          ans = val1 * hectares[y]!;
          return ans;
        }
      } else if (x == 'Square centimeters (cm²)') {
        Map<String, double> centimeters = {
          'Acres (ac)': 0.0000000247,
          'Ares (a)': 0.000001,
          'Hectares (ha)': 0.00000001,
          'Square Centimeters (cm²)': 1,
          'Square feet (ft²)': 0.00107639,
          'Square inches (in²)': 0.15500016,
          'Square meters (m²)': 0.0001
        };
        if (centimeters.containsKey(y)) {
          ans = val1 * centimeters[y]!;
          return ans;
        }
      } else if (x == 'Square feet (ft²)') {
        Map<String, double> feet = {
          'Acres (ac)': 0.0000229568,
          'Ares (a)': 0.000001,
          'Hectares (ha)': 0.00000929,
          'Square Centimeters (cm²)': 929.03,
          'Square feet (ft²)': 1,
          'Square inches (in²)': 144,
          'Square meters (m²)': 0.092903
        };
        if (feet.containsKey(y)) {
          ans = val1 * feet[y]!;
          return ans;
        }
      } else if (x == 'Square inches (in²)') {
        Map<String, double> inch = {
          'Acres (ac)': 1.59423e-7,
          'Ares (a)': 6.4516e-6,
          'Hectares (ha)': 6.4516e-8,
          'Square Centimeters (cm²)': 6.4516,
          'Square feet (ft²)': 0.00694444,
          'Square inches (in²)': 1,
          'Square meters (m²)': 0.00064516
        };
        if (inch.containsKey(y)) {
          ans = val1 * inch[y]!;
          return ans;
        }
      } else if (x == 'Square meters (m²)') {
        Map<String, double> meters = {
          'Acres (ac)': 0.0002471208304956,
          'Ares (a)': 0.01,
          'Hectares (ha)': 0.000100006252,
          'Square Centimeters (cm²)': 10000,
          'Square feet (ft²)': 10.764,
          'Square inches (in²)': 1550.016,
          'Square meters (m²)': 1
        };
        if (meters.containsKey(y)) {
          ans = val1 * meters[y]!;
          return ans;
        }
      }
    }
    if (tabin == '1') {}
    if (tabin == '2') {}
    if (tabin == '3') {}
    if (tabin == '4') {}
    if (tabin == '5') {}
    if (tabin == '6') {}
    if (tabin == '7') {}
  }
}
