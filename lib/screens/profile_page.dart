import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user/components/profile_content_card.dart';
import 'package:user/screens/help_page.dart';
import 'package:user/screens/setting_edit_profile.dart';

import 'package:user/screens/walkthrough.dart';

class ViewProfilePage extends StatefulWidget {
  @override
  _ViewProfilePageState createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  bool isUserActive = false;

  Future<void> _logout() async {
    /// Method to Logout the `FirebaseUser` (`_firebaseUser`)
    try {
      // signout code
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        ProfileCard(),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 5,
              ),
              FaIcon(FontAwesomeIcons.clock),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Text('Status :'),
                    SizedBox(
                      width: 20,
                    ),
                    ToggleButtons(
                      splashColor: Colors.transparent,
                      fillColor: Colors.white,
                      renderBorder: false,
                      isSelected: [isUserActive],
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            isUserActive ? Text('Active') : Text('Inactive'),
                            SizedBox(
                              width: 30,
                            ),
                            FaIcon(FontAwesomeIcons.user),
                          ],
                        )
                      ],
                      onPressed: (value) {
                        setState(() {
                          isUserActive = !isUserActive;
                        });
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        ProfileContentCard(
          icon: FaIcon(FontAwesomeIcons.cog),
          lable: 'Settings',
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SettingsEditPage())),
        ),
        ProfileContentCard(
          icon: FaIcon(FontAwesomeIcons.handsHelping),
          lable: 'Help',
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HelpPage())),
        ),
        ProfileContentCard(
          icon: FaIcon(FontAwesomeIcons.textHeight),
          lable: 'Text size',
        ),
        ProfileContentCard(
          icon: FaIcon(FontAwesomeIcons.language),
          lable: 'Language',
        ),
        ProfileContentCard(
          icon: FaIcon(FontAwesomeIcons.facebook),
          lable: 'Follow us',
        ),
        ProfileContentCard(
          icon: FaIcon(FontAwesomeIcons.signOutAlt),
          lable: 'Logout',
          onTap: () {
            _logout();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Walkthrough()));
          },
        ),
      ],
    ));
  }
}
