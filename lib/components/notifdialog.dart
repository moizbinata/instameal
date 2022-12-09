import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instameal/controllers/notifcontroller.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:instameal/utils/theme.dart';

AlertDialog notifDialog(ctx) {
  print("2");

  return AlertDialog(
    backgroundColor: CustomTheme.bgColor,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Notifications",
          style: TextStyle(color: Colors.white),
        ),
        IconButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            icon: FaIcon(
              FontAwesomeIcons.xmark,
              color: Colors.white,
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
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      minVerticalPadding: 0,
                      title: Text(
                        _.listofNotif[i].title,
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(_.listofNotif[i].message),
                      trailing: FaIcon(
                        FontAwesomeIcons.solidCircle,
                        color: (_.listofNotif[i].important == 0)
                            ? Colors.white
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
