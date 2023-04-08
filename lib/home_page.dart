
import 'package:flutter/material.dart';
import 'package:simple_forum_app/login_page.dart';
import 'package:simple_forum_app/register_page.dart';
import 'package:simple_forum_app/services/api_services.dart';




class HomePage extends StatefulWidget {

  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

String message = "";

    _HomePageState();

  @override
  void initState() {
    super.initState();
    loadData();
  }


@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Text(message, style: TextStyle(fontSize: 20.0),)
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  height: 50.0,
                        minWidth: 150.0,
                        color: Colors.blue,
                        splashColor: Colors.teal,
                        textColor: Colors.white,
          child: Text('Login'),
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.push(
              context,
              MaterialPageRoute(
            builder: (context) => LoginPage()));
          },
        ),
        MaterialButton(
          height: 50.0,
                        minWidth: 150.0,
                        color: Colors.blue,
                        splashColor: Colors.teal,
                        textColor: Colors.white,
          child: Text('Register'),
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.push(
              context,
              MaterialPageRoute(
            builder: (context) => RegisterPage()));
          },
        )
            ],)
          ]
        )
    );
  }

    loadData() async {
    final response = await fetchData("hello");
    if (this.mounted) {
      setState(() {
        this.message = response["message"];
        
        
      });
    }
  }
}