import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class ListOfProducts {
  //Singleton
  static final ListOfProducts _singleton = ListOfProducts._internal();
  factory ListOfProducts() => _singleton;
  ListOfProducts._internal();
  static ListOfProducts get shared => _singleton;
  //Singleton

  List<dynamic> addedProductsList = [];
  int totalPriceValue = 0;

  void productAdd(receivedData, index) {
    if (addedProductsList.contains(receivedData)){
      print("already in cart");
      print(_singleton.addedProductsList[index].balance);
      _singleton.addedProductsList.insert(index, 50);
      //_singleton.addedProductsList[index].balance = _singleton.addedProductsList[index].balance +1;
      print(_singleton.addedProductsList[index].balance);
    }else{
      addedProductsList.add(receivedData);
      totalPriceValue = totalPriceValue + 1;
    }
  }

  void productRemove (receivedData){
    addedProductsList.remove(receivedData);
    totalPriceValue = totalPriceValue - receivedData.price;
  }

  void productClearCart (){
    addedProductsList = [];
    totalPriceValue = 0;
   }

  }

