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

                num val1 = num.tryParse(formEntry[0].text) ?? 0;
                formEntry[1].text =
                    convert(tabin, val1, dropdownValues[0], dropdownValues[1])
                        .toString();
              }
            } else {
              formEntry[0].text += btntext;
              num val1 = num.tryParse(formEntry[0].text) ?? 0;
              formEntry[1].text =
                  convert(tabin, val1, dropdownValues[0], dropdownValues[1])
                      .toString();
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
      final Map<String, Map<String, double>> areaMap = {
        'Acres (ac)': {
          'Acres (ac)': 1,
          'Ares (a)': 40.468564224,
          'Hectares (ha)': 0.4046856422,
          'Square Centimeters (cm²)': 40468564.224,
          'Square feet (ft²)': 43560,
          'Square inches (in²)': 6272640,
          'Square meters (m²)': 4046.856
        },
        'Ares (a)': {
          'Acres (ac)': 0.0247105,
          'Ares (a)': 1,
          'Hectares (ha)': 0.01,
          'Square Centimeters (cm²)': 1000000,
          'Square feet (ft²)': 1076.39,
          'Square inches (in²)': 155000.31,
          'Square meters (m²)': 100
        },
        'Hectares (ha)': {
          'Acres (ac)': 2.47105,
          'Ares (a)': 100,
          'Hectares (ha)': 1,
          'Square Centimeters (cm²)': 100000000,
          'Square feet (ft²)': 107639,
          'Square inches (in²)': 1550003100,
          'Square meters (m²)': 10000
        },
        'Square centimeters (cm²)': {
          'Acres (ac)': 0.0000000247,
          'Ares (a)': 0.000001,
          'Hectares (ha)': 0.00000001,
          'Square Centimeters (cm²)': 1,
          'Square feet (ft²)': 0.00107639,
          'Square inches (in²)': 0.15500016,
          'Square meters (m²)': 0.0001
        },
        'Square feet (ft²)': {
          'Acres (ac)': 0.0000229568,
          'Ares (a)': 0.000001,
          'Hectares (ha)': 0.00000929,
          'Square Centimeters (cm²)': 929.03,
          'Square feet (ft²)': 1,
          'Square inches (in²)': 144,
          'Square meters (m²)': 0.092903
        },
        'Square inches (in²)': {
          'Acres (ac)': 1.59423e-7,
          'Ares (a)': 6.4516e-6,
          'Hectares (ha)': 6.4516e-8,
          'Square Centimeters (cm²)': 6.4516,
          'Square feet (ft²)': 0.00694444,
          'Square inches (in²)': 1,
          'Square meters (m²)': 0.00064516
        },
        'Square meters (m²)': {
          'Acres (ac)': 0.0002471208304956,
          'Ares (a)': 0.01,
          'Hectares (ha)': 0.000100006252,
          'Square Centimeters (cm²)': 10000,
          'Square feet (ft²)': 10.764,
          'Square inches (in²)': 1550.016,
          'Square meters (m²)': 1
        }
      };
      if (areaMap.containsKey(x) && areaMap[x]!.containsKey(y)) {
        return val1 * areaMap[x]![y]!;
      }
    }
    if (tabin == 1) {
      final Map<String, Map<String, double>> lengthMap = {
        'Millimeters (mm)': {
          'Millimeters (mm)': 1,
          'Centimeters (cm)': 0.1,
          'Meters (m)': 0.001,
          'Kilometers (km)': 1e-6,
          'Inches (in)': 0.0393701,
          'Feet (ft)': 0.0032808399,
          'Yards (yd)': 0.0010936133,
          'Miles (mi)': 1.609e+6,
          'Nautical miles (NM)': 5.39956803e-7,
          'Mils (mil)': 39.3701
        },
        'Centimeters (cm)': {
          'Millimeters (mm)': 10,
          'Centimeters (cm)': 1,
          'Meters (m)': 0.01,
          'Kilometers (km)': 1e-5,
          'Inches (in)': 0.393701,
          'Feet (ft)': 0.032808399,
          'Yards (yd)': 0.010936133,
          'Miles (mi)': 6.2137e-6,
          'Nautical miles (NM)': 5.399557e-6,
          'Mils (mil)': 393.701
        },
        'Meters (m)': {
          'Millimeters (mm)': 1000,
          'Centimeters (cm)': 100,
          'Meters (m)': 1,
          'Kilometers (km)': 0.001,
          'Inches (in)': 39.3701,
          'Feet (ft)': 3.28084,
          'Yards (yd)': 1.09361,
          'Miles (mi)': 0.000621371,
          'Nautical miles (NM)': 0.000539957,
          'Mils (mil)': 39370.1
        },
        'Kilometers (km)': {
          'Millimeters (mm)': 1e+6,
          'Centimeters (cm)': 100000,
          'Meters (m)': 1000,
          'Kilometers (km)': 1,
          'Inches (in)': 39370.1,
          'Feet (ft)': 3280.84,
          'Yards (yd)': 1093.61,
          'Miles (mi)': 0.621371,
          'Nautical miles (NM)': 0.539957,
          'Mils (mil)': 39370078.7
        },
        'Inches (in)': {
          'Millimeters (mm)': 25.4,
          'Centimeters (cm)': 2.54,
          'Meters (m)': 0.0254,
          'Kilometers (km)': 2.54e-5,
          'Inches (in)': 1,
          'Feet (ft)': 0.0833333,
          'Yards (yd)': 0.0277778,
          'Miles (mi)': 1.5783e-5,
          'Nautical miles (NM)': 1.3715e-5,
          'Mils (mil)': 1000
        },
        'Feet (ft)': {
          'Millimeters (mm)': 304.8,
          'Centimeters (cm)': 30.48,
          'Meters (m)': 0.3048,
          'Kilometers (km)': 0.0003048,
          'Inches (in)': 12,
          'Feet (ft)': 1,
          'Yards (yd)': 0.333333,
          'Miles (mi)': 0.000189394,
          'Nautical miles (NM)': 0.000164579,
          'Mils (mil)': 12000
        },
        'Yards (yd)': {
          'Millimeters (mm)': 914.4,
          'Centimeters (cm)': 91.44,
          'Meters (m)': 0.9144,
          'Kilometers (km)': 0.0009144,
          'Inches (in)': 36,
          'Feet (ft)': 3,
          'Yards (yd)': 1,
          'Miles (mi)': 0.000568182,
          'Nautical miles (NM)': 0.000493737,
          'Mils (mil)': 36000
        },
        'Miles (mi)': {
          'Millimeters (mm)': 1.609e+6,
          'Centimeters (cm)': 160934,
          'Meters (m)': 1609.34,
          'Kilometers (km)': 1.60934,
          'Inches (in)': 63360,
          'Feet (ft)': 5280,
          'Yards (yd)': 1760,
          'Miles (mi)': 1,
          'Nautical miles (NM)': 0.868976,
          'Mils (mil)': 6.336e+7
        },
        'Nautical miles (NM)': {
          'Millimeters (mm)': 1.852e+6,
          'Centimeters (cm)': 185200,
          'Meters (m)': 1852,
          'Kilometers (km)': 1.852,
          'Inches (in)': 72913.4,
          'Feet (ft)': 6076.12,
          'Yards (yd)': 2025.37,
          'Miles (mi)': 1.15078,
          'Nautical miles (NM)': 1,
          'Mils (mil)': 7.291e+7
        },
      };
      if (lengthMap.containsKey(x) && lengthMap[x]!.containsKey(y)) {
        return val1 * lengthMap[x]![y]!;
      }
    }
    if (tabin == 2) {
      if (x == 'Celsius (℃)') {
        if (y == 'Celsius (℃)') {
          return val1;
        } else if (y == 'Fahrenheit (℉)') {
          return (val1 * 9 / 5) + 32;
        } else if (y == 'Kelvin (K)') {
          return val1 + 273.15;
        }
      } else if (x == 'Fahrenheit (℉)') {
        if (y == 'Celsius (℃)') {
          return (val1 - 32) * 5 / 9;
        } else if (y == 'Fahrenheit (℉)') {
          return val1;
        } else if (y == 'Kelvin (K)') {
          return (val1 - 32) * 5 / 9 + 273.15;
        }
      } else if (x == 'Kelvin (K)') {
        if (y == 'Celsius (℃)') {
          return val1 - 273.15;
        } else if (y == 'Fahrenheit (℉)') {
          return (val1 - 273.15) * 9 / 5 + 32;
        } else if (y == 'Kelvin (K)') {
          return val1;
        }
      }
    }
    if (tabin == 3) {
      final Map<String, Map<String, double>> volMap = {
        'UK gallons (gal)': {
          'UK gallons (gal)': 1,
          'US gallons (gal)': 1.20095,
          'Liters (l)': 4.54609,
          'Milliliters (ml)': 4546.09,
          'Cubic Centimeters (cc) (cm³)': 4546.09,
          'Cubic meters (m³)': 0.00454609,
          'Cubic inches (in³)': 277.419,
          'Cubic feet (ft³)': 0.160544
        },
        'US gallons (gal)': {
          'UK gallons (gal)': 0.832674,
          'US gallons (gal)': 1,
          'Liters (l)': 3.78541,
          'Milliliters (ml)': 3785.41,
          'Cubic Centimeters (cc) (cm³)': 3785.41,
          'Cubic meters (m³)': 0.00378541,
          'Cubic inches (in³)': 231,
          'Cubic feet (ft³)': 0.133681
        },
        'Liters (l)': {
          'UK gallons (gal)': 0.219969,
          'US gallons (gal)': 0.264172,
          'Liters (l)': 1,
          'Milliliters (ml)': 1000,
          'Cubic Centimeters (cc) (cm³)': 1000,
          'Cubic meters (m³)': 0.001,
          'Cubic inches (in³)': 61.0237,
          'Cubic feet (ft³)': 0.0353147
        },
        'Milliliters (ml)': {
          'UK gallons (gal)': 0.000219969,
          'US gallons (gal)': 0.000264172,
          'Liters (l)': 0.001,
          'Milliliters (ml)': 1,
          'Cubic Centimeters (cc) (cm³)': 1,
          'Cubic meters (m³)': 1e-6,
          'Cubic inches (in³)': 0.0610237,
          'Cubic feet (ft³)': 3.5315e-5
        },
        'Cubic Centimeters (cc) (cm³)': {
          'UK gallons (gal)': 0.000219969,
          'US gallons (gal)': 0.000264172,
          'Liters (l)': 0.001,
          'Milliliters (ml)': 1,
          'Cubic Centimeters (cc) (cm³)': 1,
          'Cubic meters (m³)': 1e-6,
          'Cubic inches (in³)': 0.0610237,
          'Cubic feet (ft³)': 3.5315e-5
        },
        'Cubic inches (in³)': {
          'UK gallons (gal)': 0.00360465,
          'US gallons (gal)': 0.004329,
          'Liters (l)': 0.0163871,
          'Milliliters (ml)': 16.3871,
          'Cubic Centimeters (cc) (cm³)': 16.3871,
          'Cubic meters (m³)': 1.6387e-5,
          'Cubic inches (in³)': 1,
          'Cubic feet (ft³)': 0.000578704
        },
        'Cubic meters (m³)': {
          'UK gallons (gal)': 219.969,
          'US gallons (gal)': 264.172,
          'Liters (l)': 1000,
          'Milliliters (ml)': 1e+6,
          'Cubic Centimeters (cc) (cm³)': 1e+6,
          'Cubic meters (m³)': 1,
          'Cubic inches (in³)': 61023.7,
          'Cubic feet (ft³)': 35.3147
        },
        'Cubic feet (ft³)': {
          'UK gallons (gal)': 6.22884,
          'US gallons (gal)': 7.48052,
          'Liters (l)': 28.3168,
          'Milliliters (ml)': 28316.8,
          'Cubic Centimeters (cc) (cm³)': 28316.8,
          'Cubic meters (m³)': 0.0283168,
          'Cubic inches (in³)': 1728,
          'Cubic feet (ft³)': 0.000578704
        }
      };
      if (volMap.containsKey(x) && volMap[x]!.containsKey(y)) {
        return val1 * volMap[x]![y]!;
      }
    }
    if (tabin == 4) {
      final Map<String, Map<String, double>> massMap = {
        'Tons (t)': {
          'Tons (t)': 1,
          'UK tons (t)': 0.984207,
          'US tons (t)': 1.10231,
          'Pounds (lb)': 2204.62,
          'Ounces (oz)': 35274,
          'Kilograms (kg)': 1000,
          'Grams (g)': 1e+6
        },
        'UK tons (t)': {
          'Tons (t)': 1.01605,
          'UK tons (t)': 1,
          'US tons (t)': 1.12,
          'Pounds (lb)': 2240,
          'Ounces (oz)': 35840,
          'Kilograms (kg)': 1016.05,
          'Grams (g)': 1.016e+6
        },
        'US tons (t)': {
          'Tons (t)': 0.907185,
          'UK tons (t)': 0.892857,
          'US tons (t)': 1,
          'Pounds (lb)': 2000,
          'Ounces (oz)': 32000,
          'Kilograms (kg)': 907.185,
          'Grams (g)': 907185
        },
        'Pounds (lb)': {
          'Tons (t)': 0.000453592,
          'UK tons (t)': 0.000446429,
          'US tons (t)': 0.0005,
          'Pounds (lb)': 1,
          'Ounces (oz)': 16,
          'Kilograms (kg)': 0.453592,
          'Grams (g)': 453.592
        },
        'Ounces (oz)': {
          'Tons (t)': 2.835e-5,
          'UK tons (t)': 2.7902e-5,
          'US tons (t)': 3.125e-5,
          'Pounds (lb)': 0.0625,
          'Ounces (oz)': 1,
          'Kilograms (kg)': 0.0283495,
          'Grams (g)': 28.3495
        },
        'Kilograms (kg)': {
          'Tons (t)': 0.001,
          'UK tons (t)': 0.000984207,
          'US tons (t)': 0.00110231,
          'Pounds (lb)': 2.20462,
          'Ounces (oz)': 35.274,
          'Kilograms (kg)': 1,
          'Grams (g)': 1000
        },
        'Grams (g)': {
          'Tons (t)': 1e-6,
          'UK tons (t)': 9.8421e-7,
          'US tons (t)': 1.1023e-6,
          'Pounds (lb)': 0.00220462,
          'Ounces (oz)': 0.035274,
          'Kilograms (kg)': 0.001,
          'Grams (g)': 1
        }
      };
    }
    if (tabin == 5) {}
    if (tabin == 6) {}
    if (tabin == 7) {}
  }
}
