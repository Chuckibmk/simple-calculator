import 'package:flutter/material.dart';

class Time extends StatefulWidget {
  final List<TextEditingController> time1;
  // final TextEditingController time2;

  const Time({super.key, required this.time1});
  // const Time({super.key, required this.time1, required this.time2});

  @override
  State<Time> createState() => _TimeState();
}

class _TimeState extends State<Time> {
  // dynamic activeform;
  String dd1 = 'Seconds (s)';
  var dd_1 = [
    'Milliseconds (ms)',
    'Seconds (s)',
    'Minutes (min)',
    'Hours (h)',
    'Days (d)',
    'Weeks (wk)'
  ];

  String dd2 = 'Hours (h)';
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
                  value: dd1,
                  onChanged: (value) {
                    setState(() {
                      dd1 = value.toString();
                    });
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
                  value: dd2,
                  onChanged: (value) {
                    setState(() {
                      dd2 = value.toString();
                    });
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
