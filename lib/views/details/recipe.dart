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
                          Text(
                            recipeModel.categName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                .copyWith(color: CustomTheme.grey),
                          ),
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
                  child: Column(children: [
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            child: customButton2(context, Colors.white,
                                CustomTheme.bgColor, "Add to List")),
                      ],
                    ),
                    Text(
                      "Ingredients: ",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      "Bali is a province of Indonesia and the westernmost of the Lesser Sunda Islands. East of Java and west of Lombok, the province includes the island of Bali and a few smaller neighbouring islands, notably Nusa Penida, Nusa Lembongan, and Nusa Ceningan." +
                          "Bali is a province of Indonesia and the westernmost of the Lesser Sunda Islands. East of Java and west of Lombok, the province includes the island of Bali and a few smaller neighbouring islands, notably Nusa Penida, Nusa Lembongan, and Nusa Ceningan." +
                          "Bali is a province of Indonesia and the westernmost of the Lesser Sunda Islands. East of Java and west of Lombok, the province includes the island of Bali and a few smaller neighbouring islands, notably Nusa Penida, Nusa Lembongan, and Nusa Ceningan.",
                      style: Theme.of(context).textTheme.bodySmall,
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
