import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pa_3/component/admin/ContainerDashboard/header_dashboard.dart';
import 'package:pa_3/model/card_info_admin.dart';

class HomeAdminComponent extends StatelessWidget {
  HomeAdminComponent({Key? key}) : super(key: key);
  List<CardInfoAdmin> infos = [
    CardInfoAdmin(
        icon: FaIcon(
          FontAwesomeIcons.users,
          size: 30,
          color: Colors.blueAccent[100],
        ),
        name: "Consumer",
        value: 994098),
    CardInfoAdmin(
        icon: FaIcon(
          FontAwesomeIcons.users,
          size: 30,
          color: Colors.blueAccent[100],
        ),
        name: "Admin",
        value: 994098),
    CardInfoAdmin(
        icon: FaIcon(
          FontAwesomeIcons.users,
          size: 30,
          color: Colors.blueAccent[100],
        ),
        name: "Marketing",
        value: 994098)
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
        children: [
          const HeaderDashboard(),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Wrap(
                    runSpacing: 10,
                    children: const [
                      Text(
                          "Jangan lupa untuk selalu Sign Out setelah selesai menggunakan fasilitas Administrator ini."),
                      Text(
                          "Biasakan Mengganti Password Administrator secara rutin setiap 1-2 kali dalam sebulan.")
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...infos.map((e) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Wrap(
                        direction: Axis.vertical,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 5,
                        children: [
                          e.icon,
                          Text(e.name),
                          Text(e.value.toString())
                        ],
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    ));
  }
}
