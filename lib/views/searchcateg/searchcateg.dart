import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instameal/views/searchcateg/searchcategrecipe.dart';

import '../../components/components.dart';
import '../../components/customappbar.dart';
import '../../components/customdrawer.dart';
import '../../controllers/searchcategcontroller.dart';
import '../../utils/constants.dart';
import '../../utils/sizeconfig.dart';
import '../../utils/theme.dart';

class SearchCategories extends StatelessWidget {
  SearchCategories({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
              GetBuilder<SearchCategController>(
                init: SearchCategController(),
                builder: (_) {
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _.listofSCateg.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: SizeConfig.heightMultiplier,
                      mainAxisSpacing: SizeConfig.heightMultiplier,
                    ),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () async {
                        final searchCategContr =
                            Get.put(SearchCategController());
                        await searchCategContr.filterSCategRecipe(
                            _.listofSCateg[index].searchcategid);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchCategRecipe(
                              scategId: _.listofSCateg[index].searchcategid,
                              scategName: _.listofSCateg[index].searchcategname,
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
                                height: SizeConfig.heightMultiplier * 15,
                                width: SizeConfig.heightMultiplier * 15,
                                imageUrl: Constants.baseImageUrl +
                                    _.listofSCateg[index].scategimg,
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
                              _.listofSCateg[index].searchcategname.toString(),
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
