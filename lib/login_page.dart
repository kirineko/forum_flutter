
import 'package:flutter/material.dart';
import 'package:simple_forum_app/models/author.dart';
import 'package:simple_forum_app/models/token.dart';
import 'package:simple_forum_app/question_list_page.dart';
import 'package:simple_forum_app/services/api_services.dart';
class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: new Stack(fit: StackFit.expand, children: <Widget>[
        new Theme(
          data: new ThemeData(
              inputDecorationTheme: new InputDecorationTheme(
            labelStyle: new TextStyle(color: Colors.blue, fontSize: 25.0),
          )),
          // isMaterialAppTheme: true,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.all(40.0),
                child: new Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new TextFormField(
                        decoration: new InputDecoration(
                            labelText: "Enter Username",
                            fillColor: Colors.white),
                        keyboardType: TextInputType.text,
                        controller: usernameController,
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Enter Password",
                        ),
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        controller: passwordController,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                      ),
                      new MaterialButton(
                        height: 50.0,
                        minWidth: 150.0,
                        color: Colors.blue,
                        splashColor: Colors.teal,
                        textColor: Colors.white,
                        child: Text("Login"),
                        onPressed: () async {
                          String username = usernameController.text;
                          String password = passwordController.text;

                          try {
                            // 2do: Username & password validation
                            final Token token = await getToken(
                                {'username': username, 'password': password});

                            final Author author = Author.fromJson(await fetchDataWithAuth("profile", token.accessToken));

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QuestionListPage(author: author)), (Route<dynamic> route) => false);
                          } on Exception {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()), (Route<dynamic> route) => false);
                          }

                          // 2do: Send user info to login page
                          // Navigator.pushNamed(context, '/profile');
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
