import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counter_button/counter_button.dart';
import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/styles.dart';
import 'package:emart_app/firestore_services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Color.fromARGB(255, 248, 113, 2), 
        title: 'Корзина'.toString().text.color(whiteColor).fontFamily(bold).make(),
      ),
      body: Container(
      
          child :  Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder<QuerySnapshot>(
      stream: FirestoreServices. getProductsOfCart(auth.currentUser!.email),
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
                children: snapshot.data!.docs
                    .map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                          return ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data['cart'].length,
                            itemBuilder: (context,index){
                              return 
                              Slidable(
              endActionPane:  ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed:(BuildContext context){
                               FirestoreServices.removeProductFromMyCart(
                                
                              
                                name_product: data['cart'][index]['name']
                               );
                          },
                         backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Удалить',
                        ),
                        
                      ],
                    ),
                              
                              child :
                              
                              
                              
                              
                              Container(
                                width: double.infinity,
                                child: 
                                
                                
                                
                                Card(
                                  elevation: 5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Image.network(data['cart'][index]['img'],
                                             height: 100,
                                                                width: 150,
                                                                fit: BoxFit.contain,
                                            
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                             Card(
                                                 color:  Color.fromRGBO(16, 196, 76,1),
                                               child: RichText(
                                                  text: TextSpan(
                                                  children: [
                                                       TextSpan(
                                                   text :  data['cart'][index]['cost'].toString(),
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
                                          
                                          data['cart'][index]['name'].toString().text.color(redColor).fontFamily(semibold).size(20).make(),
        
                                          Text('Кол-во :' + data['cart'][index]['count'].toString(),style: TextStyle(
                                              color: fontGrey,
                                              fontFamily: bold,
                                              fontSize: 25,
                                              
                                          ),),
            
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                               ) );
                            });
                      
                     
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
                                     
                                      
                                     
                                                                    

                                    },
                                    child: 
                                  Text('Оформить заказ',
                                    style: TextStyle(
                                      color: Colors.white,
                        
                                    ),
                                  )),
                                ),
            ],
          )
      ),
    );
  }
}