import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:instameal/utils/theme.dart';

import '../../components/components.dart';
import '../../utils/constants.dart';

class RecipeDetail extends StatelessWidget {
  const RecipeDetail({Key key, this.recipeModel}) : super(key: key);
  final recipeModel;
  @override
  Widget build(BuildContext context) {
    print(Constants.baseImageUrl + recipeModel.imagesUrl);
    return Scaffold(
      backgroundColor: CustomTheme.bgColor2,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            leading: Container(
              margin: EdgeInsets.all(SizeConfig.heightMultiplier),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
              ),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: CustomTheme.grey,
                  )),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: CustomTheme.bgColor,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: CustomTheme.bgColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: Constants.baseImageUrl + recipeModel.imagesUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                        child: Center(child: CircularProgressIndicator())),
                    errorWidget: (context, url, error) =>
                        Image.asset("assets/images/breakfast.png"),
                  ),
                ),
              ),
            ),
            // pinned: true,
            expandedHeight: SizeConfig.screenHeight * 0.4,
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                Container(
                  decoration: BoxDecoration(
                      color: CustomTheme.bgColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      )),
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.heightMultiplier * 2),
                  width: SizeConfig.screenWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      space0(),
                      Text(
                        recipeModel.recipeName,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            recipeModel.planName,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(recipeModel.categName,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton.icon(
                            onPressed: () {},
                            icon: FaIcon(
                              FontAwesomeIcons.heart,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Free",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: FaIcon(
                              FontAwesomeIcons.kitchenSet,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Start Cook",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: FaIcon(
                              FontAwesomeIcons.share,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Share",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                space0(),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.heightMultiplier * 2),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/food.png",
                              height: SizeConfig.heightMultiplier * 4,
                              fit: BoxFit.contain,
                            ),
                            Text(recipeModel.prepTime + " Prep Time",
                                style: Theme.of(context).textTheme.bodySmall),
                            Text(recipeModel.cookTime + " Cook Time",
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            child: customButton2(
                              context,
                              Colors.white,
                              CustomTheme.bgColor,
                              "Add to List",
                            ),
                          ),
                        ),
                        //keys
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 4,
                          child: ListView.builder(
                            itemCount: recipeModel.keys.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                  height: SizeConfig.heightMultiplier * 4,
                                  width: SizeConfig.heightMultiplier * 4,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.heightMultiplier),
                                  decoration: BoxDecoration(
                                      color:
                                          (recipeModel.keys[index].toString() ==
                                                  "DF")
                                              ? Color(0xff8b82d0)
                                              : (recipeModel.keys[index]
                                                          .toString() ==
                                                      "MP")
                                                  ? Color(0xffde9b12)
                                                  : (recipeModel.keys[index]
                                                              .toString() ==
                                                          "V")
                                                      ? Color(0xffffb2d5)
                                                      : CustomTheme.bgColor,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Center(
                                      child: Text(
                                    recipeModel.keys[index],
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  )));
                            },
                          ),
                        ),
                        space0(),
                        Text(
                          "Ingredients: ",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        space0(),
                        //ingredients
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(maxHeight: 200, minHeight: 56.0),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: recipeModel.whatYouNeed.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              print(recipeModel.whatYouNeed.length);
                              return Text(
                                (index + 1).toString() +
                                    ":  " +
                                    recipeModel.whatYouNeed[index],
                                style: Theme.of(context).textTheme.bodySmall,
                              );
                            },
                          ),
                        ),
                        space0(),
                        space0(),
                        Text(
                          "Directions: ",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        space0(),
                        //directions
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(maxHeight: 300, minHeight: 56.0),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: recipeModel.direction.length,
                            itemBuilder: (context, index) {
                              print(recipeModel.direction.length);
                              return Text(
                                (index + 1).toString() +
                                    ":  " +
                                    recipeModel.direction[index],
                                style: Theme.of(context).textTheme.bodySmall,
                              );
                            },
                          ),
                        ),
                        space0(),
                        space0(),
                        Text(
                          "Nutrition Per Serve: ",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        space0(),
                        Container(
                          height: SizeConfig.heightMultiplier * 4,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: recipeModel.nutritPerServe.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              print(recipeModel.nutritPerServe.length);
                              return Container(
                                height: SizeConfig.heightMultiplier * 4,
                                width: SizeConfig.heightMultiplier * 12,
                                margin: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.heightMultiplier),
                                decoration: BoxDecoration(
                                    color: (recipeModel.nutritPerServe[index]
                                            .toString()
                                            .contains("Fats"))
                                        ? Color(0xff8b82d0)
                                        : (recipeModel.nutritPerServe[index]
                                                .toString()
                                                .contains("Fiber"))
                                            ? Color(0xffde9b12)
                                            : (recipeModel.nutritPerServe[index]
                                                    .toString()
                                                    .contains("Kcal"))
                                                ? Color(0xffffb2d5)
                                                : CustomTheme.bgColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Text(
                                    recipeModel.nutritPerServe[index],
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
