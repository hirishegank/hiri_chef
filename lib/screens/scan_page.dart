import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

import 'bottom_navigation.dart';

class ScanPage extends StatefulWidget {
  final String qrCode;
  final String orderId;
  ScanPage({this.qrCode, this.orderId});
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String barcode = "";

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
      if (barcode == this.widget.qrCode) {
        updateFirestoreStatus();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => BottomNavigation()));
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  updateFirestoreStatus() {
    Firestore.instance
        .collection('orders')
        .document(this.widget.orderId)
        .updateData({'status': 'past'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Here'),
        centerTitle: true,
        elevation: 0,
      ),
      body: MaterialButton(
          onPressed: scan,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.asset('assets/img/qrDisplay.png'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Scan here to complete\nyour food delivery',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              )),
            ],
          )),
    );
  }
}
