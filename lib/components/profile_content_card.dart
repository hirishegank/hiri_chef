import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProfileContentCard extends StatelessWidget {
  final Widget icon;
  final String lable;
  final Function onTap;
  const ProfileContentCard(
      {Key key, this.icon, @required this.lable, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 5,
            ),
            icon ??
                SizedBox(
                  height: 1,
                ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(lable),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    Key key,
  }) : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  FirebaseUser _firebaseUser;
  String userName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    _firebaseUser = await FirebaseAuth.instance.currentUser();
    final userDetails = await Firestore.instance
        .collection('chef')
        .document(_firebaseUser.uid)
        .get();
    setState(() {
      userName = userDetails['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              'assets/img/walk1.png',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                this.userName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              RatingBarIndicator(
                rating: 4.3,
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
              Text(
                '  Joined 2 weeks ago',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ))
        ],
      ),
    );
  }
}
