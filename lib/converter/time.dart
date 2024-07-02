import 'package:flutter/material.dart';

class Time extends StatefulWidget {
  final List<TextEditingController> time1;
  final List<String> tidd;
  final Function(List<String>) tiovc;

  const Time({
    super.key,
    required this.time1,
    required this.tidd,
    required this.tiovc,
  });
  // const Time({super.key, required this.time1, required this.time2});

  @override
  State<Time> createState() => _TimeState();
}

class _TimeState extends State<Time> {
  var dd_1 = [
    'Milliseconds (ms)',
    'Seconds (s)',
    'Minutes (min)',
    'Hours (h)',
    'Days (d)',
    'Weeks (wk)'
  ];

  var dd_2 = [
    'Milliseconds (ms)',
    'Seconds (s)',
    'Minutes (min)',
    'Hours (h)',
    'Days (d)',
    'Weeks (wk)'
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
                  value: widget.tidd[0],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      List<String> newValues = List.from(widget.tidd);
                      newValues[0] = newValue;
                      widget.tiovc(newValues);
                    }
                  }),
              TextFormField(
                controller: widget.time1[0],
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
                  value: widget.tidd[1],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      List<String> newValues = List.from(widget.tidd);
                      newValues[1] = newValue;
                      widget.tiovc(newValues);
                    }
                  }),
              TextFormField(
                controller: widget.time1[1],
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
