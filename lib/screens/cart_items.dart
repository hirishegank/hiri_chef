import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:user/screens/add_food.dart';
import 'package:user/screens/menu_detail.dart';
// import 'package:font_awesome_flutter/fa_icon.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:user/components/big_button.dart';

// import 'package:user/components/delete_icon_button.dart';
// import 'package:user/components/home_category_buttom.dart';
// import 'package:user/screens/customize_screen.dart';
// import 'package:user/screens/delivery_option.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double total;

  FirebaseUser _firebaseUser;

  void getCurrentUser() async {
    _firebaseUser = await FirebaseAuth.instance.currentUser();
    setState(() {});
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(
        title: Text('Menu'),
        elevation: 0,
        centerTitle: true,
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddFoodPage()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            StreamBuilder(
              builder: (context, snapShot) {
                if (!snapShot.hasData) return Text('No Data');
                List<MenuCard> menuCard = [];
                menuCard = snapShot.data.documents.map<MenuCard>((f) {
                  return MenuCard(
                      imgUrl: f['imgUrl'],
                      foodName: f['food_name'],
                      rating: f['rating'],
                      numberOfRating: f['number_of_rating'],
                      price: f['price'].toDouble(),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MenuDetailsPage(
                                primaryKey: f.documentID,
                              ))));
                }).toList();
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: menuCard),
                );
              },
              stream: _firebaseUser != null
                  ? Firestore.instance
                      .collection("food")
                      .where('chef_id', isEqualTo: _firebaseUser.uid)
                      .snapshots()
                  : Stream.empty(),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final Function onTap;
  final String imgUrl;
  final String foodName;
  final double rating;
  final int numberOfRating;

  final double price;

  const MenuCard(
      {Key key,
      this.onTap,
      this.imgUrl,
      this.foodName,
      this.rating,
      this.numberOfRating,
      this.price})
      : super(key: key);

  Future<String> getImageUrl() async {
    // print(imgUrl);
    String url;
    url = await FirebaseStorage.instance.ref().child(imgUrl).getDownloadURL();

    return url;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        width: (MediaQuery.of(context).size.width - 80) / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: FutureBuilder(
                  future: getImageUrl(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return Image.network(
                        snapshot.data,
                        width: MediaQuery.of(context).size.width,
                        height: 130,
                        fit: BoxFit.cover,
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                this.foodName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Text(
                    'LKR ${price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  RatingBarIndicator(
                    rating: rating,
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
                  Text(
                    '($numberOfRating)',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  )
                ],
              ),
            )
          ],
        ),
        height: 250,
        color: Colors.grey.shade200,
      ),
    );
  }
}
