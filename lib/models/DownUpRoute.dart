import 'package:flutter/material.dart';
class DownUpRoute extends PageRouteBuilder {
  final Widget enterPage;
  final Widget exitPage;
  DownUpRoute({required this.exitPage, required this.enterPage})
      : super(
        // transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              enterPage,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              Stack(
                children: <Widget>[
                  SlideTransition(
                    position:  Tween<Offset>(
                      begin: const Offset(0.0, 0.0),
                      end: const Offset(0.0, -1.0),
                    ).animate(animation),
                    child: exitPage,
                  ),
                  SlideTransition(
                    position:  Tween<Offset>(
                      begin: const Offset(0.0, 1.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: enterPage,
                  )
                ],
              ),
        );
}