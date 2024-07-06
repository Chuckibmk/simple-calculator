import 'package:flutter/material.dart';

class Volume extends StatefulWidget {
  final List<TextEditingController> vol1;
  final List<String> vdd;
  final Function(List<String>) vovc;

  const Volume({
    super.key,
    required this.vol1,
    required this.vdd,
    required this.vovc,
  });

  @override
  State<Volume> createState() => _VolumeState();
}

class _VolumeState extends State<Volume> {
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
                  value: widget.vdd[0],
                  onChanged: (String? newValue) {
                    List<String> newValues = List.from(widget.vdd);
                    newValues[0] = newValue!;
                    widget.vovc(newValues);
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
                  items: dd_1.map((items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  isExpanded: true,
                  value: widget.vdd[1],
                  onChanged: (String? newValue) {
                    List<String> newValues = List.from(widget.vdd);
                    newValues[1] = newValue!;
                    widget.vovc(newValues);
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
