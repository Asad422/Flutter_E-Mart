import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/firebase_consts.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/firestore_services/firestore_services.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';

class Admin_Pannel extends StatelessWidget {
  const Admin_Pannel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: IconButton(
          
          onPressed: (){
            Get.to(()=>Add_Category_Screen());
          },
          icon: Icon(Icons.add,color: Color.fromARGB(255, 248, 113, 2))),
      appBar: AppBar(
          title: 'Адми - панель'.text.color(whiteColor).size(20).make() ,
        backgroundColor: Color.fromARGB(255, 248, 113, 2),
      ),
      body: Container(
        height: context.screenHeight,
        child:  StreamBuilder(stream: 
        FirestoreServices.getCategories(), 
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
                      child: ListView.builder(
                        itemCount:data.length ,
                        itemBuilder: (context,index){
                        return 



                        Slidable(
      endActionPane:  ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed:(BuildContext context){
                        firestore.collection("categories").doc(data[index]['name']).delete();
                    },
                   backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Удалить',
                  ),
                   SlidableAction(
                 
                    
                    onPressed:(BuildContext context){
                    
                      Get.to(()=>Products_Screen(category: data[index]['name']));
                    },
                   backgroundColor: Color.fromARGB(255, 3, 108, 245),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Изменить',
                  ),
                  
                ],
              ),
              child : 
                        ListTile(
                          title:   Text(data[index]['name']),
                          subtitle:  Text( 'Количество товара :'+data[index]['products'].length.toString()),
                        ));
                        
                      }),
                  );
                }
                
  })
      )
      ),
    );
  }
}


class Add_Category_Screen extends StatefulWidget {
  const Add_Category_Screen({super.key});

  @override
  State<Add_Category_Screen> createState() => _Add_Category_ScreenState();
}

class _Add_Category_ScreenState extends State<Add_Category_Screen> {
   var controller = Get.put(AuthController());

    var imgController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor:Color.fromARGB(255, 248, 113, 2), 
        title: 'Добавить категорию'.text.color(whiteColor).size(20).make(),
      ),
      body: Column(children: [
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: customTextField(hint :'https/image.png',title: 'Изображение',controller:imgController ,),
       ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: customTextField(hint :'Телефоны' ,title: 'Название категории',controller: nameController),
      ),
          10.heightBox,
        SizedBox(
          width: double.infinity,
          child: ourButton(
            
            
            color: redColor,title: 'Добавить категорию',textColor: whiteColor,onPress: ()async{
              controller.addCategory(
              img:  imgController.text,
              name: nameController.text,
             );
             Get.back();
        
                         }),
        )
      ]),
    );
  }
}
class Products_Screen extends StatefulWidget {
  final String? category;
  const Products_Screen({super.key,required this.category});

  @override
  State<Products_Screen> createState() => _Products_ScreenState();
}

class _Products_ScreenState extends State<Products_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: IconButton(
          
          onPressed: (){
            Get.to(()=>Add_Product_Screen(category: widget.category));
          },
          icon: Icon(Icons.add,color: Color.fromARGB(255, 248, 113, 2))),
      appBar: AppBar(
          title: 'Товары'.text.color(whiteColor).size(20).make() ,
        backgroundColor: Color.fromARGB(255, 248, 113, 2),
      ),
      body: Container(
        height: context.screenHeight,
        child:  Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirestoreServices.getProductsOfCategories(widget.category),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
        
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
        
          return ListView(
           
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                      return  Expanded(
                        child: ListView.builder(
                           shrinkWrap: true,
                          itemCount:data['products'].length ,
                          itemBuilder: (context,index){
                          return 
                          Slidable(
      endActionPane:  ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed:(BuildContext context){
                         FirestoreServices.removeItemFromCart(
                          index: index,
                          name: widget.category,
                          name_product: data['products'][index]['name']
                         );
                    },
                   backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Удалить',
                  ),
                  
                ],
              ),child :
                          ListTile(
                            title:   Text(data['products'][index]['name']),
                            subtitle:  Text( 'Продавец:'+data['products'][index]['seller'].toString()),
                          ));
                          
                        }),
                    );
                })
                .toList()
                .cast(),
          );
              },
            ),
        )
      ),
    );
  }
}
class Add_Product_Screen extends StatefulWidget {
  final String? category ;
  const Add_Product_Screen({super.key,required this.category});

  @override
  State<Add_Product_Screen> createState() => _Add_Product_ScreenState();
}

class _Add_Product_ScreenState extends State<Add_Product_Screen> {
   var controller = Get.put(AuthController());

  var imgController = TextEditingController();
  var nameController = TextEditingController();
  var costContoller = TextEditingController();
  var sellerContoller =TextEditingController();
  var imgContoller_one = TextEditingController();
   var img2Contoller_two = TextEditingController();
    var img3Contoller_three=  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
         backgroundColor:Color.fromARGB(255, 248, 113, 2), 
        title: 'Добавить товар в категорию'.text.color(whiteColor).size(20).make(),
      ),
      body: Column(children: [
        Padding(
         padding: const EdgeInsets.all(8.0),
         child: customTextField(hint :'Bloody M324',title: 'Название',controller:nameController ,),
       ),
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: customTextField(hint :'3000',title: 'Цена',controller:costContoller ,),
       ),
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: customTextField(hint :'Samsung CRP',title: 'Продавец',controller:sellerContoller ,),
       ),
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: customTextField(hint :'https/image.png',title: 'Основное изображение',controller:imgController ,),
       ),
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: customTextField(hint :'https/image.png',title: 'Изображение1',controller:imgContoller_one ,),
       ),
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: customTextField(hint :'https/image.png',title: 'Изображение2',controller:img2Contoller_two ,),
       ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: customTextField(hint :'https/image.png' ,title: 'Изображение3',controller: img3Contoller_three),
      ),
          10.heightBox,
        SizedBox(
          width: double.infinity,
          child: ourButton(
            
            
            color: redColor,title: 'Добавить товар',textColor: whiteColor,onPress: ()async{
              controller.addProductToCategory(
              img:  imgController.text,
              name: nameController.text,
              cost : costContoller.text,
              seller: sellerContoller.text,
              img1: imgContoller_one.text,
              img2: img2Contoller_two.text,
              img3: img3Contoller_three.text,
              category_name: widget.category,
             );
             Get.back();
        
                         }),
        )
      ]),
    );
  }
}