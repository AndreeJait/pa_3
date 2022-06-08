import 'package:flutter/material.dart';
import 'package:pa_3/constans/general_router_constant.dart';

class ProfileVisitorComponent extends StatefulWidget {
  const ProfileVisitorComponent({Key? key}) : super(key: key);

  @override
  State<ProfileVisitorComponent> createState() =>
      _ProfileVisitorComponentState();
}

class _ProfileVisitorComponentState extends State<ProfileVisitorComponent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            bigText("Oops, you don't have a profile yet!"),
            Image.asset(
              "assets/images/male_profile.png",
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
            ),
            bigText("Come join so you can place an order for the product!"),
            ElevatedButton(
              style: raisedButtonstyle,
              child: const Text("REGISTER NOW"),
              onPressed: () {
                Navigator.pushNamed(context, routeRegister);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget bigText(String text) => Text(
        text,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xff585858)),
      );

  final ButtonStyle raisedButtonstyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: const Color(0xffF8C83F),
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );
}
