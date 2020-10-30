import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_market/components/product.dart';
import 'package:flutter_market/databases/DB1.dart';

class SettingsScreen extends StatefulWidget {
  @override
  SettingsScreenState createState() => SettingsScreenState();
}
  Future<List<Product>> getPartsListFromJSON(BuildContext context) async {
    String jsonString = await DefaultAssetBundle.of(context).loadString('assets/sparePartsList.json');
    List<dynamic> raw = jsonDecode(jsonString);
    return raw.map((f) => Product.fromJSON(f)).toList();
  }

_loadData(context) async{
  List<Product> data = await getPartsListFromJSON(context);
  print(data);
  data.forEach((position) async{
    //if ()
    //await DatabaseHelper.instance.search({ DatabaseHelper.columnId : position.id});
    DatabaseHelper.instance.insert({
      DatabaseHelper.columnId : position.id,
      DatabaseHelper.columnPrice : position.price,
      DatabaseHelper.columnTitle : position.title,
      DatabaseHelper.columnDescription :position.description,
      DatabaseHelper.columnImageURL : position.imageURL,
      DatabaseHelper.columnBalance : position.balance,
      DatabaseHelper.columnLike : 1,
    });
  });
}

class SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: new Text('Настройки')),
        body: new Container( padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              RaisedButton(
                onPressed: () {
                  _loadData(context);
                },
                child: Row(children: [
                  Icon(Icons.cloud_download_outlined, color: Colors.green,),
                  SizedBox(width: 5,),
                  Text('Загрузить из json в БД')],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                onPressed: () {
                  DatabaseHelper.instance.deleteAll();
                },
                child: Row(children: [
                  Icon(Icons.delete_forever, color: Colors.red,),
                  SizedBox(width: 5,),
                  Text('Удалить данные из БД')],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),RaisedButton(
                onPressed: () async{
                  var A =  await DatabaseHelper.instance.search({DatabaseHelper.columnId : 1});
                 if (A[]){
                  print(A);}else{print("null");}
                },
                child: Row(children: [
                  Icon(Icons.search, color: Colors.white,),
                  SizedBox(width: 5,),
                  Text('Найти в БД')],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              )
            ],
          ),
        ));
  }
}
