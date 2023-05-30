import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  changeScreen(){
    Future.delayed(Duration (seconds: 3),(){

      if(auth.currentUser != null){
        Get.offAll(()=>Home());
      }
      else{
Navigator.pushReplacement(
                    context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                   
                     );
      }

      
    });
    
  }
  @override
  void initState() {
    changeScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 248, 113, 2),
        child: Center(child: Column(children: [
          Align(alignment: Alignment.topLeft,
          child :
          Image.asset(icSplashBg,width: 300,)),
          20.heightBox,
          applogoWidget(),
          10.heightBox,
          appname.text.fontFamily(bold).size(22).white.make(),
          5.heightBox,
          appversion.text.white.make(),
          
      
        ],)),
      ),
    );
  }
}