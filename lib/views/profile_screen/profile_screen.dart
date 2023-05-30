import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/firestore_services/firestore_services.dart';
import 'package:emart_app/views/admin_screen/admin_screen.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/views/profile_screen/components/details_card.dart';
import 'package:emart_app/views/splash_screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfileScreen extends StatefulWidget {
  
   ProfileScreen({super.key});


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool permission = false;
  var controller = Get.put(AuthController());
  @override
  void initState() {
  
    if( auth.currentUser!.email == 'admin@gmail.com'){
      permission = true;
    }
    else{
      permission = false;
    }
   
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Профиль'.text.color(Color.fromARGB(255, 248, 113, 2)).size(20).make() ,
        backgroundColor:  Colors.white,
        actions: [
          Visibility(
          visible: permission,
            child: IconButton(onPressed: ()  {
              Get.to(()=>Admin_Pannel());
            }, icon: Icon(Icons.admin_panel_settings,color:Color.fromARGB(255, 248, 113, 2) ,)),
          ),
          IconButton(onPressed: () async {
            auth.signOut();
            Get.offAll(()=>SplashScreen());
          }, icon: Icon(Icons.logout,color:Color.fromARGB(255, 248, 113, 2) ,)),
          
        ],
      ),
      body: SafeArea(
        child: 
      Container(

        height: context.screenHeight/2,
        color:  Color.fromARGB(255, 248, 113, 2),
       
        child:
        
        StreamBuilder(stream: 
        FirestoreServices.getUser(auth.currentUser!.email), 
        builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
            
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(whiteColor)),
            );
          }
        else{
          var data = snapshot.data!.docs;
              return 
                  SafeArea(
                    child: Column(
                      children: [
                                
                          20.heightBox,
                          
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detailCard(count: data[0]['cart'].length.toString() ,title: 'в корзине',width: context.screenWidth/3.4),
                          
                          ],
                         ),
                         40.heightBox,
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: ListTile(
                            leading:Image.asset(
                                  width: 22,
                                  icOrder),
                            title: 'Избранное'.text.make(),
                            
                            
                           ).box.white.rounded.padding(EdgeInsets.symmetric(horizontal: 16)).shadowSm.make(),
                         ),
                   
                         Text(auth.currentUser!.email.toString())
                        ]),
                  );
                }
                
  })
      )
      )
      )
      )
      ;
          
     

      }}
        
      