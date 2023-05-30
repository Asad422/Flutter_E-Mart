import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/firestore_services/firestore_services.dart';
import 'package:emart_app/views/cart_screen/cart_screen.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ItemDetails extends StatefulWidget {
  final String? title;
  final int?  index; 
  final String? name;
  const ItemDetails({super.key,required this.title,required this.index,required this.name});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      
      appBar: AppBar(
         backgroundColor: Color.fromARGB(255, 248, 113, 2), 
        title: widget.name!.text.color(whiteColor).fontFamily(bold).make(),

      ),
      body:
          Container(
            color: Colors.white,
            height: context.screenHeight,
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: FirestoreServices.getProductsOfCategories(widget.title),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                return const Text('Something went wrong');
                      }
          
                      if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
                      }
                      return Container(
                child: ListView(
                   shrinkWrap: true,
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                       
                      return 
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Card(
                                      elevation: 5,
                                      child: VxSwiper.builder(
                                        autoPlay: true,
                                        itemCount: 
                                    
                                      data['products'][widget.index]['imgs'].length,
                                      
                                      itemBuilder: (context,index){
                                        return Image.network(
                                          
                                           data['products'][widget.index]['imgs'][index],
                                           width: 200,
                                           height: 200,
                                           
                                           
                                          
                                        );
                                      }),
                                    ),
                                    10.heightBox,
                                    Card(
                                     
                              
                                      
                                         color:  Color.fromRGBO(16, 196, 76,1),
                                        child: RichText(
                                          text: TextSpan(
                                          children: [
                                               TextSpan(
                                           text :  data['products'][widget.index]['cost'].toString(),
                                              style: TextStyle(
                                               
                                                fontFamily: bold,
                                                fontSize: 30,
                                                color: Colors.white
                                              ),
                                          ),
                                          WidgetSpan(
                                              child: Container(
                                                  
                                                  child: Icon(
                                                    size : 30,
                                                    Icons.currency_ruble,color: Colors.white,),
                                                ),
                                              ),
                                        ]
                                        )),
                                      ),
                                    
                                    
                                    10.heightBox,
                                    widget.name.toString().text.color(redColor).fontFamily(semibold).size(20).make(),
                                    10.heightBox,
                              
                                    Container(
                              
                                      height: 100,
                                      child: Card(
                                        color: Color.fromARGB(255, 248, 113, 2),
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                
                                                'Продавец'.text.fontFamily(semibold).color(lightGrey).size(18).make(),
                                              
                                              ]),
                                              Row(
                                                children: [
                                                    data['products'][widget.index]['seller'].toString().text.fontFamily(bold).size(22).make()
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                     
                                    
                                  ],
                                ),
                         );
                            
                          
                          
                             
                          
                        
                        

                      
                      })
                      .toList()
                      .cast(),
                ),
                      );
                    },
                  ),
               Container(
                height: 60,
                             color: redColor,
                                  width: double.infinity,
                                  child: TextButton(
                                    onPressed: ()async {
                                     
                                      
                                     
                                     await   FirestoreServices.addProductToCart(
                                        index: widget.index,
                                        title: widget.title,

                                       );
                                       Get.to(()=>CartScreen());                                           

                                    },
                                    child: 
                                  Text('Добивить в корзину',
                                    style: TextStyle(
                                      color: Colors.white,
                        
                                    ),
                                  )),
                                ),
              
              
              ],


            ),
          ));
  }
}