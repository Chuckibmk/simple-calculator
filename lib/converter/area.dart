import 'package:flutter/material.dart';

class Area extends StatefulWidget {
  // List of area textcontroller passed from parent page
  final List<TextEditingController> area1;

  // List of dropdown strings passed from parent page
  final List<String> dd1;

  // function of dropdown OnValueChanged handling List of Strings
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
  // dropdown 1 Values
  var dd_1 = [
    'Acres (ac)',
    'Ares (a)',
    'Hectares (ha)',
    'Square Centimeters (cm²)',
    'Square feet (ft²)',
    'Square inches (in²)',
    'Square meters (m²)'
  ];

  // dropdown 2 Values
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
                  // interate between all items in dropdown 1
                  items: dd_1.map((items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  isExpanded: true,
                  //display index 0 of dd1 widget
                  value: widget.dd1[0],
                  // onchange assign new selected value and pass thro ovc function
                  onChanged: (String? newValue) {
                    List<String> newValues = List.from(widget.dd1);
                    newValues[0] = newValue!;
                    widget.ovc(newValues);
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
                    List<String> newValues = List.from(widget.dd1);
                    newValues[1] = newValue!;
                    widget.ovc(newValues);
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
