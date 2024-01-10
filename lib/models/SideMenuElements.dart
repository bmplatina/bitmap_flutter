import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart';

class SideMenuIcons {
  final String artboard, stateMachineName, title;
  final IconData src;
  late SMIBool? input;

  SideMenuIcons(this.src,
      {required this.artboard,
      required this.stateMachineName,
      required this.title,
      this.input});
}

List<SideMenuIcons> sideMenuMain = [
  SideMenuIcons(CupertinoIcons.home,
      artboard: 'WIKI', stateMachineName: 'WIKI_Interactivity', title: 'Wiki'),
  SideMenuIcons(CupertinoIcons.news,
      artboard: 'NEWS',
      stateMachineName: 'NEWS_Interactivity',
      title: 'Newsroom'),
  SideMenuIcons(CupertinoIcons.chat_bubble,
      artboard: 'BLOG', stateMachineName: 'BLOG_Interactivity', title: 'Blog')
];

List<SideMenuIcons> sideMenuStore = [
  SideMenuIcons(CupertinoIcons.gamecontroller,
      artboard: 'GAME', stateMachineName: 'GAME_Interactivity', title: 'Games'),
  SideMenuIcons(CupertinoIcons.square_arrow_down,
      artboard: 'DL', stateMachineName: 'DL_Interactivity', title: 'Downloads')
];
