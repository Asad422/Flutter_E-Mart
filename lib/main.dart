import 'package:emart_app/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'consts/consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appname,
      theme: ThemeData(
      
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: whiteColor
          ),
          backgroundColor: Colors.transparent),
        fontFamily: regular
              ),
              home: const SplashScreen(),
    );
  }
}
