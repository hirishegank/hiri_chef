import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/services.dart';

class AddFoodPage extends StatefulWidget {
  const AddFoodPage({Key key}) : super(key: key);

  @override
  _AddFoodPageState createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  String foodName;
  String ing;
  List<String> ingredients = [];
  final db = Firestore.instance;
  String name;
  String otherDetails;
  FirebaseUser _firebaseUser;
  String description;
  double price;
  File file;
  String fileName = '';
  String fileLocation = '';
  void getCurrentUser() async {
    _firebaseUser = await FirebaseAuth.instance.currentUser();
  }

  Future<void> _uploadFile(File file, String _filename) async {
    fileName = new DateTime.now().millisecondsSinceEpoch.toString() + _filename;
    var storageReference = FirebaseStorage.instance.ref().child("$fileName");
    final StorageUploadTask uploadTask = storageReference.putFile(file);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");
  }

  Future filePicker(BuildContext context) async {
    try {
      file = await FilePicker.getFile(type: FileType.image);
      setState(() {
        fileLocation = file.path;
        fileName = p.basename(file.path);
      });
      print(fileName);
      // _uploadFile(file, fileName);
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sorry...'),
              content: Text('Unsupported exception: $e'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  void addFood() {
    db.collection('food').add({
      'food_name': foodName,
      'ingrediance': ingredients,
      'chef_id': _firebaseUser.uid,
      'ingrediance': ingredients,
      'description': description,
      'number_of_rating': 0,
      'rating': 5.0,
      'imgUrl': fileName,
      'price': price,
    });
  }

  TextEditingController ingController = TextEditingController();

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  void dispose() {
    ingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Food'),
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
              GestureDetector(
                onTap: () {
                  filePicker(context);
                },
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width - 60,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: fileLocation == ''
                          ? Stack(
                              children: <Widget>[
                                Image.asset(
                                  'assets/img/customizeFoodSample.png',
                                  colorBlendMode: BlendMode.saturation,
                                  color: Colors.black45,
                                  fit: BoxFit.fitHeight,
                                ),
                                Center(
                                    child: Icon(
                                  Icons.camera,
                                  color: Colors.white,
                                  size: 50,
                                )),
                              ],
                            )
                          : Image.asset(
                              fileLocation,
                              fit: BoxFit.fitWidth,
                            )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Food Name',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                onChanged: (value) {
                  foodName = value;
                  print(foodName);
                },
                decoration: InputDecoration(
                    hintText: 'Ex:Pizza',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                onChanged: (value) {
                  description = value;
                },
                decoration: InputDecoration(
                    hintText: 'Enter the description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Price',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  price = double.parse(value);
                },
                decoration: InputDecoration(
                    hintText: 'Enter the price',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Ingredients',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      controller: ingController,
                      onChanged: (value) {
                        ing = value;
                      },
                      decoration: InputDecoration(
                          hintText: 'Ex:Salt',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 3),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.black54,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        if (ing != '' && ingController.text != '')
                          setState(() {
                            ingredients.add(ing);
                            ing = '';
                          });
                        ingController.text = '';
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ingredients == []
                  ? SizedBox(
                      width: 1,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: ingredients.map((txt) => Text(txt)).toList(),
                    ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _uploadFile(file, fileName);
                          addFood();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5)),
                          margin: EdgeInsets.only(right: 10),
                          height: 50,
                          child: Center(
                            child: Text(
                              'Save',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
