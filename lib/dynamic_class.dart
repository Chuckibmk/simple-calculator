import 'package:flutter/material.dart';

class Dyna extends StatefulWidget {
  final String currentP;

  // List of dyna textcontroller passed from parent page
  final List<TextEditingController> dyna1;

  // List of dropdown strings passed from parent page
  final List<String> dd1;

  // function of dropdown OnValueChanged handling List of Strings
  final Function(List<String>) ovc;

  // function of dropdown OnValueChanged handling List of Strings
  final Function(int, int) updateTFF;

  final int a1;
  final int b1;

  const Dyna(
      {super.key,
      required this.currentP,
      required this.dyna1,
      required this.dd1,
      required this.ovc,
      required this.a1,
      required this.b1,
      required this.updateTFF});

  @override
  State<Dyna> createState() => _DynaState();
}

class _DynaState extends State<Dyna> {
  // dropdown 1 Values
  Map<String, List<String>> dd_1 = {
    'Area': [
      'Acres (ac)',
      'Ares (a)',
      'Hectares (ha)',
      'Square Centimeters (cm²)',
      'Square feet (ft²)',
      'Square inches (in²)',
      'Square meters (m²)'
    ],
    'Data': [
      'Bits (bit)',
      'Bytes (B)',
      'Kilobytes (KB)',
      'Kibibytes (KiB)',
      'Megabytes (MB)',
      'Mebibytes (MiB)',
      'Gigabytes (GB)',
      'Gibibytes (GiB)',
      'Terabytes (TB)',
      'Tebibytes (TiB)'
    ],
    'Length': [
      'Millimeters (mm)',
      'Centimeters (cm)',
      'Meters (m)',
      'Kilometers (km)',
      'Inches (in)',
      'Feet (ft)',
      'Yards (yd)',
      'Miles (mi)',
      'Nautical miles (NM)',
      'Mils (mil)'
    ],
    'Mass': [
      'Tons (t)',
      'UK tons (t)',
      'US tons (t)',
      'Pounds (lb)',
      'Ounces (oz)',
      'Kilograms (kg)',
      'Grams (g)'
    ],
    'Speed': [
      'Meters per second (m/s)',
      'Meters per hour (m/h)',
      'Kilometers per second (km/s)',
      'Kilometers per hour (km/h)',
      'Inches per second (in/s)',
      'Inches per hour (in/h)',
      'Feet per second (ft/s)',
      'Feet per hour (ft/h)',
      'Miles per second (mi/s)',
      'Miles per hour (mi/h)',
      'Knots (kn)'
    ],
    'Temp': ['Celsius (℃)', 'Fahrenheit (℉)', 'Kelvin (K)'],
    'Time': [
      'Milliseconds (ms)',
      'Seconds (s)',
      'Minutes (min)',
      'Hours (h)',
      'Days (d)',
      'Weeks (wk)'
    ],
    'Volume': [
      'UK gallons (gal)',
      'US gallons (gal)',
      'Liters (l)',
      'Milliliters (ml)',
      'Cubic Centimeters (cc) (cm³)',
      'Cubic meters (m³)',
      'Cubic inches (in³)',
      'Cubic feet (ft³)'
    ]
  };

  // list fxn that extracts dropdownitems based on key
  List<DropdownMenuItem<String>> getDropdownItemsForKey(String key) {
    //creates an empty list for the DD items
    List<DropdownMenuItem<String>> items = [];
    // check the dropdown map dd_1 for a key
    if (dd_1.containsKey(key)) {
      // loop thru the list under the key
      for (var item in dd_1[key]!) {
        // and add them to items list
        items.add(DropdownMenuItem(value: item, child: Text(item)));
      }
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(children: [
              DropdownButtonFormField(
                  // DropdownButton<String>(
                  decoration: const InputDecoration(border: InputBorder.none),
                  // interate between all items in dropdown 1
                  items: getDropdownItemsForKey(widget.currentP),
                  isExpanded: true,
                  //display index 0 of dd1 widget
                  value: widget.dd1[0],
                  // onchange assign new selected value and pass thro ovc function
                  onChanged: (String? newValue) {
                    List<String> newValues = List.from(widget.dd1);
                    newValues[0] = newValue!;
                    widget.ovc(newValues);
                  }),
              TextFormField(
                onTap: () {
                  widget.updateTFF(0, 1);
                },
                controller: widget.dyna1[0],
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'Trajan Pro',
                ),
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
            ]),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(children: [
              DropdownButtonFormField(
                  decoration: const InputDecoration(border: InputBorder.none),
                  // interate between all items in dropdown 1
                  items: getDropdownItemsForKey(widget.currentP),
                  isExpanded: true,
                  value: widget.dd1[1],
                  onChanged: (String? newValue) {
                    List<String> newValues = List.from(widget.dd1);
                    newValues[1] = newValue!;
                    widget.ovc(newValues);
                  }),
              TextFormField(
                onTap: () {
                  widget.updateTFF(1, 0);
                },
                controller: widget.dyna1[1],
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'Trajan Pro',
                ),
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
            ]),
          ),
        ),
      ],
    );
  }
}
