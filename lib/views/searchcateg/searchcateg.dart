import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:instameal/controllers/universalController.dart';
import 'package:instameal/views/searchcateg/searchcategrecipe.dart';

import 'package:instameal/components/components.dart';
import 'package:instameal/components/customappbar.dart';
import 'package:instameal/components/customdrawer.dart';
import 'package:instameal/components/notifdialog.dart';
import 'package:instameal/controllers/searchcategcontroller.dart';
import 'package:instameal/models/searchcategmodel.dart';
import 'package:instameal/utils/constants.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:instameal/utils/theme.dart';
import 'allrecipes.dart';

class SearchCategories extends StatefulWidget {
  SearchCategories({Key key}) : super(key: key);

  @override
  State<SearchCategories> createState() => _SearchCategoriesState();
}

class _SearchCategoriesState extends State<SearchCategories> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<SCategModel> filteredList = <SCategModel>[];
  TextEditingController searchContr = TextEditingController();
  final searchCategContr = Get.put(SearchCategController());

  String searchValue = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredList = searchCategContr.listofSCateg;
  }

  @override
  Widget build(BuildContext context) {
    final univerContr = Get.put(UniversalController());

    return Scaffold(
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Special Categories",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      .copyWith(color: CustomTheme.bgColor)),
              space0(),
              InkWell(
                onTap: () {
                  univerContr.fetchAllRecipes();

                  Fluttertoast.showToast(
                      msg: "Loading, please wait",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      fontSize: 16.0);

                  Constants.navigatepush(
                    context,
                    AllRecipes(),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/bg.jpg',
                        ),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter),
                  ),
                  height: SizeConfig.heightMultiplier * 8,
                  width: SizeConfig.screenWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "  View All Recipes",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              space0(),
              // customField(searchContr, "Search", icon: Icons.search),
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
              space0(),
              GetBuilder<SearchCategController>(
                init: SearchCategController(),
                builder: (_) {
                  return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filteredList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                      ),
                      itemBuilder: (context, index) {
                        print(Constants.baseImageUrl +
                            filteredList[index].scategimg);

                        return InkWell(
                          onTap: () async {
                            final searchCategContr =
                                Get.put(SearchCategController());
                            await searchCategContr.filterSCategRecipe(
                                filteredList[index].searchcategid);
                            Constants.navigatepush(
                              context,
                              SearchCategRecipe(
                                scategId: filteredList[index].searchcategid,
                                scategName: filteredList[index].searchcategname,
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
                                    height: SizeConfig.heightMultiplier * 18,
                                    width: SizeConfig.heightMultiplier * 18,
                                    imageUrl: Constants.baseImageUrl +
                                        filteredList[index].scategimg,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                        child: Center(
                                            child:
                                                CircularProgressIndicator())),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                            "assets/images/breakfast.png"),
                                  ),
                                ),
                                space0(),
                                Text(
                                  filteredList[index]
                                      .searchcategname
                                      .toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      .copyWith(color: CustomTheme.bgColor),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  refreshList() {
    setState(() {
      filteredList = searchCategContr.listofSCateg
          .where((p0) => p0.searchcategname
              .toLowerCase()
              .contains(searchValue.toLowerCase()))
          .toList();
    });
  }
}
