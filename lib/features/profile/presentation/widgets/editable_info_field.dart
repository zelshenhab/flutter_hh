import 'package:flutter/material.dart';

class EditableInfoField extends StatelessWidget {
  final String label;
  final String value;
  final void Function(String) onChanged;

  const EditableInfoField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
    );
  }
}
