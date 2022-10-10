import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instameal/utils/sizeconfig.dart';

import '../utils/theme.dart';

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

Widget customField(textController, labelText, {icon}) {
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
        color: Colors.black,
      ),
      fillColor: CustomTheme.grey,
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
