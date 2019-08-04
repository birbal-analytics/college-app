import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'college_info.dart';
class CollegeListPage extends StatefulWidget {
  @override
  CollegeListPage();
  State<StatefulWidget> createState() => new _CollegeListPageState();

}
enum clickedOn {
  clicked,
  notClicked
}
class _CollegeListPageState extends State<CollegeListPage> {
  final List<String> colleges = <String>[
    'University of California', 'Michigan', 'California', 'New Mexico'];
  clickedOn clickedOnState = clickedOn.notClicked;
  int onClickIndex = -1;

  @override
  void moveToInformation(int index) {
    setState(() {
      clickedOnState = clickedOn.clicked;
      onClickIndex = index;
    }
    );
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    switch (clickedOnState) {
      case (clickedOn.notClicked):
        return new Scaffold(
            appBar: new AppBar(
              title: new Text("College List"),
            ),
            body:
            new ListView.separated(
                padding: const EdgeInsets.all(8.0),
                itemCount: colleges.length,
                itemBuilder: (BuildContext, int index) {
                  return new Container(
                      height: 50,
                      color: Colors.amber[500],
                      child: new FlatButton(
                        child: new Text(colleges[index]),
                        onPressed: () => moveToInformation(index),
                      )
                  );
                },
                separatorBuilder:
                    (BuildContext context, int index) => const Divider()
            )
        );
        break;
      case (clickedOn.clicked):
        return new CollegeInfoPage(
          values: new CollegeInfo("yes", "yes", "yes"),
          back: returnToList,
        );;
        break;
      default:
        return null;
    }
  }
  void returnToList() {
    setState((){
      clickedOnState = clickedOn.notClicked;

    }
    );
  }
}
