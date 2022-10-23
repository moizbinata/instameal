import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/sizeconfig.dart';
import '../utils/theme.dart';

Widget customAppBar({action}) {
  return AppBar(
    backgroundColor: CustomTheme.bgColor2,
    elevation: 0.0,
    leading: IconButton(
      onPressed: action,
      icon: FaIcon(FontAwesomeIcons.barsStaggered, color: CustomTheme.bgColor),
    ),
    title: Center(
      child: Image.asset(
        "assets/images/logo2.png",
        height: SizeConfig.heightMultiplier * 5,
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: FaIcon(
          FontAwesomeIcons.bell,
          color: CustomTheme.bgColor,
        ),
      ),
    ],
  );
}
