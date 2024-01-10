import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EntryPoint extends StatelessWidget {
  const EntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   height: double.infinity,
    //   width: double.infinity,
    //   color: CupertinoColors.activeBlue,
    // );
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        child: Text('Open'),
        onPressed: () {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: ((context) {
                return AlertDialog(
                  title: Text('Hi'),
                  content: Text('내용'),
                  actions: <Widget>[
                    Container(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('네'),
                      ),
                    ),
                    Container(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('아니오'),
                      ),
                    )
                  ],
                );
              }));
        },
      ),
    ));
  }
}
