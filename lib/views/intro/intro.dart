import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:instameal/components/components.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:instameal/utils/theme.dart';

import 'package:instameal/utils/constants.dart';
import 'package:instameal/views/login.dart';

class HomeIntro extends StatefulWidget {
  const HomeIntro({Key key}) : super(key: key);

  @override
  State<HomeIntro> createState() => Home_IntroState();
}

class Home_IntroState extends State<HomeIntro> {
  final Color kDarkBlueColor = Color(0xFF053149);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        finishButtonText: 'Start Cooking with Instameal',
        onFinish: () {
          Constants.navigatepushreplac(
              context,
              Login(
                type: 1,
              ));
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => Login()));
        },
        finishButtonColor: kDarkBlueColor,
        finishButtonTextStyle: Theme.of(context).textTheme.bodyText1.copyWith(
              color: Colors.white,
            ),
        skipTextButton: Text(
          'Skip',
          style: TextStyle(
            fontSize: 16,
            color: kDarkBlueColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Text(
          'Login',
          style: TextStyle(
            fontSize: 16,
            color: kDarkBlueColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailingFunction: () {
          Constants.navigatepushreplac(
              context,
              Login(
                type: 1,
              ));
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => Login()));
        },
        controllerColor: kDarkBlueColor,
        totalPage: 3,
        headerBackgroundColor: Colors.white,
        pageBackgroundColor: Colors.white,
        background: [
          Image.asset(
            'assets/mealimg/intro1.jpg',
            width: SizeConfig.screenWidth,
          ),
          Image.asset(
            'assets/mealimg/intro2.jpg',
            width: SizeConfig.screenWidth,
          ),
          Image.asset(
            'assets/mealimg/intro3.webp',
            width: SizeConfig.screenWidth,
          ),
        ],
        speed: 1.8,
        pageBodies: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                space3(),
                space3(),
                Text(
                  'Discover the smart way families do dinner',
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        color: CustomTheme.bgColor,
                      ),
                ),
                space1(),
                Text(
                  'Save time planning, shopping and cooking healthy meals for your family!',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                space3(),
                space3(),
                Text(
                  'Variety is the spice of life',
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        color: CustomTheme.bgColor,
                      ),
                ),
                space1(),
                Text(
                  'With over 15 food styles, Instameal is sure to have the perfect fit for your lifestyle. Choose from Plant-based, 5-Ingredients, 30 minutes, quick and healthy meals to hormones balance, low calories, budget friendly and so much more.',
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                space3(),
                space3(),
                Text(
                  'Delivery or Simplified shopping',
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        color: CustomTheme.bgColor,
                      ),
                ),
                space1(),
                Text(
                    'Whether you want to get your groceries delivered to your front door or plan to head to the store yourself, Instameals makes it easy for you!',
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
