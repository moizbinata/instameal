import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instameal/src/model/styles.dart';
import 'dart:io';

class TopBar extends StatelessWidget {
  final String text;

  final TextStyle style;
  final String uniqueHeroTag;
  final Widget child;

  const TopBar({
    Key key,
    this.text,
    this.style,
    this.uniqueHeroTag,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return Scaffold(
        backgroundColor: kColorBar,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: kColorText,
          ),
          backgroundColor: kColorBar,
          title: Text(
            text,
            style: style,
          ),
        ),
        body: child,
      );
    } else {
      return CupertinoPageScaffold(
        backgroundColor: kColorBar,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: kColorBar,
          heroTag: uniqueHeroTag,
          border: null,
          transitionBetweenRoutes: false,
          middle: Text(
            text,
            style: style,
          ),
        ),
        child: child,
      );
    }
  }
}
