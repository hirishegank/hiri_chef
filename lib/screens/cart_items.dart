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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: <Widget>[
                  MenuCard(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MenuDetailsPage()))),
                  MenuCard(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MenuDetailsPage()))),
                  MenuCard(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MenuDetailsPage()))),
                  MenuCard(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MenuDetailsPage()))),
                  MenuCard(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MenuDetailsPage()))),
                  MenuCard(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MenuDetailsPage()))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final Function onTap;
  const MenuCard({Key key, this.onTap}) : super(key: key);

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
              child: Image.asset(
                'assets/img/walk1.png',
                width: (MediaQuery.of(context).size.width - 120) / 2,
                height: (MediaQuery.of(context).size.width - 120) / 2 - 10,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Food Name',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Text(
                    '4.1',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
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
                  Text(
                    '(200)',
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
