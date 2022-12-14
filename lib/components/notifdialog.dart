import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instameal/controllers/notifcontroller.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:instameal/utils/theme.dart';

AlertDialog notifDialog(ctx) {
  print("2");

  return AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0))),
    contentPadding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
    backgroundColor: Colors.white,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Notifications",
          style: TextStyle(color: Colors.black),
        ),
        IconButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            icon: FaIcon(
              FontAwesomeIcons.xmark,
              color: CustomTheme.bgColor,
            ))
      ],
    ),
    content: SizedBox(
      // height: double.minPositive,
      height: SizeConfig.screenHeight * 0.6,
      width: double.maxFinite,
      child: GetBuilder<NotifController>(
        init: NotifController(),
        builder: (_) {
          return (_.listofNotif.length == 0)
              ? Text("No notifications")
              : ListView.builder(
                  itemCount: _.listofNotif.length,
                  itemBuilder: (context, i) {
                    bool colorTile = true;
                    return ListTile(
                      onTap: () {},
                      contentPadding: EdgeInsets.zero,
                      minVerticalPadding: 0,
                      leading: Text((i + 1).toString()),
                      title: Text(
                        _.listofNotif[i].title,
                        style: TextStyle(
                          color: CustomTheme.bgColor,
                        ),
                      ),
                      subtitle: Text(_.listofNotif[i].message),
                      trailing: FaIcon(
                        FontAwesomeIcons.solidBell,
                        color: (_.listofNotif[i].important == 0)
                            ? CustomTheme.bgColor
                            : CustomTheme.grey,
                        size: SizeConfig.heightMultiplier * 2,
                      ),
                    );
                  },
                );
        },
      ),
    ),
  );
}
