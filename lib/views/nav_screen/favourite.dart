import 'package:flutter/material.dart';

import '../../utils/theme.dart';

class Favourite extends StatelessWidget {
  const Favourite({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.bgColor2,
      body: Center(child: Text("Favourite")),
    );
  }
}
