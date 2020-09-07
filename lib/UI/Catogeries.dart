import 'package:flutter/material.dart';

class Catrogeries extends StatefulWidget {
  static const routeName = '/catogeries';
  @override
  _CatrogeriesState createState() => _CatrogeriesState();
}

class _CatrogeriesState extends State<Catrogeries> {
  // ignore: non_constant_identifier_names
  List<String> mobile_catogery = [
    "Mobile Phones",
    "HeadPhones and audio devices",
    "Mobile Acceseriees"
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: ListView.builder(
          itemCount: mobile_catogery.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Text(mobile_catogery[index])),
    );
  }

  Widget buildCatogery(int index) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          Text(
            mobile_catogery[index],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            height: 2,
            width: 30,
            margin: EdgeInsets.only(top: 4),
          )
        ]));
  }
}
