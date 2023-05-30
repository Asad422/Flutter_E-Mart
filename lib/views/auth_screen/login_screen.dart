import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/views/auth_screen/signup_screen.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/views/profile_screen/profile_screen.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   var controller = Get.put(AuthController());

  var passwordController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
  
     return Scaffold(
        body: Container(
          color: Color.fromARGB(255, 248, 113, 2),
          child: Center(
            child: Column(
              children: [
                (
                  context.screenHeight * 0.1).heightBox,
                applogoWidget(),
                10.heightBox,
                'Авторизация'.text.fontFamily(bold).white.size(18).make()       ,
                10.heightBox,
                Column(
                    children: [
                      customTextField(hint : emailHint,title: email,controller: emailController),
                      customTextField(hint : passwordHint,title: password,controller: passwordController),
                      5.heightBox,
                      ourButton(color: redColor,title: signup,textColor: whiteColor,onPress: ()async{
                       
                            await controller.loginMethod(context: context,email: emailController.text,password: passwordController.text).then((value)  {
                              if(value == null){
                                    VxToast.show(context, msg:'Вы успешно вошли');
                                     
                              Get.offAll(()=>Home());
                              
                              }
                              else{
                             auth.signOut();
                              }
                            });
                          }
                       
                      ).box.width(context.screenWidth -50).make(),
                      5.heightBox,
                      createNewAccount.text.color(fontGrey).make(),
                      5.heightBox,
                      ourButton(color: lightGolden,title: login,textColor: redColor,onPress: (){
                        Navigator.pushReplacement(
                    context,
                  MaterialPageRoute(builder: (context) => const SignupScreen()),
                   
                     );
                           
                      }).box.width(context.screenWidth -50).make(),
                      5.heightBox,
                     
                    ],
                ).
                box.white.rounded.padding(EdgeInsets.all(16)).width(context.screenWidth -70).shadowSm.make()
                     ],
            ),
          ),
        ),
      );
    
  }
}