import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_forum_app/models/author.dart';
import 'package:simple_forum_app/models/question.dart';
import 'package:simple_forum_app/question_page.dart';
import 'package:simple_forum_app/services/api_services.dart';

class NewAnswerPage extends StatefulWidget {
  final Question question;
  final Author author;

  NewAnswerPage({Key? key, required this.question, required this.author}): super(key: key);

  @override
  _NewAnswerPageState createState() => _NewAnswerPageState(this.question, this.author);
}

class _NewAnswerPageState extends State<NewAnswerPage> {

  final Question question;
  final Author author;
  final contentController = TextEditingController();

  _NewAnswerPageState(this.question, this.author);


  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBarWidget(context), body: _newAnswerWidget(context));
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
                String content = contentController.text;

                if (content.length > 0) {
                addAnswer(question.qId, {"content": content, "author": Author.authorToJson(author), "description": content.length > 10 ? content.substring(0, 10) : content});

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuestionPage(author: author, qId: question.qId)));

                } 
              },
            )
          ],
        ));
  }

  Widget _newAnswerWidget(BuildContext context) {
    return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  autofocus: true,
                  maxLines: null,
                  expands: true,
                  controller: contentController,
                  decoration: InputDecoration(
                      hintText: 'Write your answer',
                      hintStyle: TextStyle(fontSize: 16.0)),
                ));
  }
}
