import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/views/details/changepassword.dart';

import '../../components/components.dart';
import '../../components/customappbar.dart';
import '../../components/customdrawer.dart';
import '../../utils/constants.dart';
import '../../utils/theme.dart';

class Profile extends StatelessWidget {
  Profile({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatButton(context),
      key: _scaffoldKey,
      drawer: drawer(context),
      appBar: customAppBar(
        action: () {
          if (_scaffoldKey.currentState.isDrawerOpen) {
            _scaffoldKey.currentState.openEndDrawer();
          } else {
            _scaffoldKey.currentState.openDrawer();
          }
        },
      ),
      backgroundColor: CustomTheme.bgColor2,
      body: ListView(
        children: [
          Center(
            child: Text("My Profile",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    .copyWith(color: CustomTheme.bgColor)),
          ),
          ListTile(
            selected: true,
            selectedColor: CustomTheme.bgColor,
            leading: iconBox(
              Color(0xfffdeade),
              Color(0xfffdd47d),
              FontAwesomeIcons.user,
            ),
            title: Text(
              box.read('username') ?? "",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text("User Name"),
          ),
          ListTile(
            selected: true,
            selectedColor: CustomTheme.bgColor,
            leading: iconBox(
              Color(0xffc9c4ed),
              Color(0xff8b82d0),
              FontAwesomeIcons.envelope,
            ),
            title: Text(
              box.read('email') ?? "",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text("User Email"),
          ),
          ListTile(
            selected: true,
            selectedColor: CustomTheme.bgColor,
            leading: iconBox(
              Color(0xfff6e3bc),
              Color(0xffde9b12),
              FontAwesomeIcons.user,
            ),
            title: Text(
              box.read('subscriptionStart') ?? "",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text("Subscription start from"),
          ),
          ListTile(
            selected: true,
            selectedColor: CustomTheme.bgColor,
            leading: iconBox(
              Color(0xfff6e3bc),
              Color(0xffde9b12),
              FontAwesomeIcons.subscript,
            ),
            title: Text(
              box.read('subscriptionEnd') ?? "",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text("Subscription end to"),
          ),
          ListTile(
            selected: true,
            selectedColor: CustomTheme.bgColor,
            leading: iconBox(
              Color(0xffc9c4ed),
              Color(0xff8b82d0),
              FontAwesomeIcons.subscript,
            ),
            title: Text(
              box.read('membershipType') ?? "",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text("Membership Type"),
          ),
          ListTile(
            selected: true,
            selectedColor: CustomTheme.bgColor,
            leading: iconBox(
              Color(0xfffcedf4),
              Color(0xffffb2d5),
              FontAwesomeIcons.medium,
            ),
            title: Text(
              box.read('trialStatus') ?? "",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text("Trial Status"),
          ),
          ListTile(
            selected: true,
            selectedColor: CustomTheme.bgColor,
            leading: iconBox(
              Color(0xfffdeade),
              Color(0xfffdd47d),
              FontAwesomeIcons.dollarSign,
            ),
            title: Text(
              box.read('paymentStatus') ?? "",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text("Payment Status"),
          ),
          ListTile(
            selected: true,
            selectedColor: CustomTheme.bgColor,
            leading: iconBox(
              Color(0xfff6e3bc),
              Color(0xffde9b12),
              FontAwesomeIcons.lock,
            ),
            title: Text(
              "Change Password",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text("Password"),
            onTap: () {
              Constants.navigatepush(context, ChangePass());

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ChangePass()),
              // );
            },
          ),
        ],
      ),
    );
  }
}
