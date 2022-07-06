import 'package:flutter/material.dart';

import 'package:pa_3/model/user.dart';
import 'package:pa_3/utils/user_utils.dart';
import 'package:pa_3/utils/view_models.dart';

class ProfileConsumerComponent extends StatefulWidget {
  const ProfileConsumerComponent({Key? key}) : super(key: key);

  @override
  State<ProfileConsumerComponent> createState() =>
      _ProfileConsumerComponentState();
}

class _ProfileConsumerComponentState extends State<ProfileConsumerComponent> {
  User user = ViewModels.getState("user");
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Colors.white,
                ),
                child: Image.asset(
                  "assets/images/profilebg.png",
                  fit: BoxFit.fitHeight,
                ),
              ),
              Positioned(
                child: CircleAvatar(
                  radius: 70,
                  child: Image.asset(
                    "assets/images/profilebg.png",
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          fullname(user.name),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.2,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.indigo[50],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                subtitle("Email"),
                detailText(user.email),
                const SizedBox(
                  height: 20,
                ),
                subtitle("Nomor Telepon"),
                detailText(user.phoneNumber),
                const SizedBox(
                  height: 20,
                ),
                subtitle("Alamat"),
                detailText(user.address),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: raisedButtonstyle,
                  child: const Text("Logout"),
                  onPressed: () {
                    setState(() {
                      logOut(context);
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final ButtonStyle raisedButtonstyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: const Color(0xffF15850),
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );

  Widget fullname(text) => Text(
        text,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xff585858),
        ),
      );
  Widget subtitle(text) => Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xff585858),
        ),
      );
  Widget detailText(text) => Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: Color(0xff585858),
        ),
      );
}
