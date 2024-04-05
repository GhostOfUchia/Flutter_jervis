import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jarvis/jarvis_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark
  ));
  runApp(ProjectJarvis());
}

class ProjectJarvis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
home: Jarvis(),
    );
  }
}

