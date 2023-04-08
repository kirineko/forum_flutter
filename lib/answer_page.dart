
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_forum_app/models/answer.dart';
import 'package:simple_forum_app/models/question.dart';
import 'package:simple_forum_app/services/api_services.dart';

class AnswerPage extends StatelessWidget {
  final Question question;
  final String aId;
  final List<Answer> answerList;

  AnswerPage(
      {Key? key,
      required this.question,
      required this.aId,
      required this.answerList})
      : super(key: key);

  static Widget profilePhotoWidget(String photoUrl, double radius) {
    return CircleAvatar(
        backgroundImage: NetworkImage(photoUrl == null || photoUrl == ""
            ? "https://qsf.fs.quoracdn.net/-3-images.new_grid.profile_pic_default_small.png-26-679bc670f786484c.png"
            : photoUrl),
        radius: radius);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(title: Text(question.title)),
            body: child,
          );
        },
        home: AnswerPageRender(question, aId, answerList));
  }
}


Route upToDownRoute(Question question, String aId, List<Answer> answerList) {
  return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) =>
          AnswerPageRender(question, aId, answerList),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, -1.0);
        var end = Offset.zero;
        var curve = Curves.linear;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}

Route downToUpRoute(Question question, String aId, List<Answer> answerList) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) =>
        AnswerPageRender(question, aId, answerList),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.linear;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class AnswerPageRender extends StatefulWidget {
  final Question question;
  final String aId;
  final List<Answer> answerList;

  AnswerPageRender(this.question, this.aId, this.answerList);

  @override
  createState() =>
      _AnswerPageRenderState(this.question, this.aId, this.answerList);
}

class _AnswerPageRenderState extends State<AnswerPageRender> {
  final Question question;
  final String aId;
  final List<Answer> answerList;
  Answer detailedAnswer = Answer.blank();

  _AnswerPageRenderState(this.question, this.aId, this.answerList);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
    SizedBox.expand(
      child: Container(
        color: Colors.white,
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Container(
                child: AnswerPage.profilePhotoWidget(
                    detailedAnswer.author.photo, 18.0),
                padding: const EdgeInsets.only(right: 10.0),
              ),
              Text(detailedAnswer.author.username,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20))
            ],
          ),
          padding: const EdgeInsets.only(top: 10.0, left: 20.0),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Text(
            detailedAnswer.content,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
          alignment: Alignment.topLeft,
        )
      ])))),
      Container(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(bottom: 40.0, right: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  final int index = answerList.indexOf(
                      answerList.firstWhere((answer) => answer.aId == aId));

                  if (index > 0) {
                    final String prevAId = answerList[index - 1].aId;
                    Navigator.pushReplacement(
                        context, upToDownRoute(question, prevAId, answerList));
                  }
                },
                child: Icon(Icons.arrow_drop_up),
                heroTag: "previousAnswer",
              ),
              FloatingActionButton(
                onPressed: () {
                  final int index = answerList.indexOf(
                      answerList.firstWhere((answer) => answer.aId == aId));

                  if (index < answerList.length - 1) {
                    final String nextAId = answerList[index + 1].aId;
                    Navigator.pushReplacement(
                        context, downToUpRoute(question, nextAId, answerList));

                    //                 Navigator.pushReplacement(context,
                    // _downToUpRoute(detailedAnswer));
                  }
                },
                child: Icon(Icons.arrow_drop_down),
                heroTag: "nextAnswer",
              )
            ],
          ))
    ]);
  }

  loadData() async {
    final detailedAnswer = await fetchAnswerById(question.qId, aId);

    if (this.mounted) {
      setState(() {
        this.detailedAnswer = detailedAnswer;
      });
    }
  }
}
