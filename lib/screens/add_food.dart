import 'package:flutter/material.dart';

class AddFoodPage extends StatefulWidget {
  const AddFoodPage({Key key}) : super(key: key);

  @override
  _AddFoodPageState createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  String foodName;
  String ing;
  List<String> ingredients = [];

  TextEditingController ingController = TextEditingController();

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
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width - 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/img/customizeFoodSample.png',
                    colorBlendMode: BlendMode.saturation,
                    fit: BoxFit.fitHeight,
                  ),
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
                        ingController.text = '';
                        if (ing != '')
                          setState(() {
                            ingredients.add(ing);
                            ing = '';
                          });
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
                        onTap: () => Navigator.of(context).pop(),
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
