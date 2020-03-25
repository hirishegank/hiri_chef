import 'package:flutter/material.dart';
import 'package:user/components/best_food_card.dart';
import 'package:user/components/home_category_buttom.dart';
import 'package:user/components/popular_food_card.dart';
import 'package:user/constants.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchText;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor:Colors.green,
            bottom: TabBar(
              tabs: [
                Tab(icon: Text('Past')),
                Tab(icon: Text('Ongoing')),
                Tab(icon: Text('Pending')),
              ],
            ),
            title: Text('Track Orders'),
          ),
          body: TabBarView(
            children: [
              Column(
                children:[CardItems(),CardItems()],),
              Column(
                children:[CardItems(),CardItems()],),
             Column(
                children:[CardItemsPending(),CardItemsPending()],),
            ],
          ),
        ),
      ),
    ),
    );
  }
}

class CardItems extends StatelessWidget{
  @override
  Widget build(BuildContext context){
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
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              child: Row(
                              ),
                            ),
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



class CardItemsPending extends StatelessWidget{
  @override
  Widget build(BuildContext context){
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
                            color:Colors.red,
                            textColor: Colors.white,
                            child: Text(
                                'Decline',
                                style: TextStyle(fontSize: 20)
                              ),
                        ),
                         SizedBox(
                        width: 2,
                      ),
                        const RaisedButton(
                          textColor: Colors.white,
                            child: Text(
                                'Accept',
                                style: TextStyle(fontSize: 20)
                              ),
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