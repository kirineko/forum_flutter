import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_forum_app/models/author.dart';
import 'package:simple_forum_app/question_list_page.dart';
import 'package:simple_forum_app/services/api_services.dart';

class NewQuestionPage extends StatefulWidget {
  final Author author;

  NewQuestionPage({Key? key, required this.author}): super(key: key);

  @override
  _NewQuestionPageState createState() => _NewQuestionPageState(this.author);
}

class _NewQuestionPageState extends State<NewQuestionPage> {

  final Author author;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  _NewQuestionPageState(this.author);

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBarWidget(context), body: _newQuestionWidget(context));
  }

  AppBar _appBarWidget(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            Expanded(
                child: GestureDetector(
              child: Container(
                  alignment: Alignment.centerLeft, child: Text("Cancel")),
              onTap: () {
                Navigator.pop(context);
              },
            )),
            GestureDetector(
              child: Container(
                  alignment: Alignment.centerRight, child: Text("Publish")),
              onTap: () {
                String title = titleController.text;

                if (title.length > 0) {
                String description = descriptionController.text;

                addQuestion({"title": title, "description": description});

                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => QuestionListPage(author: author)), (Route<dynamic> route) => false);

                }
              },
            )
          ],
        ));
  }

  Widget _newQuestionWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
              autofocus: true,
              maxLength: 100,
              maxLines: 2,
              controller: titleController,
              decoration: InputDecoration(
                  hintText:
                      'Start your question with "What", "How", "Why", etc.',
                  hintStyle:
                      TextStyle(fontSize: 19.0, fontWeight: FontWeight.normal),
                  border: InputBorder.none),
            )),
        Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
            decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Tips on getting good answers quickly",
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3.0),
                ),
                Text(
                  "1. Make sure your question hasn't been asked already",
                ),
                Text("2. Keep your question short and to the point"),
                Text("3. Double-check grammar and spelling"),
                Container(),
              ],
            )),
        Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  autofocus: true,
                  maxLines: null,
                  expands: true,
                  controller: descriptionController,
                  decoration: InputDecoration(
                      hintText: 'Optional: add description',
                      hintStyle: TextStyle(fontSize: 16.0)),
                )))
      ],
    );
  }
}
