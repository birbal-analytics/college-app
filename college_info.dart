import 'package:flutter/material.dart';
class CollegeInfo {
  String name;
  String tuition;
  String location;
  CollegeInfo(String name, String tuition, String location) {
    this.name = name;
    this.tuition = tuition;
    this.location = location;
  }
}
class CollegeInfoPage extends StatefulWidget {
  @override
  CollegeInfoPage({this.values, this.back});
  CollegeInfo values;
  final VoidCallback back;
  State<StatefulWidget> createState() => new CollegeInfoPageState(values);

}
class CollegeInfoPageState extends State<CollegeInfoPage> {
  @override
  CollegeInfo values;
  CollegeInfoPageState(CollegeInfo values) {
    this.values = values;
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(values.name),
      ),
      body:
        new Container(
          child: new Column(
              children: [new Text('Tuition: ${values.tuition}\n\n\nLocation: ${values.location}', style: new TextStyle(fontSize:50.0), textAlign: TextAlign.center,),
                new RaisedButton(onPressed: returnToList)
              ]
        ),
        )
    );
  }
  void returnToList() {
    widget.back();
  }
}
