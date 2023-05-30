import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/firestore_services/firestore_services.dart';
import 'package:emart_app/views/category_screen/item_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({Key ? key ,required this.title}) : super (key : key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
    backgroundColor:  Color.fromARGB(255, 248, 113, 2),
        title: widget.title!.text.fontFamily(bold).white.make(),
      ),
      body: Container(
        
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
           Expanded(
          child :  StreamBuilder<QuerySnapshot>(
      stream: FirestoreServices.getProductsOfCategories(widget.title),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          shrinkWrap: true,
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                    return 
                
                Expanded(
                   child: GridView.builder(
                               shrinkWrap: true,
                               itemCount:data['products'].length ,
                               gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                               crossAxisCount: 2,
                               mainAxisExtent: 250
                             ), itemBuilder: (context,index){
                              return Card(
                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Image.network(
                                                     data['products'][index]['img'],
                                                      height: 100,
                                                      width: 200,
                                                      fit: BoxFit.contain,
                                               
                                                    ),
                                                    Divider(thickness: 4,),
                                                        data['products'][index]['name'].toString().text.color(fontGrey).fontFamily(bold).size(16).make(),
                                                    10.heightBox,
                                                      RichText(
                                                        text: TextSpan(
                                                          children: [

                   


                                                              TextSpan(
                               text :  data['products'][index]['cost'].toString(),
                                  style: TextStyle(
                                   
                                    fontFamily: semibold,
                                    fontSize: 16,
                                    color:redColor,
                                  ),
                              ),
                                                               WidgetSpan(
                                  child: Container(
                                      
                                      child: Icon(
                                        size : 18,
                                        Icons.currency_ruble,color: redColor),
                                    ),
                                  ),
                                                          ],
                                                        )),
                                                   
                                                    10.heightBox,
                                                  ],
                                 ).box.white.margin(EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(EdgeInsets.all(12)).make().onTap(() {

                                                
                                                
                                                
                                                  Get.to(()=>ItemDetails(name:  data['products'][index]['name'].toString(),
                                                  title: widget.title,
                                                                           index :    index   ,
                                                                                          ));
                                 }),
                              );
                             }),
                 
               );
              })
              .toList()
              .cast(),
        );
      },
    ))
    ])));}
}


             