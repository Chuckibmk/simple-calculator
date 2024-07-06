import 'package:flutter/material.dart';

class Speed extends StatefulWidget {
  final List<TextEditingController> spd1;
  final List<String> sdd;
  final Function(List<String>) sovc;

  const Speed({
    super.key,
    required this.spd1,
    required this.sdd,
    required this.sovc,
  });

  @override
  State<Speed> createState() => _SpeedState();
}

class _SpeedState extends State<Speed> {
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
                  value: widget.sdd[0],
                  onChanged: (String? newValue) {
                    List<String> newValues = List.from(widget.sdd);
                    newValues[0] = newValue!;
                    widget.sovc(newValues);
                  }),
              TextFormField(
                controller: widget.spd1[0],
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
                  value: widget.sdd[1],
                  onChanged: (String? newValue) {
                    List<String> newValues = List.from(widget.sdd);
                    newValues[1] = newValue!;
                    widget.sovc(newValues);
                  }),
              TextFormField(
                controller: widget.spd1[1],
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
