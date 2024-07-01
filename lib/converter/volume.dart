import 'package:flutter/material.dart';

class Volume extends StatefulWidget {
  final List<TextEditingController> vol1;
  // final TextEditingController vol2;

  const Volume({super.key, required this.vol1});
  // const Volume({super.key, required this.vol1, required this.vol2});

  @override
  State<Volume> createState() => _VolumeState();
}

class _VolumeState extends State<Volume> {
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
                controller: widget.vol1[0],
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
                controller: widget.vol1[1],
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
