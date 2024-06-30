import 'package:flutter/material.dart';

class areacv extends StatefulWidget {
  const areacv({super.key});

  @override
  State<areacv> createState() => _areacvState();
}

class _areacvState extends State<areacv> {
  final form1 = TextEditingController();
  final form2 = TextEditingController();

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
