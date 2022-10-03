import 'package:flutter/material.dart';
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

Widget customField(textController, _labelText) {
  return TextFormField(
    keyboardType: TextInputType.text,
    autofocus: false,
    textAlign: TextAlign.start,
    textInputAction: TextInputAction.done,
    controller: textController,
    style: TextStyle(
        color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w500),
    decoration: InputDecoration(
      // border: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(vertical: 15),
      labelText: _labelText,
      // hintText: _labelText,
      hintStyle: TextStyle(
          color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w500),
      labelStyle: TextStyle(
          color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w500),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: CustomTheme.grey,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black), //<-- SEE HERE
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black), //<-- SEE HERE
      ),
// focusedBorder: InputBorder()
      // focusedBorder: OutlineInputBorder(
      //     borderSide: BorderSide(color: Colors.black, )),
    ),
  );
}

Widget space0() {
  return SizedBox(
    height: SizeConfig.heightMultiplier * 2,
  );
}
