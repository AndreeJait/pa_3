import 'package:flutter/material.dart';

class AboutMarketingComponent extends StatefulWidget {
  const AboutMarketingComponent({Key? key}) : super(key: key);

  @override
  State<AboutMarketingComponent> createState() =>
      _AboutMarketingComponentState();
}

class _AboutMarketingComponentState extends State<AboutMarketingComponent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.indigo[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  title("What is Marketing?"),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset("assets/images/male_sit.png"),
                  const SizedBox(
                    height: 10,
                  ),
                  detailText(
                      "Marketing is a distributor of Sutar and Mozzataru Milk who will bring flagship products to consumers who have bought our products.")
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.indigo[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  title("Marketing Tasks"),
                  const SizedBox(
                    height: 10,
                  ),
                  subtitle("“Customer satisfaction is our happiness”"),
                  const SizedBox(
                    height: 20,
                  ),
                  myBulletList(
                      "Ensure that the product ordered is in accordance with the product to be brought"),
                  const SizedBox(
                    height: 10,
                  ),
                  myBulletList("Bringing products safely to consumers"),
                  const SizedBox(
                    height: 10,
                  ),
                  myBulletList("See the expiration date of the product"),
                  const SizedBox(
                    height: 10,
                  ),
                  myBulletList(
                      "Ensuring the product has been accepted into the hands of consumers"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget title(text) => Text(
        text,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xff585858),
        ),
      );

  Widget subtitle(text) => Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xff585858),
        ),
      );

  Widget detailText(text) => Text(
        text,
        textAlign: TextAlign.center,
        maxLines: 3,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Color(0xff585858),
        ),
      );

  Widget taskListText(text) => Expanded(
        child: Text(
          text,
          textAlign: TextAlign.left,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Color(0xff585858),
          ),
        ),
      );

  Widget myBulletList(text) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 10.0,
            width: 10.0,
            decoration: const BoxDecoration(
              color: Color(0xffF8C83F),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(
            width: 25,
          ),
          taskListText(text),
        ],
      );
}
