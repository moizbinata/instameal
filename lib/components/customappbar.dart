import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/sizeconfig.dart';
import '../utils/theme.dart';
import 'notifdialog.dart';

Widget customAppBar({action, action2}) {
  print("2");

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
          onPressed: action2,
          icon: Stack(
            children: [
              FaIcon(
                FontAwesomeIcons.bell,
                color: CustomTheme.bgColor,
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: FaIcon(
                    FontAwesomeIcons.solidCircle,
                    color: CustomTheme.red,
                    size: SizeConfig.heightMultiplier,
                  ))
            ],
          )),
    ],
  );
}
