import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/firestore_services/firestore_services.dart';
import 'package:emart_app/views/category_screen/category_screen_details.dart';
import 'package:emart_app/widgets_common/home_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  
  Widget build(BuildContext context) {
    return Container(
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(child: Column(
        children: [
        Container(
          color: lightGrey,
          child: TextFormField(
          decoration:const InputDecoration(
            filled: true,
            fillColor: whiteColor,
            suffixIcon: Icon(Icons.search),
            hintText: 'Найдите что-то для себя',
            hintStyle: TextStyle(color: textfieldGrey)
          ),
          ),
        ),
        20.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: 
          List.generate(2, (index) => 
            homeButtons(
              height: context.screenHeight * 0.15,
              width: context.screenWidth / 2.5,
              icon : index == 0 ? icTodaysDeal : icFlashDeal,
              title: index == 0 ? 'Товары Дня' :  'Горящие Скидки'
            ),
          ),

        ),
      20.heightBox,
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: 
          List.generate(2, (index) => homeButtons(
            height: context.screenHeight * 0.15,
            width: context.screenWidth / 2.5,
            icon : index == 0 ? icTopCategories : icTopSeller,
            title: index == 0 ? 'Топ Категории' :  'Топ Продаж',
            onPress: index == 0? (){
            FirestoreServices.getTopCategory().then((category){
              
              Get.to(CategoryDetails(title: category));
            });
              
            } : (){}
          )),

        )
      ],)),
    );
  }
}