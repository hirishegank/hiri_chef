import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user/components/big_button.dart';
import 'bottom_navigation.dart';

class ProfilePage extends StatefulWidget {
  final String phoneNo;
  const ProfilePage({@required this.phoneNo});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name;
  String otherDetails;
  FirebaseUser _firebaseUser;
  bool _isDoorStep = true;
 
  String deliveryOption;
  final db = Firestore.instance;

  void getCurrentUser() async {
    _firebaseUser = await FirebaseAuth.instance.currentUser();
    checkAlreadyRegistered();
  }

  void registerUser() {
    db.collection("chef").document(_firebaseUser.uid).setData({
      'name': name,
      'otherDetails': otherDetails,
      'phoneNo': this.widget.phoneNo,
      'is_active': true,
    });
  }

  void checkAlreadyRegistered() async {
    final snapShot = await Firestore.instance
        .collection('chef')
        .document(_firebaseUser.uid)
        .get();

    print(snapShot['name']);
    //if  registered
    if (snapShot.exists) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomNavigation()));
    }
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Profile',
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Image.asset('assets/img/profile.png'),
                ),
                SizedBox(
                  height: 100,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45.0),
                      child: TextField(
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: "Eg: Hirishegan", labelText: 'Name'),
                        onChanged: (value) {
                          name = value;
                          print(name);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45.0),
                      child: TextField(
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: "Eg: 36, Ramakrishna Road, Colombo 06", labelText: 'Address '),
                        onChanged: (value) {
                          otherDetails = value;
                          print(otherDetails);
                        },
                      ),
                    ),
                    SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text('Delivery Method'),
              ),
              SizedBox(
                height: 20,
              ),
              
              
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                              child: InkWell(
                            onTap: () {
                              setState(() {
                                _isDoorStep = !_isDoorStep;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.green),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: _isDoorStep
                                    ? Icon(
                                        Icons.check,
                                        size: 30.0,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        Icons.check_box_outline_blank,
                                        size: 30.0,
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                          )),
                          Padding(
                            padding: const EdgeInsets.only(left:10.0),
                            child: Text('Door Step Pickup'),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                              child: InkWell(
                            onTap: () {
                              setState(() {
                                _isDoorStep = !_isDoorStep;
                                this.deliveryOption = _isDoorStep
                                    ? 'Door step pickup'
                                    : 'Door Delivery';
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.green),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: !_isDoorStep
                                    ? Icon(
                                        Icons.check,
                                        size: 30.0,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        Icons.check_box_outline_blank,
                                        size: 30.0,
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                          )),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text('Door Delivery'),
                          )
                        ],
                      ),
                    ),
                    
                    SizedBox(
                      height: 30,
                    ),
              
                    BigButton(
                      text: 'Save',
                      onPressed: () {
                        print('pressed');
                        registerUser(); //register user to the firestore
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => BottomNavigation()));
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
