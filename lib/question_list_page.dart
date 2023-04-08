import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_forum_app/models/author.dart';
import 'package:simple_forum_app/models/question.dart';
import 'package:simple_forum_app/new_question_page.dart';
import 'package:simple_forum_app/profile_page.dart';
import 'package:simple_forum_app/question_page.dart';
import 'package:simple_forum_app/services/api_services.dart';

class QuestionListPage extends StatefulWidget {
  final Author author;

  const QuestionListPage({Key? key, required this.author}) : super(key: key);
  @override
  createState() => _QuestionListPageState(this.author);
}

class _QuestionListPageState extends State<QuestionListPage> {
  List<Question> questionList = [];
  int _selectedIndex = 0;
  Author author = Author.blank();

  _QuestionListPageState(this.author);
  @override
  void initState() {
    super.initState();
    loadData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Stack(children: <Widget>[
          Container(alignment: Alignment.center, child: Text("Questions")),
          Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.add_circle),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewQuestionPage(author: author))),
              ))
        ])),
        body: _questionListWidget(context, questionList),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(fontSize: 20.0),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
          currentIndex: 0,
          selectedItemColor: Colors.blue,
          onTap: _onTap,
        ));
  }
  _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    index == 1
        ? Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => ProfilePage(author: author)),
            (Route<dynamic> route) => false)
        : Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => QuestionListPage(author: author)),
            (Route<dynamic> route) => false);
  }
  Widget _questionListWidget(
      BuildContext context, List<Question> questionList) {
    return ListView.builder(
        itemCount: questionList.length,
        itemBuilder: (context, index) {
          Question question = questionList[index];
          return _hotCard(question, index);
        });
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    foregroundColor: Colors.black87, minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );

  Widget _hotCard(Question question, int index) {
    return Container(
        margin: const EdgeInsets.only(top: 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                BorderDirectional(bottom: BorderSide(color: Colors.white12))),
        child: TextButton(
            style: flatButtonStyle,
            onPressed: () => _navigateToQuestionPage(context, question.qId),
            child: Container(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Row(children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(index.toString(),
                                style: TextStyle(
                                    color:
                                        index < 3 ? Colors.red : Colors.yellow,
                                    fontSize: 28.0)),
                            alignment: Alignment.topLeft,
                          )
                        ],
                      )),
                  Expanded(
                      flex: 8,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              question.title,
                              style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  height: 1.1,
                                  color: Colors.black87),
                              textAlign: TextAlign.left,
                            ),
                            padding:
                                const EdgeInsets.only(bottom: 10.0, right: 4.0),
                            alignment: Alignment.topLeft,
                          ),
                          _questionSubtitle(question)
                        ],
                      ))
                ]))));
  }

  loadData() async {
    final questionList = await fetchAllQuestions();
    setState(() {
      this.questionList = questionList;
    });
  }

  Widget _questionSubtitle(Question question) {
    if (question.description != null &&
        question.description != "" &&
        question.description.length >= 10) {
      String preview = question.description.split(" ").sublist(0, 10).join(" ");
      return Container(
          child: Text("$preview...",
              style: TextStyle(color: Colors.grey, fontSize: 16.0)),
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(bottom: 8.0, right: 4.0));
    } else
      return Container(
          child: Text(question.description,
              style: TextStyle(color: Colors.grey, fontSize: 16.0)),
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(bottom: 8.0, right: 4.0));
  }

  void _navigateToQuestionPage(BuildContext context, String qId) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuestionPage(author: author, qId: qId, key: null,)));
  }
}
