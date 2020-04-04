import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:user/screens/add_food.dart';

import 'package:user/screens/cook_details.dart';

class MenuDetailsPage extends StatefulWidget {
  final String primaryKey;
  MenuDetailsPage({this.primaryKey});

  @override
  _MenuDetailsPageState createState() => _MenuDetailsPageState();
}

class _MenuDetailsPageState extends State<MenuDetailsPage> {
  bool addeddToChart = false;
  List<String> ingredients;

  _onAlertButtonsPressed(context) {
    Alert(
      style: AlertStyle(isCloseButton: false, isOverlayTapDismiss: false),
      context: context,
      title: "Delete Food",
      desc: "Are you sure want to delete this food item ?",
      buttons: [
        DialogButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "Delete",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          color: Colors.red,
        )
      ],
    ).show();
  }

  @override
  void initState() {
    ingredients = [
      'ingredients',
      'ingredients',
      'ingredients',
      'ingredients',
      'ingredients'
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Name'),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 10),
            icon: Text(
              'Edit',
              style: TextStyle(color: Colors.green),
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddFoodPage()));
            },
          )
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20.0),
              child: Image.asset(
                'assets/img/foodSample.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CookDetailsPage()));
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Cooked by ',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Muli',
                            fontSize: 20),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Shan',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        '4.1',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(width: 3),
                      RatingBarIndicator(
                        rating: 4.1,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemSize: 12,
                        unratedColor: Colors.green.shade100,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        '400',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: <Widget>[
                    Text(
                      'Ingredients',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: ingredients
                          .map((txt) => Text(
                                txt,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 20),
                              ))
                          .toList(),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _onAlertButtonsPressed(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5)),
                        margin: EdgeInsets.only(right: 10),
                        height: 50,
                        child: Center(
                          child: Text(
                            'Delete',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
