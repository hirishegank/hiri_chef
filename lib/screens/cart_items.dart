import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user/components/big_button.dart';

import 'package:user/components/delete_icon_button.dart';
import 'package:user/components/home_category_buttom.dart';
import 'package:user/screens/customize_screen.dart';
import 'package:user/screens/delivery_option.dart';

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
        // Add your onPressed code here!
      },
      child: Icon(Icons.navigation),
      backgroundColor: Colors.green,
    ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            CartItemCard(),
            CartItemCard(),
            CartItemCard(),
            CartItemCard(),
            CartItemCard(),
            CartItemCard(),
          ],
        ),
      ),
    );
  }
}

class CartItemCard extends StatefulWidget {
  const CartItemCard({
    Key key,
  }) : super(key: key);

  @override
  _CartItemCardState createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  double ammount = 400;
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/img/cartFoodSample.png',
                    fit: BoxFit.cover,
                  ),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Keerai Putt',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '4.1 (Rating)',
                        style: TextStyle(fontSize: 10),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    child: Center(
                                      
                                    ),
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border:
                                            Border.all(color: Colors.green)),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                   
                     
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}


