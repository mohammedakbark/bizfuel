import 'package:bizfuel/view/modules/Resellers/itemview.dart';
import 'package:flutter/material.dart';

class Bistypes extends StatefulWidget {
  const Bistypes({super.key});

  @override
  State<Bistypes> createState() => _BistypesState();
}

class _BistypesState extends State<Bistypes> {
  List<String> buttonName = [
    'Car',
    'Properties',
    'Mobiles',
    'Fashion',
    'Bikes',
    'Watches',
    'Shoes',
    'Furnichures',
    'Books',
    'Skin Cares',
    'Other'
  ];
  List<IconData> icon = [
    Icons.car_crash_outlined,
    Icons.list_alt_outlined,
    Icons.mobile_friendly_outlined,
    Icons.girl,
    Icons.pedal_bike_outlined,
    Icons.watch,
    Icons.snowshoeing_outlined,
    Icons.chair,
    Icons.library_books_rounded,
    Icons.tag_faces,
    Icons.tag
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50),
              child: Row(
                children: [
                  Icon(Icons.arrow_back),
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    "Business Type",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10, top: 0, left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Recommentation(
                                      type: buttonName[index],
                                    )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                icon[index],
                                size: 30,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                buttonName[index],
                                style: const TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 1,
                ),
                itemCount: 11,
              ),
            )
          ],
        ),
      ),
    );
  }
}
