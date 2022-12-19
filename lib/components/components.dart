import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:instameal/utils/sizeconfig.dart';

import '../utils/constants.dart';
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

Widget customButton2(context, color, bgColor, label, {bg}) {
  return Container(
      margin: EdgeInsets.only(
          top: SizeConfig.heightMultiplier, right: SizeConfig.heightMultiplier),
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.heightMultiplier * 0.5,
          horizontal: SizeConfig.heightMultiplier),
      decoration: BoxDecoration(
          color: bg ?? Colors.transparent,
          border: Border.all(color: bgColor),
          borderRadius: BorderRadius.circular(15)),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall.copyWith(color: color),
      ));
}

Widget floatButton(context) {
  return Container(
    decoration: BoxDecoration(
        color: CustomTheme.bgColor,
        borderRadius: BorderRadius.circular(
          100,
        )),
    child: IconButton(
      icon: Icon(Icons.chevron_left),
      onPressed: () {
        Navigator.pop(context);
      },
      color: Colors.white,
    ),
  );
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

Widget customField(textController, labelText,
    {icon, bgcolor, iconColor, eye = false}) {
  return TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      textAlign: TextAlign.start,
      textInputAction: TextInputAction.done,
      obscureText: (eye) ? true : false,
      controller: textController,
      validator: RequiredValidator(errorText: '$labelText required'),
      style: TextStyle(
          color: Colors.black87,
          fontSize: SizeConfig.textMultiplier * 1.9,
          fontWeight: FontWeight.w500),
      decoration: customDecor(icon,
          iconColor: iconColor, bgcolor: bgcolor, labelText: labelText));
}

InputDecoration customDecor(icon, {iconColor, bgcolor, labelText}) {
  return InputDecoration(
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
        borderRadius: BorderRadius.circular(25.0), borderSide: BorderSide.none),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0), borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0), borderSide: BorderSide.none),
  );
}

Widget space0() {
  return SizedBox(
    height: SizeConfig.heightMultiplier * 2,
  );
}

Widget arrowBox() {
  return Container(
      margin: EdgeInsets.only(
          left: SizeConfig.heightMultiplier,
          right: SizeConfig.heightMultiplier,
          top: SizeConfig.heightMultiplier,
          bottom: SizeConfig.heightMultiplier * 14),
      width: SizeConfig.heightMultiplier * 18,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/arrow.gif",
            height: SizeConfig.heightMultiplier * 10,
          ),
          Text(
            "See more",
            // style: TextStyle(
            //     color: Colors.white),
          ),
          // FaIcon(
          //   FontAwesomeIcons
          //       .arrowRight,
          // color: Colors.white,
          // ),
        ],
      ));
}

Widget recipeBox2(context, imagesUrl, day, recipeName, dayName, color,
    {btn = false}) {
  return Container(
    margin: EdgeInsets.all(SizeConfig.heightMultiplier),
    height: SizeConfig.heightMultiplier * 20,
    width: SizeConfig.heightMultiplier * 20,
    child: Column(
      crossAxisAlignment:
          (btn == true) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Positioned(
                child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: CustomTheme.bgColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: CachedNetworkImage(
                height: (btn == true)
                    ? SizeConfig.heightMultiplier * 12
                    : SizeConfig.heightMultiplier * 20,
                width: (btn == true)
                    ? SizeConfig.heightMultiplier * 12
                    : SizeConfig.heightMultiplier * 20,
                imageUrl: Constants.baseImageUrl + imagesUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Center(child: Center(child: CircularProgressIndicator())),
                errorWidget: (context, url, error) =>
                    Image.asset("assets/images/breakfast.png"),
              ),
            )),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.heightMultiplier * 2,
                    vertical: SizeConfig.heightMultiplier * 1.5),
                decoration: BoxDecoration(
                  color: CustomTheme.bgColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                child: Text(
                  day.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier,
        ),
        (btn == false)
            ? Flexible(
                child: Text(
                  recipeName,
                  maxLines: 2,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              )
            : SizedBox(),
        Text(
          dayName.toString(),
          overflow: TextOverflow.ellipsis,
          style: (btn == false)
              ? Theme.of(context).textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  )
              : Theme.of(context)
                  .textTheme
                  .bodySmall
                  .copyWith(color: CustomTheme.bgColor),
        ),
        (btn == false)
            ? InkWell(child: customButton2(context, color, color, "View"))
            : SizedBox()
      ],
    ),
  );
}

Widget videoBox(context, imagesUrl, day, recipeName, dayName, color,
    {btn = false}) {
  print(Constants.baseImageUrl + imagesUrl);
  return Container(
    margin: EdgeInsets.all(SizeConfig.heightMultiplier),
    height: SizeConfig.heightMultiplier * 20,
    width: SizeConfig.heightMultiplier * 30,
    child: Column(
      crossAxisAlignment:
          (btn == true) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Positioned(
                child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: CustomTheme.bgColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: CachedNetworkImage(
                height: (btn == true)
                    ? SizeConfig.heightMultiplier * 12
                    : SizeConfig.heightMultiplier * 20,
                width: (btn == true)
                    ? SizeConfig.heightMultiplier * 12
                    : SizeConfig.heightMultiplier * 30,
                imageUrl: Constants.baseImageUrl + imagesUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Center(child: Center(child: CircularProgressIndicator())),
                errorWidget: (context, url, error) =>
                    Image.asset("assets/images/breakfast.png"),
              ),
            )),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.heightMultiplier * 2,
                    vertical: SizeConfig.heightMultiplier * 1.5),
                decoration: BoxDecoration(
                  color: CustomTheme.bgColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                child: Text(
                  day.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.1),
                child: FaIcon(
                  FontAwesomeIcons.play,
                  size: SizeConfig.heightMultiplier * 5,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                dayName.toString(),
                overflow: TextOverflow.ellipsis,
                style: (btn == false)
                    ? Theme.of(context).textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.bold,
                          color: color,
                        )
                    : Theme.of(context)
                        .textTheme
                        .bodySmall
                        .copyWith(color: CustomTheme.bgColor),
              ),
            ),
            (btn == false)
                ? InkWell(child: customButton2(context, color, color, "View"))
                : SizedBox()
          ],
        ),
      ],
    ),
  );
}

Widget recipeBox(context, imgUrl, recipeName) {
  return SizedBox(
    height: SizeConfig.heightMultiplier * 13,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: SizeConfig.heightMultiplier * 8,
          height: SizeConfig.heightMultiplier * 8,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(Constants.baseImageUrl + imgUrl, scale: 1.0),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          recipeName,
          maxLines: 2,
          style: Theme.of(context).textTheme.bodyMedium.copyWith(
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.bold,
                color: CustomTheme.bgColor,
              ),
        ),
      ],
    ),
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
  return Padding(
    padding: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier),
    child: Row(
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
    ),
  );
}
