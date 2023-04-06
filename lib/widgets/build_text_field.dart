import 'package:flutter/material.dart';

class buildTextField extends StatelessWidget {
  const buildTextField({
    Key? key,
    required this.label,
    required this.prefix,
    required this.controller,
    required this.changed,
  }) : super(key: key);

  final String label;
  final String prefix;
  final TextEditingController controller;
  final Function changed;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(
        color: Colors.amber,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        labelText: label,
        //hintText: 'R\$',
        prefixText: prefix,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber),
        ),
        hintStyle: const TextStyle(
          color: Colors.amber,
          fontSize: 20,
        ),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
          width: 3,
        )),
        labelStyle: const TextStyle(
          color: Colors.amber,
          fontSize: 20,
          fontWeight: FontWeight.w900,
        ),
      ),
      onChanged: changed as void Function(String)?,
    );
  }
}
