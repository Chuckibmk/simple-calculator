import 'package:flutter/material.dart';

class Data extends StatefulWidget {
  final List<TextEditingController> data1;
  final List<String> dtdd;
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
                  items: dd_1.map((items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  isExpanded: true,
                  value: widget.dtdd[0],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      List<String> newValues = List.from(widget.dtdd);
                      newValues[0] = newValue;
                      widget.dovc(newValues);
                    }
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
                    if (newValue != null) {
                      List<String> newValues = List.from(widget.dtdd);
                      newValues[1] = newValue;
                      widget.dovc(newValues);
                    }
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
