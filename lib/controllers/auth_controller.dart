
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/firebase_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
class AuthController extends GetxController{
    Future<String?> loginMethod({email,password,context})    async {
        try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
    }
    

    Future<String?> signUpMethod({email,password,context})    async {
       try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
    }


    storeDataUer({password,email,name})  {
      DocumentReference store = firestore.collection(usersCollection).doc(email);
      store.set({
        'password':password,
        'email': email,
        'cart' : [],
      });
    }

    addCategory({name,img}){
      DocumentReference store = firestore.collection('categories').doc(name);
      store.set({
        'img' : img,
        'name' : name,
        'products' : [],
      });
      return null;
    }
      addProductToCategory(
        
        { String ? category_name,
          String? cost,String? name,String? img,String? seller,String? img1,String? img2,String? img3
        
        }) {

  Map<String, dynamic> product = {
  'cost': cost,
  'img':  img ,
  'name' :name,
  'seller' :seller,
  'imgs' :[
    img1,
    img2,
    img3
  ],
};
  DocumentReference store =   firestore.collection('categories').doc(category_name);
                                        store.update(
                                        {  'products' :FieldValue.arrayUnion([product])
                                          });
    
                                   
     }

}