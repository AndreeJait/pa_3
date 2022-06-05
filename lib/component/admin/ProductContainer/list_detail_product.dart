import 'package:flutter/material.dart';

class ListDetailProduct extends StatelessWidget {
  String value;
  String name;
  ListDetailProduct({Key? key, required this.value, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(name),
          ),
          const Expanded(
            flex: 1,
            child: Text(":"),
          ),
          Expanded(
            flex: 9,
            child: Text(value),
          )
        ],
      ),
    );
  }
}
