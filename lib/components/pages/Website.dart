import 'package:flutter/cupertino.dart';

class Website extends StatefulWidget {
  const Website({super.key});

  @override
  State<Website> createState() => _WebsiteState();
}

class _WebsiteState extends State<Website> {
  @override
  Widget build(BuildContext context) {
    return Container(width: double.infinity, height: double.infinity, color: Color(0xFF4CAF5D),);
  }
}
