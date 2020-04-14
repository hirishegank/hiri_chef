import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:user/screens/food_confirm_order.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseUser _firebaseUser;
  String userName = '';

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
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: Colors.green,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(
                  icon: Text(
                'Past',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Muli',
                    fontWeight: FontWeight.w300),
              )),
              Tab(
                  icon: Text('Ongoing',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Muli',
                          fontWeight: FontWeight.w300))),
              Tab(
                  icon: Text('Pending',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Muli',
                          fontWeight: FontWeight.w300))),
            ],
          ),
          title: Align(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Hello cook $userName !',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            alignment: Alignment.topLeft,
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              _firebaseUser != null
                  ? StreamBuilder(
                      builder: (context, snapShot) {
                        if (!snapShot.hasData) return Text('Loading...');
                        return ListView.builder(
                            itemCount: snapShot.data.documents.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot ds =
                                  snapShot.data.documents[index];

                              return CardItem(
                                isPast: true,
                                foodId: ds['food_id'],
                                price: ds['unit_price'].toDouble(),
                                quantity: ds['quantity'],
                                onGoingCall: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => OrderConfirmPage(
                                              isPast: true,
                                            ))),
                              );
                            });
                      },
                      stream: Firestore.instance
                          .collection('orders')
                          .where('chef_id', isEqualTo: _firebaseUser.uid)
                          .where('status', isEqualTo: 'past')
                          .snapshots(),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),

              //Onging cards
              _firebaseUser != null
                  ? StreamBuilder(
                      builder: (context, snapShot) {
                        if (!snapShot.hasData) return Text('Loading...');

                        return ListView.builder(
                            itemCount: snapShot.data.documents.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot ds =
                                  snapShot.data.documents[index];
                              return CardItem(
                                foodId: ds['food_id'],
                                price: ds['unit_price'].toDouble(),
                                quantity: ds['quantity'],
                                onGoingCall: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => OrderConfirmPage(
                                      isPast: false,
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      stream: Firestore.instance
                          .collection('orders')
                          .where('chef_id', isEqualTo: _firebaseUser.uid)
                          .where('status', isEqualTo: 'on_going')
                          .snapshots(),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),

              //pendig cards
              _firebaseUser != null
                  ? StreamBuilder(
                      builder: (context, snapShot) {
                        if (!snapShot.hasData) return Text('Loading...');
                        return ListView.builder(
                            itemCount: snapShot.data.documents.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot ds =
                                  snapShot.data.documents[index];
                              return CardItem(
                                foodId: ds['food_id'],
                                price: ds['unit_price'].toDouble(),
                                quantity: ds['quantity'],
                                isPending: true,
                                onDecline: () => Firestore.instance
                                    .collection('orders')
                                    .document(ds.documentID)
                                    .updateData({'status': 'declined'}),
                                onAccpet: () => Firestore.instance
                                    .collection('orders')
                                    .document(ds.documentID)
                                    .updateData({'status': 'on_going'}),
                              );
                            });
                      },
                      stream: Firestore.instance
                          .collection('orders')
                          .where('chef_id', isEqualTo: _firebaseUser.uid)
                          .where('status', isEqualTo: 'pending')
                          .snapshots(),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final bool isPast;
  final bool isPending;
  final Function onDecline;
  final Function onAccpet;
  final Function onGoingCall;
  final double price;
  final int quantity;
  final String foodId;
  const CardItem(
      {Key key,
      this.foodId = '',
      this.price = 0.0,
      this.quantity = 0,
      this.isPending = false,
      this.onDecline,
      this.onAccpet,
      this.isPast = false,
      this.onGoingCall})
      : super(key: key);

  Future<String> getImageUrl() async {
    dynamic food =
        await Firestore.instance.collection('food').document(this.foodId).get();
    String imgUrl = food['imgUrl'];
    String url;
    url = await FirebaseStorage.instance.ref().child(imgUrl).getDownloadURL();

    return url;
  }

  @override
  Widget build(BuildContext context) {
    print(this.foodId);
    return GestureDetector(
      onTap: onGoingCall,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FutureBuilder(
                    future: getImageUrl(),
                    builder: (BuildContext context,
                        AsyncSnapshot<String> future_snapshot) {
                      if (future_snapshot.hasData) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            future_snapshot.data,
                            colorBlendMode: BlendMode.saturation,
                            color: isPast ? Colors.black : Colors.transparent,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 100,
                            width: 100,
                            color: Colors.grey.shade200,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ));
                    }),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FutureBuilder(
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return Text('Loding..');
                            return Text(
                              snapshot.data['food_name'],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            );
                          },
                          future: Firestore.instance
                              .collection('food')
                              .document(this.foodId)
                              .get(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Unit price',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              'LKR ${this.price.toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Qunatity',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              '$quantity',
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ]),
                ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            isPending
                ? Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: onDecline,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5)),
                            margin: EdgeInsets.only(right: 10),
                            height: 40,
                            child: Center(
                              child: Text(
                                'Decline',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: onAccpet,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5)),
                            margin: EdgeInsets.only(left: 10),
                            height: 40,
                            child: Center(
                              child: Text(
                                'Accept',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : SizedBox(
                    width: 1,
                  ),
          ],
        ),
      ),
    );
  }
}
