import 'package:flutter/material.dart';

class LabelComponent extends StatelessWidget {
  Widget child;
  String label;
  LabelComponent({Key? key, required this.child, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(label),
          ),
          child
        ],
      ),
    );
  }
}
