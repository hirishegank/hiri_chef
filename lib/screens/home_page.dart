import 'package:flutter/material.dart';
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
                  ),
                  CardItem(
                    isPast: true,
                  ),
                  CardItem(
                    isPast: true,
                  ),
                  CardItem(
                    isPast: true,
                  ),
                  CardItem(
                    isPast: true,
                  ),
                  CardItem(
                    isPast: true,
                  ),
                ],
              ),
              ListView(
                children: [
                  CardItem(
                    onGoingCall: () => print('onging'),
                  ),
                  CardItem(
                    onGoingCall: () => print('onging'),
                  ),
                  CardItem(
                    onGoingCall: () => print('onging'),
                  ),
                  CardItem(
                    onGoingCall: () => print('onging'),
                  ),
                  CardItem(
                    onGoingCall: () => print('onging'),
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

class CardItemsPending extends StatelessWidget {
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
                        'UnitPrice    LKR 400',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        'Quantity    2',
                        style: TextStyle(fontSize: 10),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          const RaisedButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            child:
                                Text('Decline', style: TextStyle(fontSize: 20)),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          const RaisedButton(
                            textColor: Colors.white,
                            child:
                                Text('Accept', style: TextStyle(fontSize: 20)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
