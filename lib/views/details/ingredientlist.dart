import 'package:flutter/material.dart';
import 'package:instameal/utils/sizeconfig.dart';

import 'package:instameal/components/components.dart';
import 'package:instameal/components/customappbar.dart';
import 'package:instameal/components/customdrawer.dart';
import 'package:instameal/components/notifdialog.dart';
import 'package:instameal/utils/theme.dart';

class IngredientList extends StatelessWidget {
  IngredientList({Key key, this.recipeModel}) : super(key: key);
  final recipeModel;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatButton(context),
      backgroundColor: CustomTheme.bgColor2,
      key: _scaffoldKey,
      drawer: drawer(context),
      appBar: customAppBar(action: () {
        if (_scaffoldKey.currentState.isDrawerOpen) {
          _scaffoldKey.currentState.openEndDrawer();
        } else {
          _scaffoldKey.currentState.openDrawer();
        }
      }, action2: () {
        showDialog(context: context, builder: (ctx) => notifDialog(ctx));
      }),
      body: Container(
        height: SizeConfig.screenHeight,
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier * 2),
        child: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Ingredients List for ${recipeModel.recipeName}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            space0(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                recipeModel.items.length,
                (index) {
                  return Text(
                    recipeModel.items[index].toString(),
                    style: TextStyle(color: Colors.black),
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
