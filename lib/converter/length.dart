import 'package:flutter/material.dart';

class Length extends StatefulWidget {
  final List<TextEditingController> len1;
  // final TextEditingController len2;

  const Length({super.key, required this.len1});
  // const Length({super.key, required this.len1, required this.len2});

  @override
  State<Length> createState() => _LengthState();
}

class _LengthState extends State<Length> {
  // dynamic activeform;
  String dd1 = 'Inches (in)';
  var dd_1 = [
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
  ];

  String dd2 = 'Centimeters (cm)';
  var dd_2 = [
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
                controller: widget.len1[0],
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
                controller: widget.len1[1],
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
