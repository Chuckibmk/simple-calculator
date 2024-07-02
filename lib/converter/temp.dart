import 'package:flutter/material.dart';

class Temp extends StatefulWidget {
  final List<TextEditingController> temp1;
  final List<String> tdd;
  final Function(List<String>) tovc;

  const Temp({
    Key? key,
    required this.temp1,
    required this.tdd,
    required this.tovc,
  }) : super(key: key);

  @override
  State<Temp> createState() => _TempState();
}

class _TempState extends State<Temp> {
  var dd_1 = ['Celsius (℃)', 'Fahrenheit (℉)', 'Kelvin (K)'];

  var dd_2 = ['Celsius (℃)', 'Fahrenheit (℉)', 'Kelvin (K)'];

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
                  value: widget.tdd[0],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      List<String> newValues = List.from(widget.tdd);
                      newValues[0] = newValue;
                      widget.tovc(newValues);
                    }
                  }),
              TextFormField(
                controller: widget.temp1[0],
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
                  value: widget.tdd[1],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      List<String> newValues = List.from(widget.tdd);
                      newValues[1] = newValue;
                      widget.tovc(newValues);
                    }
                  }),
              TextFormField(
                controller: widget.temp1[1],
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
