import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../components/components.dart';
import '../../components/customappbar.dart';
import '../../components/customdrawer.dart';
import '../../controllers/universalController.dart';
import '../../utils/constants.dart';
import '../../utils/sizeconfig.dart';
import '../../utils/theme.dart';
import '../details/recipe.dart';

class Favourite extends StatelessWidget {
  Favourite({Key key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawer(context),
      appBar: customAppBar(action: () {
        if (_scaffoldKey.currentState.isDrawerOpen) {
          _scaffoldKey.currentState.openEndDrawer();
        } else {
          _scaffoldKey.currentState.openDrawer();
        }
      }),
      backgroundColor: CustomTheme.bgColor2,
      body: ListView(
        children: [
          ListTile(
            minVerticalPadding: 0.0,
            title: Text(
              "My Favourite Meals",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: CustomTheme.bgColor),
            ),
            subtitle: Text("Change Online Mart",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    .copyWith(decoration: TextDecoration.underline)),
          ),
          SizedBox(
            height: SizeConfig.screenHeight,
            child: GetBuilder<UniversalController>(
                init: UniversalController(),
                builder: (_) {
                  return (_.listofFav.length == 0)
                      ? Center(
                          child: Image.asset(
                          "assets/images/norecord.png",
                          width: SizeConfig.screenWidth * 0.7,
                        ))
                      : ListView.builder(
                          itemCount: _.listofFav.length + 1,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            print(_.listofFav.length);

                            return (index == _.listofFav.length)
                                ? SizedBox(
                                    height: SizeConfig.heightMultiplier * 50,
                                  )
                                : InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RecipeDetail(
                                                    recipeModel:
                                                        _.listofFav[index],
                                                  )));
                                    },
                                    child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      margin: EdgeInsets.all(
                                          SizeConfig.heightMultiplier),
                                      decoration: BoxDecoration(
                                        color: CustomTheme.bgColor,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: CustomTheme.grey
                                                .withOpacity(0.5),
                                            blurRadius: 6,
                                            spreadRadius: 6,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: CachedNetworkImage(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      20,
                                              width:
                                                  SizeConfig.heightMultiplier *
                                                      20,
                                              imageUrl: Constants.baseImageUrl +
                                                  _.listofFav[index].imagesUrl,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => Center(
                                                  child: Center(
                                                      child:
                                                          CircularProgressIndicator())),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.asset(
                                                      "assets/images/breakfast.png"),
                                            ),
                                          ),
                                          SizedBox(
                                            width: SizeConfig.heightMultiplier,
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      20,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    _.listofFav[index].planName,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                  ),
                                                  Text(
                                                    _.listofFav[index]
                                                        .recipeName,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                  InkWell(
                                                      child: customButton2(
                                                          context,
                                                          CustomTheme
                                                              .secondaryColor,
                                                          Colors.white,
                                                          "Add to List")),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                          },
                        );
                }),
          ),
        ],
      ),
    );
  }
}
