import 'package:flutter/material.dart';

class OrdrersPage extends StatefulWidget {
  @override
  _OrdrersPageState createState() => _OrdrersPageState();
}

class _OrdrersPageState extends State<OrdrersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              DashboardCard(
                title: 'Today',
                totalIncome: 8000,
                accptedOrders: 14,
                declinesOrders: 4,
                totalOrders: 18,
              ),
              DashboardCard(
                title: 'Last Week',
                totalIncome: 8000,
                accptedOrders: 14,
                declinesOrders: 4,
                totalOrders: 18,
              ),
              DashboardCard(
                title: 'Last Month',
                totalIncome: 8000,
                accptedOrders: 14,
                declinesOrders: 4,
                totalOrders: 18,
              )
            ],
          ),
        ));
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final int totalOrders;
  final int accptedOrders;
  final int declinesOrders;
  final double totalIncome;

  const DashboardCard(
      {Key key,
      this.title,
      this.accptedOrders,
      this.declinesOrders,
      this.totalIncome,
      this.totalOrders})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Total Orders'),
                Text('$totalOrders'),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Accpted Orders'),
                Text('$accptedOrders'),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Declined Orders'),
                Text('$declinesOrders'),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total Incone',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  'LKR ${totalIncome.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
