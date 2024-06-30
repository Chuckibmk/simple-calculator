import 'package:flutter/material.dart';

class volume extends StatefulWidget {
  const volume({super.key});

  @override
  State<volume> createState() => _volumeState();
}

class _volumeState extends State<volume> {
  final form1 = TextEditingController();
  final form2 = TextEditingController();

  // dynamic activeform;
  String dd1 = 'US gallons (gal)';
  var dd_1 = [
    'UK gallons (gal)',
    'US gallons (gal)',
    'Liters (l)',
    'Milliliters (ml)',
    'Cubic Centimeters (cc) (cm³)',
    'Cubic meters (m³)',
    'Cubic inches (in³)',
    'Cubic feet (ft³)'
  ];

  String dd2 = 'Liters (l)';
  var dd_2 = [
    'UK gallons (gal)',
    'US gallons (gal)',
    'Liters (l)',
    'Milliliters (ml)',
    'Cubic Centimeters (cc) (cm³)',
    'Cubic meters (m³)',
    'Cubic inches (in³)',
    'Cubic feet (ft³)'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(children: [
              DropdownButtonFormField(
                  decoration: const InputDecoration(border: InputBorder.none),
                  items: dd_1.map((items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  isExpanded: true,
                  value: dd1,
                  onChanged: (value) {
                    setState(() {
                      dd1 = value.toString();
                    });
                  }),
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
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(children: [
              DropdownButtonFormField(
                  decoration: const InputDecoration(border: InputBorder.none),
                  items: dd_2.map((items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  isExpanded: true,
                  value: dd2,
                  onChanged: (value) {
                    setState(() {
                      dd2 = value.toString();
                    });
                  }),
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
      ],
    );
  }
}
