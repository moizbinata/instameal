import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../components/components.dart';
import '../../components/customappbar.dart';
import '../../components/customdrawer.dart';
import '../../controllers/searchcategcontroller.dart';
import '../../utils/constants.dart';
import '../../utils/sizeconfig.dart';
import '../../utils/theme.dart';
import '../details/recipe.dart';

class SearchCategRecipe extends StatefulWidget {
  SearchCategRecipe({Key key, this.scategName, this.scategId})
      : super(key: key);
  final scategName;
  final scategId;

  @override
  State<SearchCategRecipe> createState() => _SearchCategRecipeState();
}

class _SearchCategRecipeState extends State<SearchCategRecipe> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String searchValue = "";
  int searchId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatButton(context),
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
      body: Container(
        height: SizeConfig.screenHeight,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                widget.scategName,
                style: Theme.of(context).textTheme.bodyLarge.copyWith(
                      color: CustomTheme.bgColor,
                    ),
              ),
              GetBuilder<SearchCategController>(
                init: SearchCategController(),
                builder: (_) {
                  print(_.filteredSCRecipe.length);
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _.filteredSCRecipe.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: SizeConfig.heightMultiplier,
                      mainAxisSpacing: SizeConfig.heightMultiplier,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetail(
                              modelType: "breakfast",
                              recipeModel: _.filteredSCRecipe[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        child: Column(
                          children: [
                            space0(),
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  color: CustomTheme.bgColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: CustomTheme.grey.withOpacity(0.5),
                                      blurRadius: 6,
                                      spreadRadius: 6,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10)),
                              child: CachedNetworkImage(
                                height: SizeConfig.heightMultiplier * 20,
                                width: SizeConfig.heightMultiplier * 20,
                                imageUrl: Constants.baseImageUrl +
                                    _.filteredSCRecipe[index].imagesUrl,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Center(
                                    child: Center(
                                        child: CircularProgressIndicator())),
                                errorWidget: (context, url, error) =>
                                    Image.asset("assets/images/breakfast.png"),
                              ),
                            ),
                            space0(),
                            Text(
                              _.filteredSCRecipe[index].recipeName.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  .copyWith(color: CustomTheme.bgColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}