import 'package:flutter/material.dart';
import 'package:instameal/components/components.dart';
import 'package:instameal/utils/sizeconfig.dart';

import '../../utils/theme.dart';

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
          child: ListView.builder(
              itemCount: directionsList.length,
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.heightMultiplier * 2),
                  height: SizeConfig.screenHeight,
                  width: SizeConfig.screenWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Step no: ${index + 1}"),
                      space2(),
                      Text(directionsList[index].toString()),
                    ],
                  ),
                );
              })),
    );
  }
}
