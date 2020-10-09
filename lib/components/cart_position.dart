import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ListOfProducts {
  static final ListOfProducts _listOfProducts = ListOfProducts._internal();
  List<dynamic> cartList = [];
  int totalCartValue = 0 ;
  int totalPriceValue = 0;

  //int get total => cartList.length;

  factory ListOfProducts() {

    return _listOfProducts;
  }

  ListOfProducts._internal();

  void productAdd (receivedData){
    if (cartList.contains(receivedData)){
      print(Text('Already in cart!'));
    }else{
      cartList.add(receivedData);
      totalPriceValue = totalPriceValue + receivedData.price;
      totalCartValue = totalCartValue + 1;
      print(totalCartValue);
    };


  }
  void productRemove (receivedData){
    cartList.remove(receivedData);
    totalPriceValue = totalPriceValue - receivedData.price;
    totalCartValue = totalCartValue - 1;
    print(totalCartValue);
  }
  void productClearCart (){
    cartList = [];
    totalCartValue = 0;
    totalPriceValue = 0;
    print(totalCartValue);
  }
}

//====================================

//===================================

class CartPosition extends StatefulWidget {

  @override
  CartPositionState createState() => CartPositionState();

}

class CartPositionState extends State<CartPosition> {

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: ListOfProducts().cartList.length,
        itemBuilder: (context, index){
          return new Card(
            child: ListTile(
                  title: Text(ListOfProducts().cartList[index].title),
                  subtitle: Text("Цена : ${ListOfProducts().cartList[index].price}",),
                  leading: Image.network(ListOfProducts().cartList[index].imageURL),
                  trailing: Container(
                    child: Column(
                      children: [
                        //IconButton(icon: Icon(Icons.arrow_drop_up), iconSize: 100.0, onPressed: null),
                        IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: (){
                          ListOfProducts().productRemove(ListOfProducts().cartList[index]);
                        }),
                      ],
                    ),
                  ),

                  //isThreeLine: true,
                  //dense: true,
            ),


          );
        },
    );
  }

}