import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kick_codeoxy/src/lives_screen.dart';

import 'browse_screen.dart';
import 'followers_screen.dart';

class MainTabScreen extends StatelessWidget {
  const MainTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void showBackDialog() {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Çıkış?'),
            content: const Text(
              'Uygulamadan çıkış yapmak istediğinizden emin misiniz?',
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('İptal'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Çıkış'),
                onPressed: () {
                  SystemNavigator.pop();
                  Navigator.pop(context, true);
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        },
      );
    }

    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) {
            return;
          }
          showBackDialog();
        },
        child: DefaultTabController(
            length: 3,
            child: Scaffold(
              // backgroundColor: const Color(0xff191b1f),
              appBar: AppBar(
                backgroundColor: const Color(0xff0b0e0f),
                toolbarHeight: 0,
                bottom: const TabBar(
                  tabAlignment: TabAlignment.center,
                  labelColor: Color(0xff53fc18),
                  // unselectedLabelColor: Color(0xfff5f5f5),
                  indicatorColor: Color(0xff53fc18),
                  dividerHeight: 0,
                  splashFactory: NoSplash.splashFactory,

                  tabs: [
                    Tab(
                      text: "Canlı",
                    ),
                    Tab(text: "Takip Edilenler"),
                    Tab(text: "Arama"),
                  ],
                ),
              ),
              body: const TabBarView(
                children: [
                  LivesScreen(),
                  FollowersScreen(),
                  BrowseScreen()
                ],
              ),
            )));
  }
}
