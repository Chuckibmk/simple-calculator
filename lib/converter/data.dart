import 'package:flutter/material.dart';

class data extends StatefulWidget {
  const data({super.key});

  @override
  State<data> createState() => _dataState();
}

class _dataState extends State<data> {
  final form1 = TextEditingController();
  final form2 = TextEditingController();

  // dynamic activeform;
  String dd1 = 'Kilobytes (KB)';
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

  String dd2 = 'Megabytes (MB)';
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
