import 'package:flutter/material.dart';

class Mass extends StatefulWidget {
  final List<TextEditingController> mass1;
  final List<String> mdd;
  final Function(List<String>) movc;

  const Mass({
    super.key,
    required this.mass1,
    required this.mdd,
    required this.movc,
  });
  // const Mass({super.key, required this.mass1, required this.mass2});

  @override
  State<Mass> createState() => _MassState();
}

class _MassState extends State<Mass> {
  var dd_1 = [
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
                  value: widget.mdd[0],
                  onChanged: (String? newValue) {
                    List<String> newValues = List.from(widget.mdd);
                    newValues[0] = newValue!;
                    widget.movc(newValues);
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
                  items: dd_1.map((items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  isExpanded: true,
                  value: widget.mdd[1],
                  onChanged: (String? newValue) {
                    List<String> newValues = List.from(widget.mdd);
                    newValues[1] = newValue!;
                    widget.movc(newValues);
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
