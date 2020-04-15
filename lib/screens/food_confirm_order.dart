import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user/screens/scan_page.dart';

class OrderConfirmPage extends StatelessWidget {
  const OrderConfirmPage(
      {Key key, @required this.isPast, this.orderId, this.isPending = false})
      : super(key: key);
  final bool isPast;
  final bool isPending;
  final String orderId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('orders')
          .document(this.orderId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        return FutureBuilder(
          future: Firestore.instance
              .collection('food')
              .document(snapshot.data['food_id'])
              .get(),
          builder: (context, futureSnapshot) {
            if (!futureSnapshot.hasData)
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            return Scaffold(
              appBar: AppBar(
                title: Text(futureSnapshot.data['food_name']),
                centerTitle: true,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width - 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FutureBuilder(
                              future: FirebaseStorage.instance
                                  .ref()
                                  .child(futureSnapshot.data['imgUrl'])
                                  .getDownloadURL(),
                              builder: (context, new_future_snapshot) {
                                if (new_future_snapshot.hasData) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      new_future_snapshot.data,
                                      colorBlendMode: BlendMode.saturation,
                                      color: isPast
                                          ? Colors.black
                                          : Colors.transparent,
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
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        futureSnapshot.data['description'],
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Ordered by Kumar'),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Ingredients',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      futureSnapshot.data['ingrediance'].toString() != null
                          ? Text(
                              futureSnapshot.data['ingrediance']
                                  .toString()
                                  .substring(
                                      1,
                                      futureSnapshot.data['ingrediance']
                                              .toString()
                                              .length -
                                          1),
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            )
                          : Text(
                              'No details',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Customization'),
                                Text('No Pumpkin')
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Delivery Type'),
                                Text('Door step pickup')
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Dine in'),
                                Text('-'), //date goes in this text widget
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Unit Price'),
                                Text(
                                    'LKR ${futureSnapshot.data['price'].toStringAsFixed(2)}')
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Quantity'),
                                Text('${snapshot.data['quantity']}')
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Delivery Fee'),
                                Text(
                                    'LKR ${snapshot.data['delivery_fee'].toStringAsFixed(2)}')
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Total',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'LKR ${(snapshot.data['delivery_fee'] + futureSnapshot.data['price'] * snapshot.data['quantity']).toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          isPast || isPending
                              ? SizedBox(
                                  width: 10,
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      ScanPage())),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            margin: EdgeInsets.only(right: 10),
                                            height: 50,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                FaIcon(
                                                  FontAwesomeIcons.qrcode,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Scan Here',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
