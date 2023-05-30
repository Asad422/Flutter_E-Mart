import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/firestore_services/firestore_services.dart';
import 'package:emart_app/views/category_screen/category_screen_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        backgroundColor: Color.fromARGB(255, 248, 113, 2), 
        title :category.text.fontFamily(bold).white.make()),
        body: 
        Container(
          padding: EdgeInsets.all(12),
          child: 
          StreamBuilder(stream: FirestoreServices.getCategories(), builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
         
         if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor)),
            );
          }
        else{
          var data = snapshot.data!.docs;
          return 
          GridView.builder(
            itemCount:  data.length ,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,mainAxisSpacing: 8,crossAxisSpacing: 8,mainAxisExtent:200 ),
             itemBuilder: ((context, index){
              return Column(
                children: [
                  Image.network(data[index]['img'], height: 120,width: 200,
                  fit: BoxFit.contain,
                              )     ,
                              10.heightBox,
                      data[index]['name'].toString().text.align(TextAlign.center).color(darkFontGrey).make()           ],
              ).box.white.rounded.clip(Clip.antiAlias).outerShadowSm.make().onTap(() {
              
                Get.to(()=> CategoryDetails(title : data[index]['name'].toString()));
              });
             }),
        );
              }}))
             
        ));
        
  }}
         
        
  