import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/views/profile_screen/profile_screen.dart';
import 'package:emart_app/views/splash_screen/splash_screen.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var controller = Get.put(AuthController());

  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var nameController =TextEditingController();

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
                'Регистрация'.text.fontFamily(bold).white.size(18).make()       ,
                10.heightBox,
                Column(
                    children: [
                      customTextField(hint : emailHint,title: email,controller: emailController,),
                      customTextField(hint : passwordHint,title: password,controller: passwordController),
                      customTextField(hint : 'Имя',title: 'Имя аккаунта',controller: nameController),
                      5.heightBox,
                      ourButton(color: redColor,title: login,textColor: whiteColor,onPress: ()async{
                          
                            await controller.signUpMethod(context: context,email: emailController.text,password: passwordController.text, ).then((value){

                              if(value == null) {
                                  VxToast.show(context, msg:'Ваш аккаунт успешно зарегистрирован');
                              auth.signOut();
                              Get.offAll(()=>LoginScreen());
                              
                              return  controller.storeDataUer(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                
                              );    
                              
                              
                            
                              }
                              else{
                                auth.signOut();
                              }
                            });
                          
                         
                       
                      }).box.width(context.screenWidth -50).make(),
                       RichText(text: 
                      TextSpan(children: [
                        TextSpan(text: 'Уже есть аккаунт?',style: TextStyle(fontFamily: bold,color: fontGrey)),
                        TextSpan(text: signup,style: TextStyle(fontFamily: bold,color: redColor))
                      ])).onTap(() {Get.back();})
                      
                    ],
                ).
                box.white.rounded.padding(EdgeInsets.all(16)).width(context.screenWidth -70).shadowSm.make().box.width(context.screenWidth -50).make(),
                     ],
            ),
          ),
        ),
      );
  }
}