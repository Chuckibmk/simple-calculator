import 'package:flutter/material.dart';

class Mass extends StatefulWidget {
  final List<TextEditingController> mass1;
  // final TextEditingController mass2;

  const Mass({super.key, required this.mass1});
  // const Mass({super.key, required this.mass1, required this.mass2});

  @override
  State<Mass> createState() => _MassState();
}

class _MassState extends State<Mass> {
  // dynamic activeform;
  String dd1 = 'Pounds (lb)';
  var dd_1 = [
    'Tons (t)',
    'UK tons (t)',
    'US tons (t)',
    'Pounds (lb)',
    'Ounces (oz)',
    'Kilograms (kg)',
    'Grams (g)'
  ];

  String dd2 = 'Kilograms (kg)';
  var dd_2 = [
    'Tons (t)',
    'UK tons (t)',
    'US tons (t)',
    'Pounds (lb)',
    'Ounces (oz)',
    'Kilograms (kg)',
    'Grams (g)'
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
                controller: widget.mass1[0],
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
                controller: widget.mass1[1],
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
