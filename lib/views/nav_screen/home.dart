import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instameal/components/components.dart';

import '../../utils/sizeconfig.dart';
import '../../utils/theme.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0.0,
        //   leading: IconButton(
        //     onPressed: () {},
        //     icon: FaIcon(FontAwesomeIcons.barsStaggered, color: Colors.black),
        //   ),
        //   actions: [
        //     IconButton(
        //       onPressed: () {},
        //       icon: FaIcon(
        //         FontAwesomeIcons.cartShopping,
        //         color: CustomTheme.grey,
        //       ),
        //     ),
        //   ],
        // ),

        backgroundColor: CustomTheme.bgColor2,
        body: SafeArea(
            child: ListView(
          children: [
            space0(),
            Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.heightMultiplier * 2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          alignment: Alignment.centerLeft,
                          onPressed: () {},
                          icon: FaIcon(FontAwesomeIcons.barsStaggered,
                              color: Colors.black),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.cartShopping,
                            color: CustomTheme.grey,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Delicious\nfood for you",
                      style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.black,
                          ),
                    ),
                    space0(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.heightMultiplier * 2,
                        vertical: SizeConfig.heightMultiplier * 0.5,
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xffEFEEEE),
                          borderRadius: BorderRadius.circular(30)),
                      child: TextField(
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2.0),
                        decoration: InputDecoration(
                          hintText: "Search",
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          iconColor: CustomTheme.grey,
                          constraints: BoxConstraints.loose(Size(
                            double.infinity,
                            SizeConfig.heightMultiplier * 5.5,
                          )),
                          icon: FaIcon(
                            FontAwesomeIcons.magnifyingGlass,
                            size: SizeConfig.heightMultiplier * 3.0,
                            color: CustomTheme.grey,
                          ),
                        ),
                      ),
                    ),
                    space0(),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 6.5,
                      child: ListView.builder(
                        itemCount: 8,
                        physics: AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            color: CustomTheme.bgColor2,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedTab = index;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  bottom: SizeConfig.heightMultiplier * 2,
                                ),
                                padding: EdgeInsets.only(
                                  left: SizeConfig.heightMultiplier * 2,
                                  right: SizeConfig.heightMultiplier * 2,
                                  // bottom: SizeConfig.heightMultiplier * 2,
                                ),
                                decoration: BoxDecoration(
                                    color: CustomTheme.bgColor2,
                                    boxShadow: [
                                      BoxShadow(
                                        color: (selectedTab == index)
                                            ? CustomTheme.shadowColor2
                                            : Colors.transparent,
                                        blurRadius: 20,
                                        offset: Offset(20, -6),
                                      ),
                                    ],
                                    border: Border(
                                        bottom: (selectedTab == index)
                                            ? BorderSide(
                                                color: CustomTheme.bgColor,
                                                width: 4)
                                            : BorderSide.none)),
                                child: Column(
                                  children: [
                                    Text(
                                      "Breakfast",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          .copyWith(
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      2.0,
                                              color: (selectedTab == index)
                                                  ? CustomTheme.bgColor
                                                  : CustomTheme.grey),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 35,
                      child: ListView.builder(
                        itemCount: 8,
                        physics: AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            width: SizeConfig.screenWidth * 0.4,
                            padding:
                                EdgeInsets.all(SizeConfig.heightMultiplier),
                            child: Stack(
                              children: [
                                Positioned(
                                    top: SizeConfig.heightMultiplier * 8,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      width: double.infinity,
                                      height: SizeConfig.heightMultiplier * 21,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            blurRadius: 10.0,
                                            offset: Offset(-5, 5),
                                          ),
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    )),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.heightMultiplier,
                                    horizontal: SizeConfig.heightMultiplier * 2,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height:
                                            SizeConfig.heightMultiplier * 15,
                                        width: SizeConfig.heightMultiplier * 15,
                                        padding: EdgeInsets.symmetric(
                                          vertical:
                                              SizeConfig.heightMultiplier * 2,
                                          horizontal:
                                              SizeConfig.heightMultiplier * 2,
                                        ),
                                        margin: EdgeInsets.symmetric(
                                          vertical: SizeConfig.heightMultiplier,
                                          horizontal:
                                              SizeConfig.heightMultiplier,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                blurRadius: 10.0,
                                                offset: Offset(-5, 5),
                                              ),
                                            ],
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  "assets/images/plate.png",
                                                ),
                                                fit: BoxFit.cover)),
                                        child: Image.asset(
                                          "assets/images/breakfast.png",
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Text("Veggie Tomatoe Mix",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                      space0(),
                                      Text(
                                        "N1,900",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            .copyWith(
                                              color: CustomTheme.bgColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )),
          ],
        )));
  }
}
