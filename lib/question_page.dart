
// ignore_for_file: no_logic_in_create_state, prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_forum_app/answer_page.dart';
import 'package:simple_forum_app/models/answer.dart';
import 'package:simple_forum_app/models/author.dart';
import 'package:simple_forum_app/models/collapsableTextWidget.dart';
import 'package:simple_forum_app/models/item.dart';
import 'package:simple_forum_app/models/question.dart';
import 'package:simple_forum_app/new_answer_page.dart';
import 'package:simple_forum_app/services/api_services.dart';

class QuestionPage extends StatefulWidget {
  final Author author;
  final String qId;

  const QuestionPage({Key? key, required this.author, required this.qId}) : super(key: key);

  @override
  createState() => _QuestionPageState(qId, author);

  static void navigateToAnswerPage(
      BuildContext context, Question question, String aId, List<Answer> answerList) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AnswerPage(
                  question: question,
                  aId: aId,
                  answerList: answerList,
                )));
  }
}

class _QuestionPageState extends State<QuestionPage> {
  final String qId;
  final author;
  List<Item> itemList = [];
  Question question = Question.blank();
  List<Answer> answerList = [];

  _QuestionPageState(this.qId, this.author);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // title: Text("Question"),
        ),
        body: _questionAndAnswerListWidget(context, itemList, qId, answerList, author));
  }

  Widget _questionAndAnswerListWidget(BuildContext context, List<Item> itemList,
      String qId, List<Answer> answerList, Author author) {
    return ListView.builder(
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        final item = itemList[index];

        if (item is Question) {
          return _questionWidget(item, answerList, author);
        } else if (item is Answer) {
          return _answerWidget(question, answerList, item);
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      });
  }

  loadData() async {
    final question = await fetchQuestionById(qId);
    final answerList = await fetchAllAnswers(qId);
    if (mounted) {
      setState(() {
        this.question = question;
        this.answerList = answerList;
        itemList.add(question);
        itemList.addAll(answerList);
        
        
      });
    }
  }

  Widget _questionWidget(Question question, List<Answer> answerList, Author author) {
    return Column(
      children: <Widget>[
         Container(
                child:  Text(question.title, style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, height: 1.3, color: Colors.black87), textAlign: TextAlign.justify,),
                padding:  EdgeInsets.only(left: 16.0, bottom: 8.0, right: 16.0, top: 16.0),
                alignment: Alignment.topLeft,
                color: Colors.white
              ),
               CollapsableTextWidget(text: question.description),
               Container(
                  child:  Row(
                    children: <Widget>[
                       Expanded(
                        flex: 1,
                        child:  Container(
                          child:  TextButton.icon(
                            onPressed: (){},
                            icon:  Icon(Icons.group_add),
                            label:  Text("Invite", style:  TextStyle(fontSize: 16.0)),
                            // textTheme: ButtonTextTheme.accent,
                          ),
                          decoration:  BoxDecoration(
                              border:  BorderDirectional(end:  BorderSide(color: Colors.black12))
                          ),
                        ),
                      ),
                       Expanded(
                        flex: 1,
                        child:  Container(
                          child:  TextButton.icon(
                            onPressed: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewAnswerPage(question: question, author: author)));
                            },
                            icon:  Icon(Icons.brush),
                            label:  Text("Answer", style:  TextStyle(fontSize: 16.0)),
                            // textTheme: ButtonTextTheme.accent,
                          ),
                          decoration:  BoxDecoration(
                              border:  BorderDirectional(end:  BorderSide(color: Colors.black12))
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration:  BoxDecoration(
                    color: Colors.white
                  ),
              ),
               Container(
                margin: const EdgeInsets.only(top: 15.0, bottom: 4.0),
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0, top: 8.0),
                alignment: Alignment.topLeft,
                child:  Row(
                  children: <Widget>[
                     Expanded(
                      child:  Container(
                        child:  Text("${answerList.length} ANSWERS", style:  TextStyle(color: Colors.blue, fontSize: 12.0, fontWeight: FontWeight.bold)),
                        // margin: const EdgeInsets.only(left: 16.0),
                      ),
                    )
                  ],
                ),
                 decoration:  BoxDecoration(
                              border:  BorderDirectional(top:  BorderSide(color: Colors.black12)),
                              color: Colors.white
                          )
              )]);
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    foregroundColor: Colors.black87, minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );

      Widget _answerWidget(Question question, List<Answer> answerList, Answer answer) {
    return  Container(
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 5.0),
                child:  TextButton(
                  style: flatButtonStyle,
                  onPressed: () => QuestionPage.navigateToAnswerPage(
                  context, question, answer.aId, answerList),
                  child:  Column(
                    children: <Widget>[
                       Container(
                        child:  Row(
                          children: <Widget>[
                             Container(
                              child: AnswerPage.profilePhotoWidget(answer.author.photo, 15.0),
                            ),
                             Text(" ${answer.author.username}", style:  TextStyle(color: Colors.grey, fontSize: 16.0))
                          ],
                        ),
                        padding: const EdgeInsets.only(top: 10.0),
                      ),
                       Container(
                          child:  Text("${answer.description}...", style:  TextStyle(height: 1.3, color: Colors.black87, fontSize: 17.0), textAlign: TextAlign.justify,),
                          margin:  EdgeInsets.only(top: 6.0, bottom: 14.0),
                          alignment: Alignment.topLeft
    )
                ])));
  }

}