import 'package:flutter/material.dart';

class CollapsableTextWidget extends StatefulWidget {
  final String text;

  CollapsableTextWidget({required this.text});

  @override
  _CollapsableTextWidgetState createState() =>
      new _CollapsableTextWidgetState();
}

class _CollapsableTextWidgetState extends State<CollapsableTextWidget> {
  String? firstHalf;
  String? secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 150) {
      firstHalf = widget.text.substring(0, 150);
      secondHalf = widget.text.substring(150, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return secondHalf!.isEmpty
        ? new Container(
            child: new Text(firstHalf!,
                style: new TextStyle(
                    height: 1.4, fontSize: 16.0, color: Colors.grey[800]),
                textAlign: TextAlign.justify),
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, bottom: 8.0, top: 8.0),
            alignment: Alignment.topLeft,
            decoration: new BoxDecoration(
                border: new BorderDirectional(
                    bottom: new BorderSide(color: Colors.black12)),
                color: Colors.white),
          )
        : new Container(
            decoration: new BoxDecoration(
                border: new BorderDirectional(
                    bottom: new BorderSide(color: Colors.black12)),
                color: Colors.white),
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, bottom: 8.0, top: 8.0),
            alignment: Alignment.topLeft,
            child: new Column(
              children: <Widget>[
                new Text(flag ? (firstHalf! + "...") : (firstHalf! + secondHalf!),
                    style: new TextStyle(
                        height: 1.4, fontSize: 16.0, color: Colors.grey[800]),
                    textAlign: TextAlign.justify),
                new InkWell(
                  child: new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new Text(
                          flag ? "show more" : "show less",
                          style: new TextStyle(color: Colors.blue),
                        ),
                      ]),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ));
  }
}
