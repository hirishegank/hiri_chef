import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:user/screens/add_food.dart';

import 'package:user/screens/cook_details.dart';

import 'cart_items.dart';

class MenuDetailsPage extends StatefulWidget {
  final String primaryKey;
  MenuDetailsPage({this.primaryKey});

  @override
  _MenuDetailsPageState createState() => _MenuDetailsPageState();
}

class _MenuDetailsPageState extends State<MenuDetailsPage> {
  bool addeddToChart = false;

  Future<String> getImageUrl(String imgUrl) async {
    // print(imgUrl);
    String url;
    url = await FirebaseStorage.instance.ref().child(imgUrl).getDownloadURL();

    return url;
  }

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
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Future.delayed(const Duration(milliseconds: 10), () {
              Firestore.instance
                  .collection('food')
                  .document(this.widget.primaryKey)
                  .delete();
            });
          },
          color: Colors.red,
        )
      ],
    ).show();
  }

  @override
  void initState() {
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
        child: StreamBuilder(
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: FutureBuilder(
                        future: getImageUrl(snapShot.data['imgUrl']),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> future_snapshot) {
                          if (future_snapshot.hasData) {
                            return Image.network(
                              future_snapshot.data,
                              width: MediaQuery.of(context).size.width,
                              height: 250,
                              fit: BoxFit.cover,
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          snapShot.data['food_name'],
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        Text(
                          'LKR ${snapShot.data['price'].toStringAsFixed(2)}',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        RatingBarIndicator(
                          rating: snapShot.data['rating'],
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 25,
                          unratedColor: Colors.green.shade100,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.green,
                          ),
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
                            'Descritpion',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          snapShot.data['description'] != null
                              ? Text(
                                  snapShot.data['description'],
                                  style: TextStyle(color: Colors.grey),
                                )
                              : Text(
                                  'No description',
                                  style: TextStyle(color: Colors.grey),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Ingredients',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          snapShot.data['ingrediance'] != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: snapShot.data['ingrediance']
                                      .map<Text>(
                                        (f) => Text(
                                          f,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      )
                                      .toList(),
                                )
                              : Text(
                                  'No details',
                                  style: TextStyle(color: Colors.grey),
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Text('loading...');
          },
          stream: Firestore.instance
              .collection("food")
              .document(this.widget.primaryKey)
              .snapshots(),
        ),
      ),
    );
  }
}
