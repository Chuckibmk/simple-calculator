import 'package:flutter/material.dart';

class Area extends StatefulWidget {
  final List<TextEditingController> area1;
  // final TextEditingController area2;

  const Area({super.key, required this.area1});
  // const Area({super.key, required this.area1, required this.area2});

  @override
  State<Area> createState() => _AreaState();
}

class _AreaState extends State<Area> {
  // dynamic activeform;
  String dd1 = 'Acres (ac)';
  var dd_1 = [
    'Acres (ac)',
    'Ares (a)',
    'Hectares (ha)',
    'Square Centimeters (cm²)',
    'Square feet (ft²)',
    'Square inches (in²)',
    'Square meters (m²)'
  ];

  String dd2 = 'Square meters (m²)';
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
                  value: dd1,
                  onChanged: (value) {
                    setState(() {
                      dd1 = value.toString();
                    });
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
                  value: dd2,
                  onChanged: (value) {
                    setState(() {
                      dd2 = value.toString();
                    });
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
