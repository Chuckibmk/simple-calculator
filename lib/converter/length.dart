import 'package:flutter/material.dart';

class Length extends StatefulWidget {
  final List<TextEditingController> len1;
  final List<String> ldd;
  final Function(List<String>) lovc;

  const Length({
    Key? key,
    required this.len1,
    required this.ldd,
    required this.lovc,
  }) : super(key: key);

  @override
  State<Length> createState() => _LengthState();
}

class _LengthState extends State<Length> {
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
                  value: widget.ldd[0],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      List<String> newValues = List.from(widget.ldd);
                      newValues[0] = newValue;
                      widget.lovc(newValues);
                    }
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
                  value: widget.ldd[1],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      List<String> newValues = List.from(widget.ldd);
                      newValues[1] = newValue;
                      widget.lovc(newValues);
                    }
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
