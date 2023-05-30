import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';

class FirestoreServices {
  static getUser(email){

    return firestore.collection(usersCollection).where('email' ,isEqualTo: email).snapshots();
    
  }

  static getCartProducts(email){
    return firestore.collection('users').where('email', isEqualTo: email).snapshots();
  }
  static getCategories(){
    return firestore.collection('categories').snapshots();
  }
  static  Stream<QuerySnapshot> getProductsOfCategories(name){
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection('categories').where('name',isEqualTo: name).snapshots();
    return stream;
    
     }
     static  Stream<QuerySnapshot> getProductsOfCart(email){
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection('users').where('email',isEqualTo: email).snapshots();
    return stream;
    
     }

     static addProductToCart({int? index,String? title}) {


    
      final docRef = firestore.collection("categories").doc(title);
docRef.get().then(
  (DocumentSnapshot doc) {
      Map<String, dynamic> product = {};
    final data = doc.data() as Map<String, dynamic>;
   product['name'] = data['products'][index]['name'];
   product['cost'] = data['products'][index]['cost'];
   product['seller'] = data ['products'][index]['seller'];
   product['img'] = data['products'][index]['img'];
   product['count'] = 1;
  return product;

  },
  
).then((product) {
   DocumentReference store =   firestore.collection(usersCollection).doc(auth.currentUser!.email);
                                        store.update(
                                        {  'cart' :FieldValue.arrayUnion([product])
                                          });
    
});


 
                                   
     }

static removeItemFromCart({String? name, index,String ? name_product}) async {
  final collection = FirebaseFirestore.instance
      .collection('categories')
      .doc(name);
  final docSnap = await collection.get();
  List products = docSnap.get('products');
  List item = products.where((element) => element['name'].contains(name_product))
.      toList();
  collection.update({'products': FieldValue.arrayRemove(item)});

}
static removeProductFromMyCart ({String? name_product}) async {
   final collection = FirebaseFirestore.instance
      .collection('users')
      .doc(auth.currentUser!.email);
  final docSnap = await collection.get();
  List products = docSnap.get('cart');
  List item = products.where((element) => element['name'].contains(name_product))
.      toList();
  collection.update({'cart': FieldValue.arrayRemove(item)});
}
}