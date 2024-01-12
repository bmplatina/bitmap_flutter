import 'package:bitmap_flutter/components/sidebars/sidemenu.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EntryPoint extends StatelessWidget {
  const EntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      /*
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ko', 'KR'), // Korean
        const Locale('en', 'US'), // English
        // Add other locales if needed
      ], */
      home: SafeArea(
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
              middle: Text('Bitmap'),
              trailing: CupertinoButton(
                child: Icon(CupertinoIcons.add),
                onPressed: () {},
              ),
            ),
          child : SideBar()
          ),
      )
    );
  }
}
