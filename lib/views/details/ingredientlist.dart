import 'package:flutter/material.dart';
import 'package:instameal/utils/sizeconfig.dart';

import '../../components/components.dart';
import '../../components/customappbar.dart';
import '../../components/customdrawer.dart';
import '../../components/notifdialog.dart';
import '../../utils/theme.dart';

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
