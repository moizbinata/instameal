import 'package:flutter/material.dart';

import 'package:instameal/utils/theme.dart';

class Search extends StatelessWidget {
  const Search({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.bgColor2,
      body: Center(child: Text("Search")),
    );
  }
}
