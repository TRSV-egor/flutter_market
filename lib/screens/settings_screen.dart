import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//my imports
import 'package:flutter_market/components/product.dart';
import 'package:flutter_market/databases/DB1.dart';



class SettingsScreen extends StatelessWidget {

  //Получаем список товаров из json в List<Product>
  Future<List<Product>> getPartsListFromJSON(BuildContext context) async {
    String jsonString = await DefaultAssetBundle.of(context).loadString('assets/sparePartsList.json');
    List<dynamic> raw = jsonDecode(jsonString);
    return raw.map((f) => Product.fromJSON(f)).toList();
  }
//Загружаем данные из List<Product> (json) в базу даных
_loadData(context) async {
  List<Product> data = await getPartsListFromJSON(context);
  print(data);
  data.forEach((position) async {
    DatabaseHelper.instance.insert({
      DatabaseHelper.columnId: position.id,
      DatabaseHelper.columnPrice: position.price,
      DatabaseHelper.columnTitle: position.title,
      DatabaseHelper.columnDescription: position.description,
      DatabaseHelper.columnImageURL: position.imageURL,
      DatabaseHelper.columnBalance: position.balance,
    });
  });
}

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
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}

