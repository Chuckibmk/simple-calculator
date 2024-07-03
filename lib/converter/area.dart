import 'package:flutter/material.dart';

class Area extends StatefulWidget {
  final List<TextEditingController> area1;
  final List<String> dd1;
  final Function(List<String>) ovc;

  const Area({
    super.key,
    required this.area1,
    required this.dd1,
    required this.ovc,
  });

  @override
  State<Area> createState() => _AreaState();
}

class _AreaState extends State<Area> {
  var dd_1 = [
    'Acres (ac)',
    'Ares (a)',
    'Hectares (ha)',
    'Square Centimeters (cm²)',
    'Square feet (ft²)',
    'Square inches (in²)',
    'Square meters (m²)'
  ];

  var dd_2 = [
    'Acres (ac)',
    'Ares (a)',
    'Hectares (ha)',
    'Square Centimeters (cm²)',
    'Square feet (ft²)',
    'Square inches (in²)',
    'Square meters (m²)'
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
                  value: widget.dd1[0],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      List<String> newValues = List.from(widget.dd1);
                      newValues[0] = newValue;
                      widget.ovc(newValues);
                    }
                  }),
              TextFormField(
                controller: widget.area1[0],
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
                  value: widget.dd1[1],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      List<String> newValues = List.from(widget.dd1);
                      newValues[1] = newValue;
                      widget.ovc(newValues);
                    }
                  }),
              TextFormField(
                controller: widget.area1[1],
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