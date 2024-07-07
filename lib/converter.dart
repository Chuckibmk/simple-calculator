import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'dynamic_class.dart';

class Converter extends StatefulWidget {
  final VoidCallback toggleTheme;
  const Converter({super.key, required this.toggleTheme});

  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter>
    with SingleTickerProviderStateMixin {
  // List containing the generated index for textcontroller
  final List<TextEditingController> forms =
      List.generate(16, (index) => TextEditingController());

  // Map of selected values for individual dropdowns
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

  // list of tabnames
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

  // string method for getting the tabname of selected index
  String getKeyForIndex(int index) {
    return tabKeys[index];
  }

  // list method to select String from selectedValuesMap based on the key provided by getkeyforindex
  List<String> getSelectedValuesForIndex(int index) {
    String key = getKeyForIndex(index);
    return selectedValuesMap[key] ?? [];
  }

  //dynamic List containing symbols used for buttons,
  // note there're Lists inside the main List
  List<List<dynamic>> nmbrs = [
    ['7', '8', '9', '\u232B'],
    ['4', '5', '6', 'C'],
    ['1', '2', '3', ''],
    ['', '0', '.', '']
    // ['±', '0', '.', '↓']
  ];

  // tabcontroller that controls the conversion class tabs
  late TabController _tabController;

  // void method to update List Strings in SelectedValuesMap by tabname after dropdown press
  void _updateSelectedValues(String tabKey, List<String> values) {
    setState(() {
      selectedValuesMap[tabKey] = values;
    });
  }

  @override
  void initState() {
    super.initState();
    // intialize tabcontroller and assign number of expected tabs
    _tabController = TabController(length: 8, vsync: this);
    // intialize addlistener to setstate after tabcontroller onpress
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
            leading: IconButton(
              icon: const Icon(Icons.toggle_on),
              onPressed: () {
                widget.toggleTheme();
              },
              // actions: [],
            )),
        body: SingleChildScrollView(
          child: Column(children: [
            TabBar(
              isScrollable: true,
              controller: _tabController,
              tabs: [
                // loop to create tabs for all tabkeys
                for (var t in tabKeys)
                  Tab(
                    text: t,
                  ),
              ],
            ),
            SizedBox(
              height: size.height / 3,
              child: TabBarView(
                controller: _tabController,
                children: [
                  //loop to use dynamic page dyna to generate pages for each tab
                  for (var t in tabKeys)
                    Dyna(
                        currentP: t,
                        dyna1: forms.sublist(_tabController.index * 2,
                            _tabController.index * 2 + 2),
                        dd1: selectedValuesMap[t]!,
                        ovc: (values) => _updateSelectedValues(t, values)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              height: size.height / 2,
              child: Column(
                children: [
                  // loop through the Lists in the nbmrs symbol List, in order to get the arrangement
                  for (var nb in nmbrs)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // loop through the Strings in each list and calling the convbtn method to show each button
                        for (var n in nb)
                          convbtn(
                              n,
                              //get textcontroller value base on tabcontroller index provided
                              forms.sublist(_tabController.index * 2,
                                  _tabController.index * 2 + 2),
                              // get values from SelectedValuesMap base on current tabcontroller index
                              getSelectedValuesForIndex(_tabController.index),
                              // current tabcontroller index
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
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.onSurface)))),
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
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }

  // convert val1 from x to y under tabin
  // eg: convert 100 from kilogram to ton under index 4 (mass)
  convert(dynamic tabin, num val1, String x, String y) {
    if (tabin == 0) {
      // map of containing conversion classes and their individual conversion rates
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
      // check if x is in map and if x(that is not null) has y
      if (areaMap.containsKey(x) && areaMap[x]!.containsKey(y)) {
        // return the multiplication of val1 and values of y found in x
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
      if (massMap.containsKey(x) && massMap[x]!.containsKey(y)) {
        return val1 * massMap[x]![y]!;
      }
    }
    if (tabin == 5) {
      Map<String, Map<String, double>> dataMap = {
        'Bits (bit)': {
          'Bits (bit)': 1.0,
          'Bytes (B)': 0.125,
          'Kilobytes (KB)': 0.000125,
          'Kibibytes (KiB)': 0.0001220703,
          'Megabytes (MB)': 1.25e-7,
          'Mebibytes (MiB)': 1.1920929e-7,
          'Gigabytes (GB)': 1.25e-10,
          'Gibibytes (GiB)': 1.1641532e-10,
          'Terabytes (TB)': 1.25e-13,
          'Tebibytes (TiB)': 1.1368684e-13
        },
        'Bytes (B)': {
          'Bits (bit)': 8.0,
          'Bytes (B)': 1.0,
          'Kilobytes (KB)': 0.001,
          'Kibibytes (KiB)': 0.0009765625,
          'Megabytes (MB)': 1e-6,
          'Mebibytes (MiB)': 9.5367432e-7,
          'Gigabytes (GB)': 1e-9,
          'Gibibytes (GiB)': 9.3132257e-10,
          'Terabytes (TB)': 1e-12,
          'Tebibytes (TiB)': 9.094947e-13
        },
        'Kilobytes (KB)': {
          'Bits (bit)': 8000.0,
          'Bytes (B)': 1000.0,
          'Kilobytes (KB)': 1.0,
          'Kibibytes (KiB)': 0.9765625,
          'Megabytes (MB)': 0.001,
          'Mebibytes (MiB)': 0.0009536743,
          'Gigabytes (GB)': 1e-6,
          'Gibibytes (GiB)': 9.3132257e-7,
          'Terabytes (TB)': 1e-9,
          'Tebibytes (TiB)': 9.094947e-10
        },
        'Kibibytes (KiB)': {
          'Bits (bit)': 8192.0,
          'Bytes (B)': 1024.0,
          'Kilobytes (KB)': 1.024,
          'Kibibytes (KiB)': 1.0,
          'Megabytes (MB)': 0.001024,
          'Mebibytes (MiB)': 0.0009765625,
          'Gigabytes (GB)': 1.024e-6,
          'Gibibytes (GiB)': 9.5367432e-7,
          'Terabytes (TB)': 1.024e-9,
          'Tebibytes (TiB)': 9.3132257e-10
        },
        'Megabytes (MB)': {
          'Bits (bit)': 8e+6,
          'Bytes (B)': 1e+6,
          'Kilobytes (KB)': 1000.0,
          'Kibibytes (KiB)': 976.5625,
          'Megabytes (MB)': 1.0,
          'Mebibytes (MiB)': 0.9536743,
          'Gigabytes (GB)': 0.001,
          'Gibibytes (GiB)': 0.0009313226,
          'Terabytes (TB)': 1e-6,
          'Tebibytes (TiB)': 9.094947e-7
        },
        'Mebibytes (MiB)': {
          'Bits (bit)': 8.389e+6,
          'Bytes (B)': 1.049e+6,
          'Kilobytes (KB)': 1048.576,
          'Kibibytes (KiB)': 1024.0,
          'Megabytes (MB)': 1.048576,
          'Mebibytes (MiB)': 1.0,
          'Gigabytes (GB)': 0.001048576,
          'Gibibytes (GiB)': 0.0009765625,
          'Terabytes (TB)': 1.048576e-6,
          'Tebibytes (TiB)': 9.5367432e-7
        },
        'Gigabytes (GB)': {
          'Bits (bit)': 8e+9,
          'Bytes (B)': 1e+9,
          'Kilobytes (KB)': 1e+6,
          'Kibibytes (KiB)': 976562.5,
          'Megabytes (MB)': 1000.0,
          'Mebibytes (MiB)': 953.6743,
          'Gigabytes (GB)': 1.0,
          'Gibibytes (GiB)': 0.9313226,
          'Terabytes (TB)': 0.001,
          'Tebibytes (TiB)': 0.0009094947
        },
        'Gibibytes (GiB)': {
          'Bits (bit)': 8.59e+9,
          'Bytes (B)': 1.074e+9,
          'Kilobytes (KB)': 1.074e+6,
          'Kibibytes (KiB)': 1048576.0,
          'Megabytes (MB)': 1073.7418,
          'Mebibytes (MiB)': 1024.0,
          'Gigabytes (GB)': 1.0737418,
          'Gibibytes (GiB)': 1.0,
          'Terabytes (TB)': 0.0010737418,
          'Tebibytes (TiB)': 0.0009765625
        },
        'Terabytes (TB)': {
          'Bits (bit)': 8e+12,
          'Bytes (B)': 1e+12,
          'Kilobytes (KB)': 1e+9,
          'Kibibytes (KiB)': 9.765625e+8,
          'Megabytes (MB)': 1e+6,
          'Mebibytes (MiB)': 953674.3,
          'Gigabytes (GB)': 1000.0,
          'Gibibytes (GiB)': 931.3226,
          'Terabytes (TB)': 1.0,
          'Tebibytes (TiB)': 0.9094947
        },
        'Tebibytes (TiB)': {
          'Bits (bit)': 8.796e+12,
          'Bytes (B)': 1.1e+12,
          'Kilobytes (KB)': 1.1e+9,
          'Kibibytes (KiB)': 1.0737418e+9,
          'Megabytes (MB)': 1.1e+6,
          'Mebibytes (MiB)': 1048576.0,
          'Gigabytes (GB)': 1100.0,
          'Gibibytes (GiB)': 1024.0,
          'Terabytes (TB)': 1.1,
          'Tebibytes (TiB)': 1.0
        }
      };
      if (dataMap.containsKey(x) && dataMap[x]!.containsKey(y)) {
        return val1 * dataMap[x]![y]!;
      }
    }
    if (tabin == 6) {
      Map<String, Map<String, double>> speedMap = {
        'Meters per second (m/s)': {
          'Meters per second (m/s)': 1.0,
          'Meters per hour (m/h)': 3600.0,
          'Kilometers per second (km/s)': 0.001,
          'Kilometers per hour (km/h)': 3.6,
          'Inches per second (in/s)': 39.3701,
          'Inches per hour (in/h)': 141732.283,
          'Feet per second (ft/s)': 3.28084,
          'Feet per hour (ft/h)': 11811.0236,
          'Miles per second (mi/s)': 0.000621371,
          'Miles per hour (mi/h)': 2.23694,
          'Knots (kn)': 1.94384
        },
        'Meters per hour (m/h)': {
          'Meters per second (m/s)': 0.000277778,
          'Meters per hour (m/h)': 1.0,
          'Kilometers per second (km/s)': 2.77778e-7,
          'Kilometers per hour (km/h)': 0.001,
          'Inches per second (in/s)': 0.0109361,
          'Inches per hour (in/h)': 39.3701,
          'Feet per second (ft/s)': 0.000911344,
          'Feet per hour (ft/h)': 3.28084,
          'Miles per second (mi/s)': 1.72603e-7,
          'Miles per hour (mi/h)': 0.000621371,
          'Knots (kn)': 0.000539957
        },
        'Kilometers per second (km/s)': {
          'Meters per second (m/s)': 1000.0,
          'Meters per hour (m/h)': 3600000.0,
          'Kilometers per second (km/s)': 1.0,
          'Kilometers per hour (km/h)': 3600.0,
          'Inches per second (in/s)': 39370.1,
          'Inches per hour (in/h)': 1.41732e+8,
          'Feet per second (ft/s)': 3280.84,
          'Feet per hour (ft/h)': 1.1811e+7,
          'Miles per second (mi/s)': 0.621371,
          'Miles per hour (mi/h)': 2236.94,
          'Knots (kn)': 1943.84
        },
        'Kilometers per hour (km/h)': {
          'Meters per second (m/s)': 0.277778,
          'Meters per hour (m/h)': 1000.0,
          'Kilometers per second (km/s)': 0.000277778,
          'Kilometers per hour (km/h)': 1.0,
          'Inches per second (in/s)': 10.9361,
          'Inches per hour (in/h)': 39370.1,
          'Feet per second (ft/s)': 0.911344,
          'Feet per hour (ft/h)': 3280.84,
          'Miles per second (mi/s)': 0.000172603,
          'Miles per hour (mi/h)': 0.621371,
          'Knots (kn)': 0.539957
        },
        'Inches per second (in/s)': {
          'Meters per second (m/s)': 0.0254,
          'Meters per hour (m/h)': 91.44,
          'Kilometers per second (km/s)': 2.54e-5,
          'Kilometers per hour (km/h)': 0.09144,
          'Inches per second (in/s)': 1.0,
          'Inches per hour (in/h)': 3600.0,
          'Feet per second (ft/s)': 0.0833333,
          'Feet per hour (ft/h)': 300.0,
          'Miles per second (mi/s)': 1.5783e-5,
          'Miles per hour (mi/h)': 0.0568182,
          'Knots (kn)': 0.0493737
        },
        'Inches per hour (in/h)': {
          'Meters per second (m/s)': 0.0000070556,
          'Meters per hour (m/h)': 0.0254,
          'Kilometers per second (km/s)': 7.0556e-9,
          'Kilometers per hour (km/h)': 0.0000254,
          'Inches per second (in/s)': 0.000277778,
          'Inches per hour (in/h)': 1.0,
          'Feet per second (ft/s)': 0.0000231481,
          'Feet per hour (ft/h)': 0.0833333,
          'Miles per second (mi/s)': 4.403e-9,
          'Miles per hour (mi/h)': 0.0000157828,
          'Knots (kn)': 0.0000137155
        },
        'Feet per second (ft/s)': {
          'Meters per second (m/s)': 0.3048,
          'Meters per hour (m/h)': 1097.28,
          'Kilometers per second (km/s)': 0.0003048,
          'Kilometers per hour (km/h)': 1.09728,
          'Inches per second (in/s)': 12.0,
          'Inches per hour (in/h)': 43200.0,
          'Feet per second (ft/s)': 1.0,
          'Feet per hour (ft/h)': 3600.0,
          'Miles per second (mi/s)': 0.000189394,
          'Miles per hour (mi/h)': 0.681818,
          'Knots (kn)': 0.592484
        },
        'Feet per hour (ft/h)': {
          'Meters per second (m/s)': 0.0000846667,
          'Meters per hour (m/h)': 0.3048,
          'Kilometers per second (km/s)': 8.4667e-8,
          'Kilometers per hour (km/h)': 0.0003048,
          'Inches per second (in/s)': 0.00333333,
          'Inches per hour (in/h)': 12.0,
          'Feet per second (ft/s)': 0.000277778,
          'Feet per hour (ft/h)': 1.0,
          'Miles per second (mi/s)': 5.2604e-8,
          'Miles per hour (mi/h)': 0.000189394,
          'Knots (kn)': 0.000164579
        },
        'Miles per second (mi/s)': {
          'Meters per second (m/s)': 1609.34,
          'Meters per hour (m/h)': 5.7923e+6,
          'Kilometers per second (km/s)': 1.60934,
          'Kilometers per hour (km/h)': 5792.34,
          'Inches per second (in/s)': 63360.0,
          'Inches per hour (in/h)': 2.2814e+8,
          'Feet per second (ft/s)': 5280.0,
          'Feet per hour (ft/h)': 1.9007e+7,
          'Miles per second (mi/s)': 1.0,
          'Miles per hour (mi/h)': 3600.0,
          'Knots (kn)': 3128.31
        },
        'Miles per hour (mi/h)': {
          'Meters per second (m/s)': 0.44704,
          'Meters per hour (m/h)': 1609.34,
          'Kilometers per second (km/s)': 0.00044704,
          'Kilometers per hour (km/h)': 1.60934,
          'Inches per second (in/s)': 17.6,
          'Inches per hour (in/h)': 63360.0,
          'Feet per second (ft/s)': 1.46667,
          'Feet per hour (ft/h)': 5280.0,
          'Miles per second (mi/s)': 0.000277778,
          'Miles per hour (mi/h)': 1.0,
          'Knots (kn)': 0.868976
        },
        'Knots (kn)': {
          'Meters per second (m/s)': 0.514444,
          'Meters per hour (m/h)': 1852.0,
          'Kilometers per second (km/s)': 0.000514444,
          'Kilometers per hour (km/h)': 1.852,
          'Inches per second (in/s)': 20.2537,
          'Inches per hour (in/h)': 7.1248e+7,
          'Feet per second (ft/s)': 1.68781,
          'Feet per hour (ft/h)': 6076.12,
          'Miles per second (mi/s)': 0.000319661,
          'Miles per hour (mi/h)': 1.15078,
          'Knots (kn)': 1.0
        }
      };
      if (speedMap.containsKey(x) && speedMap[x]!.containsKey(y)) {
        return val1 * speedMap[x]![y]!;
      }
    }
    if (tabin == 7) {
      Map<String, Map<String, double>> timeMap = {
        'Milliseconds (ms)': {
          'Milliseconds (ms)': 1.0,
          'Seconds (s)': 0.001,
          'Minutes (min)': 0.0000166667,
          'Hours (h)': 2.77778e-7,
          'Days (d)': 1.15741e-8,
          'Weeks (wk)': 1.65344e-9
        },
        'Seconds (s)': {
          'Milliseconds (ms)': 1000.0,
          'Seconds (s)': 1.0,
          'Minutes (min)': 0.0166667,
          'Hours (h)': 0.000277778,
          'Days (d)': 0.0000115741,
          'Weeks (wk)': 0.00000165344
        },
        'Minutes (min)': {
          'Milliseconds (ms)': 60000.0,
          'Seconds (s)': 60.0,
          'Minutes (min)': 1.0,
          'Hours (h)': 0.0166667,
          'Days (d)': 0.000694444,
          'Weeks (wk)': 0.0000992063
        },
        'Hours (h)': {
          'Milliseconds (ms)': 3.6e+6,
          'Seconds (s)': 3600.0,
          'Minutes (min)': 60.0,
          'Hours (h)': 1.0,
          'Days (d)': 0.0416667,
          'Weeks (wk)': 0.00595238
        },
        'Days (d)': {
          'Milliseconds (ms)': 8.64e+7,
          'Seconds (s)': 86400.0,
          'Minutes (min)': 1440.0,
          'Hours (h)': 24.0,
          'Days (d)': 1.0,
          'Weeks (wk)': 0.142857
        },
        'Weeks (wk)': {
          'Milliseconds (ms)': 6.048e+8,
          'Seconds (s)': 604800.0,
          'Minutes (min)': 10080.0,
          'Hours (h)': 168.0,
          'Days (d)': 7.0,
          'Weeks (wk)': 1.0
        }
      };
      if (timeMap.containsKey(x) && timeMap[x]!.containsKey(y)) {
        return val1 * timeMap[x]![y]!;
      }
    }
  }
}
