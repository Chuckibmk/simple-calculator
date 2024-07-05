import 'package:flutter/material.dart';

class Data extends StatefulWidget {
  // List of data textcontroller passed from parent page
  final List<TextEditingController> data1;

  // List of dropdown strings passed from parent page
  final List<String> dtdd;

  // function of dropdown OnValueChanged handling List of Strings
  final Function(List<String>) dovc;

  const Data({
    super.key,
    required this.data1,
    required this.dtdd,
    required this.dovc,
  });

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  // dropdown 1 Values
  var dd_1 = [
    'Bits (bit)',
    'Bytes (B)',
    'Kilobytes (KB)',
    'Kibibytes (KiB)',
    'Megabytes (MB)',
    'Mebibytes (MiB)',
    'Gigabytes (GB)',
    'Gibibytes (GiB)',
    'Terabytes (TB)',
    'Tebibytes (TiB)'
  ];

// dropdown 2 Values
  var dd_2 = [
    'Bits (bit)',
    'Bytes (B)',
    'Kilobytes (KB)',
    'Kibibytes (KiB)',
    'Megabytes (MB)',
    'Mebibytes (MiB)',
    'Gigabytes (GB)',
    'Gibibytes (GiB)',
    'Terabytes (TB)',
    'Tebibytes (TiB)'
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
                  //display index 0 of dtdd widget
                  value: widget.dtdd[0],
                  // onchange assign new selected value and pass thro ovc function
                  onChanged: (String? newValue) {
                    List<String> newValues = List.from(widget.dtdd);
                    newValues[0] = newValue!;
                    widget.dovc(newValues);
                  }),
              TextFormField(
                controller: widget.data1[0],
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
                  value: widget.dtdd[1],
                  onChanged: (String? newValue) {
                    List<String> newValues = List.from(widget.dtdd);
                    newValues[1] = newValue!;
                    widget.dovc(newValues);
                  }),
              TextFormField(
                controller: widget.data1[1],
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
