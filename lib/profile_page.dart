import 'package:flutter/material.dart';
import 'package:simple_forum_app/home_page.dart';
import 'package:simple_forum_app/models/author.dart';
import 'package:simple_forum_app/question_list_page.dart';


class ProfilePage extends StatefulWidget {
  final Author author;

  ProfilePage({Key? key, required this.author}): super(key: key);

  @override
  createState() => new _ProfilePageState(this.author);

}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;
  Author author = Author.blank();

  _ProfilePageState(this.author);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // title: Text("Question"),
        ),
        body: _profileWidget(context, author),
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
          currentIndex: 1,
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
                builder: (context) => ProfilePage(author: author)), (Route<dynamic> route) => false)
        : Navigator.pushAndRemoveUntil(context, leftToRightRoute(author), (Route<dynamic> route) => false);
  }



  Widget _profileWidget(BuildContext context, Author author) {
    return new Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 10.0, bottom: 6.0),
      padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
      child: new Column(
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            decoration: new BoxDecoration(
                color: new Color(0xFFF5F5F5),
                borderRadius: new BorderRadius.all(new Radius.circular(6.0))
            ),
            child: TextButton(
                onPressed: (){},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black87,
                  minimumSize: Size(88, 36),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  ),
                ),
                child: new Container(
                  child: new ListTile(
                    leading: new Container(
                      child: new CircleAvatar(
                          backgroundImage: new NetworkImage((author.photo == "" || author.photo == null) ? "https://qsf.fs.quoracdn.net/-3-images.new_grid.profile_pic_default_small.png-26-679bc670f786484c.png" : author.photo),
                          radius: 28.0
                      ),
                    ),
                    title: new Container(
                      margin: const EdgeInsets.only(bottom: 2.0),
                      child: new Text("${author.username}", style: TextStyle(fontSize: 24.0)),
                    ),
                    subtitle: new Container(
                      margin: const EdgeInsets.only(top: 2.0),
                      child: new Text("Edit Profile", style: TextStyle(fontSize: 16.0)),
                    ),
                  ),
                )
            ),
          ),
          new Expanded(
            child: new Container(
              margin: const EdgeInsets.only(bottom: 10.0),
            alignment: Alignment.bottomCenter,
            width: double.infinity,
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
              backgroundColor: new Color(0xFFF5F5F5),
              padding: const EdgeInsets.only(left: 150.0, right: 150.0, top: 10, bottom: 10),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2.0)),
              ),
              minimumSize: Size(88, 36),
            ),
            child: new Text(
              'Logout'
            , style: TextStyle(fontSize: 20.0)),
            onPressed: () {
                  Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage()), (Route<dynamic> route) => false);
            })))
        ],
      ),
    );
  }
}

Route leftToRightRoute(Author author) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) =>
        QuestionListPage(author: author),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(-1.0, 0.0);
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