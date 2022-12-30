import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instameal/components/components.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'dart:math' as math;
import 'package:instameal/utils/theme.dart';

class HowtoCook extends StatelessWidget {
  const HowtoCook({Key key, this.directionsList}) : super(key: key);
  final directionsList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Container(
          margin: EdgeInsets.all(SizeConfig.heightMultiplier),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: CustomTheme.bgColor,
          ),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.white)),
        ),
        title: Text(
          "How to cook",
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              .copyWith(color: CustomTheme.bgColor),
        ),
      ),
      backgroundColor: Colors.white,
      body: SizedBox(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Column(
          children: [
            FaIcon(FontAwesomeIcons.chevronUp),
            SizedBox(
                height: SizeConfig.screenHeight * 0.7,
                width: SizeConfig.screenWidth,
                child: ListView.builder(
                    itemCount: directionsList.length,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.heightMultiplier * 2,
                            vertical: SizeConfig.heightMultiplier * 3),
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.heightMultiplier * 2,
                            vertical: SizeConfig.heightMultiplier * 3),
                        height: SizeConfig.screenHeight * 0.7,
                        width: SizeConfig.screenWidth,
                        child: Transform.rotate(
                          angle: -math.pi / -2,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.heightMultiplier * 2,
                                vertical: SizeConfig.heightMultiplier * 3),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/logo2.png",
                                  height: SizeConfig.heightMultiplier * 5,
                                ),
                                Text(
                                  "Step no: ${index + 1}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                space2(),
                                Text(
                                  directionsList[index].toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
            FaIcon(FontAwesomeIcons.chevronDown),
          ],
        ),
      ),
    );
  }
}
