import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instameal/controllers/universalController.dart';
import 'package:instameal/models/allrecipemodel.dart';

import '../../components/components.dart';
import '../../components/customappbar.dart';
import '../../components/customdrawer.dart';
import '../../components/notifdialog.dart';
import '../../utils/constants.dart';
import '../../utils/sizeconfig.dart';
import '../../utils/theme.dart';
import '../details/recipe.dart';

class AllRecipes extends StatefulWidget {
  const AllRecipes({Key key}) : super(key: key);

  @override
  State<AllRecipes> createState() => _AllRecipesState();
}

class _AllRecipesState extends State<AllRecipes> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<AllRecipeModel> allrecipeList = <AllRecipeModel>[];
  TextEditingController searchContr = TextEditingController();
  final universalController = Get.put(UniversalController());

  String searchValue = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    universalController.fetchAllRecipes();

    allrecipeList = universalController.listofAllRecipe;
  }

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
      }, action2: () {
        showDialog(context: context, builder: (ctx) => notifDialog(ctx));
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
                "All Recipes List",
                style: Theme.of(context).textTheme.bodyLarge.copyWith(
                      color: CustomTheme.bgColor,
                    ),
              ),
              space0(),
              TextFormField(
                keyboardType: TextInputType.text,
                autofocus: false,
                textAlign: TextAlign.start,
                textInputAction: TextInputAction.done,
                controller: searchContr,
                onChanged: (value) {
                  setState(() {
                    searchValue = value;
                    refreshList();
                  });
                },
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: SizeConfig.textMultiplier * 1.9,
                    fontWeight: FontWeight.w500),
                decoration: customDecor(Icons.search, labelText: 'Search'),
              ),
              // GetBuilder<universalControlleroller>(
              //   init: universalControlleroller(),
              //   builder: (_) {
              // print(allrecipeList.length);
              //return
              (allrecipeList.length < 1)
                  ? SizedBox(
                      height: SizeConfig.screenHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No meals",
                            style:
                                Theme.of(context).textTheme.bodyLarge.copyWith(
                                      color: CustomTheme.bgColor,
                                    ),
                          ),
                          space0(),
                          Image.asset(
                            "assets/images/norecord.png",
                            width: SizeConfig.screenWidth * 0.7,
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: (allrecipeList.length > 30)
                          ? 30
                          : allrecipeList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: SizeConfig.heightMultiplier,
                        mainAxisSpacing: SizeConfig.heightMultiplier,
                      ),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Constants.navigatepush(
                            context,
                            RecipeDetail(
                              modelType: "scateg",
                              recipeModel: allrecipeList[index],
                            ),
                          );
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    color: CustomTheme.bgColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            CustomTheme.grey.withOpacity(0.5),
                                        blurRadius: 6,
                                        spreadRadius: 6,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: CachedNetworkImage(
                                  height: SizeConfig.heightMultiplier * 17,
                                  width: SizeConfig.heightMultiplier * 17,
                                  imageUrl: Constants.baseImageUrl +
                                      allrecipeList[index].imagesUrl,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                      child: Center(
                                          child: CircularProgressIndicator())),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                          "assets/images/breakfast.png"),
                                ),
                              ),
                              space0(),
                              Text(
                                allrecipeList[index].recipeName.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    .copyWith(color: CustomTheme.bgColor),
                              ),
                              space0(),
                            ],
                          ),
                        ),
                      ),
                    )
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }

  refreshList() {
    setState(() {
      allrecipeList = universalController.listofAllRecipe
          .where((p0) =>
              p0.recipeName.toLowerCase().contains(searchValue.toLowerCase()))
          .toList();
    });
  }
}
