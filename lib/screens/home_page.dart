import 'package:flutter/material.dart';
import 'package:user/screens/food_confirm_order.dart';
// import 'package:user/components/best_food_card.dart';
// import 'package:user/components/home_category_buttom.dart';
// import 'package:user/components/popular_food_card.dart';
// import 'package:user/constants.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchText;
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
                'Hello cook Kabali !',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            alignment: Alignment.topLeft,
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              ListView(
                children: <Widget>[
                  CardItem(
                    isPast: true,
                    onGoingCall: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrderConfirmPage(
                                  isPast: true,
                                ))),
                  ),
                  CardItem(
                    isPast: true,
                    onGoingCall: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrderConfirmPage(
                                  isPast: true,
                                ))),
                  ),
                  CardItem(
                    isPast: true,
                    onGoingCall: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrderConfirmPage(
                                  isPast: true,
                                ))),
                  ),
                  CardItem(
                    isPast: true,
                    onGoingCall: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrderConfirmPage(
                                  isPast: true,
                                ))),
                  ),
                  CardItem(
                    isPast: true,
                    onGoingCall: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrderConfirmPage(
                                  isPast: true,
                                ))),
                  ),
                ],
              ),
              ListView(
                children: [
                  CardItem(
                    onGoingCall: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OrderConfirmPage(
                          isPast: false,
                        ),
                      ),
                    ),
                  ),
                  CardItem(
                    onGoingCall: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OrderConfirmPage(
                          isPast: false,
                        ),
                      ),
                    ),
                  ),
                  CardItem(
                    onGoingCall: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OrderConfirmPage(
                          isPast: false,
                        ),
                      ),
                    ),
                  ),
                  CardItem(
                    onGoingCall: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OrderConfirmPage(
                          isPast: false,
                        ),
                      ),
                    ),
                  ),
                  CardItem(
                    onGoingCall: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OrderConfirmPage(
                          isPast: false,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ListView(
                children: [
                  CardItem(
                    isPending: true,
                    onAccpet: () => print('accept'),
                    onDecline: () => print('decline'),
                  ),
                  CardItem(
                    isPending: true,
                    onAccpet: () => print('accept'),
                    onDecline: () => print('decline'),
                  ),
                  CardItem(
                    isPending: true,
                    onAccpet: () => print('accept'),
                    onDecline: () => print('decline'),
                  ),
                  CardItem(
                    isPending: true,
                    onAccpet: () => print('accept'),
                    onDecline: () => print('decline'),
                  ),
                ],
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
  const CardItem(
      {Key key,
      this.isPending = false,
      this.onDecline,
      this.onAccpet,
      this.isPast = false,
      this.onGoingCall})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/img/sampleFood.png',
                    colorBlendMode: BlendMode.saturation,
                    color: isPast ? Colors.black : Colors.transparent,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Food Name',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                              'LKR 3000.00',
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
                              '3',
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
