import 'package:flutter/material.dart';

class speed extends StatefulWidget {
  const speed({super.key});

  @override
  State<speed> createState() => _speedState();
}

class _speedState extends State<speed> {
  final form1 = TextEditingController();
  final form2 = TextEditingController();

  // dynamic activeform;
  String dd1 = 'Meters per second (m/s)';
  var dd_1 = [
    'Meters per second (m/s)',
    'Meters per hour (m/h)',
    'Kilometers per second (km/s)',
    'Kilometers per hour (km/h)',
    'Inches per second (in/s)',
    'Inches per hour (in/h)',
    'Feet per second (ft/s)',
    'Feet per hour (ft/h)',
    'Miles per second (mi/s)',
    'Miles per hour (mi/h)',
    'Knots (kn)'
  ];

  String dd2 = 'Inches per second (in/s)';
  var dd_2 = [
    'Meters per second (m/s)',
    'Meters per hour (m/h)',
    'Kilometers per second (km/s)',
    'Kilometers per hour (km/h)',
    'Inches per second (in/s)',
    'Inches per hour (in/h)',
    'Feet per second (ft/s)',
    'Feet per hour (ft/h)',
    'Miles per second (mi/s)',
    'Miles per hour (mi/h)',
    'Knots (kn)'
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
