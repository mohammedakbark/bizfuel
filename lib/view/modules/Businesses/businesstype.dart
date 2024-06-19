import 'package:bizfuel/view/modules/Businesses/Business_post.dart';
import 'package:flutter/material.dart';

class Businesstype extends StatefulWidget {
  const Businesstype({super.key});

  @override
  State<Businesstype> createState() => _BusinesstypeState();
}

class _BusinesstypeState extends State<Businesstype> {
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
              padding: EdgeInsets.only(top: 40.0),
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
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Bizpost(
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
