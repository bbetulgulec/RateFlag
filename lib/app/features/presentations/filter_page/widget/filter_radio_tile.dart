import 'package:flutter/material.dart';

class FilterRadioTile<T> extends StatelessWidget {
  final String title;
  final T value;

  const FilterRadioTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(title: Text(title), value: value);
  }
}
