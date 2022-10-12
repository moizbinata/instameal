import 'package:flutter/material.dart';

import '../../utils/theme.dart';

class Shopping extends StatelessWidget {
  const Shopping({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.bgColor2,
      body: Center(child: Text("Shopping")),
    );
  }
}
