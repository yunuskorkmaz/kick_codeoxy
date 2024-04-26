import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kick_codeoxy/src/main_tab_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    return MaterialApp(
      title: "Kick Codeoxy",
      theme: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark().copyWith(
              primary: const Color(0xffe5e5e5),
              background: const Color(0xff0b0e0f)),
          buttonTheme: const ButtonThemeData().copyWith(
              focusColor: Colors.indigo,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))))),
      darkTheme: ThemeData.dark(),
      routes: {
        "/": (context) => const MainTabScreen(),
      },
    );
  }
}
