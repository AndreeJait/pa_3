import 'package:flutter/material.dart';
import 'package:pa_3/utils/view_models.dart';

class HeaderDashboard extends StatelessWidget {
  const HeaderDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          flex: 1,
          child: Container(
            height: 40,
            color: Colors.lightBlue[100],
          )),
      Expanded(
          flex: 35,
          child: Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.lightBlue[100],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Selamat Datang"),
                        Text(
                          ViewModels.getState("user").role,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )
                      ]),
                ),
                ClipOval(
                  child: Image.network(
                    "https://picsum.photos/250?image=9",
                    height: 50,
                  ),
                ),
              ],
            ),
          )),
      Expanded(
          flex: 1,
          child: Container(
            height: 40,
            color: Colors.lightBlue[100],
          ))
    ]);
  }
}
