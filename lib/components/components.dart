import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instameal/utils/sizeconfig.dart';

import '../utils/theme.dart';

BoxDecoration bottomBarShadow(index, currentIndex) {
  return BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: (currentIndex == index)
            ? CustomTheme.bgColor.withOpacity(0.2)
            : Colors.transparent,
        blurRadius: 8.0,
        spreadRadius: 7,
        offset: Offset(-4, 3),
      ),
    ],
  );
}

Widget iconBox(bgColor, iconColor, icon) {
  return Container(
    width: SizeConfig.heightMultiplier * 5,
    height: SizeConfig.heightMultiplier * 5,
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(
        10,
      ),
    ),
    child: Center(
      child: FaIcon(
        icon,
        color: iconColor,
        size: SizeConfig.heightMultiplier * 2,
      ),
    ),
  );
}

Widget customButton2(context, color, bgColor, label) {
  return Container(
      margin: EdgeInsets.only(top: SizeConfig.heightMultiplier),
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.heightMultiplier * 0.5,
          horizontal: SizeConfig.heightMultiplier),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(15)),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall.copyWith(color: color),
      ));
}

Widget customButton(context, color, bgColor, label) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 15),
    width: double.infinity,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: CustomTheme.shadowColor.withOpacity(0.1),
          blurRadius: 10.0,
          offset: Offset(0, 2),
        ),
      ],
      borderRadius: BorderRadius.circular(50),
      color: bgColor,
    ),
    child: Center(
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
      ),
    ),
  );
}

Widget customField(textController, labelText, {icon, bgcolor, iconColor}) {
  return TextFormField(
    keyboardType: TextInputType.text,
    autofocus: false,
    textAlign: TextAlign.start,
    textInputAction: TextInputAction.done,
    obscureText: (labelText == "Password") ? true : false,
    controller: textController,
    style: TextStyle(
        color: Colors.black87,
        fontSize: SizeConfig.textMultiplier * 1.9,
        fontWeight: FontWeight.w500),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: (iconColor.toString().isNotEmpty) ? iconColor : Colors.black,
      ),
      fillColor: (bgcolor.toString().isNotEmpty) ? bgcolor : CustomTheme.grey,
      floatingLabelStyle: TextStyle(color: Colors.black),
      filled: true,
      labelText: labelText,
      hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: SizeConfig.textMultiplier * 1.9,
          fontWeight: FontWeight.w500),
      labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: SizeConfig.textMultiplier * 1.9,
          fontWeight: FontWeight.w500),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide.none),
    ),
  );
}

Widget space0() {
  return SizedBox(
    height: SizeConfig.heightMultiplier * 2,
  );
}

Widget space3() {
  return SizedBox(
    height: SizeConfig.heightMultiplier * 10,
  );
}

Widget space2() {
  return SizedBox(
    height: SizeConfig.heightMultiplier * 8,
  );
}

Widget space1() {
  return SizedBox(
    height: SizeConfig.heightMultiplier * 5,
  );
}

RoundedRectangleBorder customradius() {
  return const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(10),
      bottomRight: Radius.circular(25),
      bottomLeft: Radius.circular(10),
    ),
  );
}

Widget bulletPoints(context, {label}) {
  return Row(
    children: [
      Expanded(
        flex: 1,
        child: const Icon(
          Icons.check_circle_outlined,
          color: CustomTheme.bgColor,
        ),
      ),
      Expanded(
        flex: 6,
        child: Text(label,
            style: Theme.of(context).textTheme.bodySmall.copyWith(
                  color: Colors.black,
                )),
      )
    ],
  );
}
