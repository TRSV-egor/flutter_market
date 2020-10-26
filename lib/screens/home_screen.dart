//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_market/components/cart.dart';
import 'dart:convert';

//my import
import 'package:flutter_market/screens/description_screen.dart';
import 'package:flutter_market/components/product.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Future<List<Product>> getPartsListFromJSON(BuildContext context) async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/sparePartsList.json');
    List<dynamic> raw = jsonDecode(jsonString);
    return raw.map((f) => Product.fromJSON(f)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
                DrawerHeader(
                  child: Text('SPM', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline3,),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage('https://www.garicambi.com/wp-content/themes/garicambi/img/parts.png')),
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  title: Text('Избранное'),
                  leading: Icon(Icons.favorite),
                  onTap: () {Navigator.pop(context);
                  Navigator.pushNamed(context, '/favorite');
                  },
                ),

                ListTile(
                  title: Text('Корзина'),
                  leading: Icon(Icons.shopping_cart),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/cart');
                  },
                ),

              ListTile(
                title: Text('О приложении'),
                leading: Icon(Icons.info),
                onTap: () {

                  Navigator.pop(context);
                },
              ),

              ],
            )),
        appBar: new AppBar(
          title: new Text('SPM - Spare Parts Market'),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                })
          ],
        ),
        body: new Container(
          child: FutureBuilder(
              future: getPartsListFromJSON(context),
              builder: (context, data) {
                if (data.hasData) {
                  List<Product> decodedPartsList = data.data;

                  return new ListView.builder(
                      itemCount: decodedPartsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DescriptionScreen(
                                        product: decodedPartsList[index],
                                      ))),
                          child: Card(
                            child: new Row(children: [
                              FittedBox(
                                fit: BoxFit.fill,
                                child: Image.network(
                                  decodedPartsList[index].imageURL,
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                              Container(
                                  child: Expanded(
                                      child: Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                  decodedPartsList[index].title,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5,
                                                  overflow: TextOverflow.fade,
                                                  textAlign: TextAlign.left,
                                                ),
                                                Divider(),
                                                Text(
                                                  '${decodedPartsList[index].price} руб.',
                                                  textAlign: TextAlign.end,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1,
                                                ),
                                              ])))),
                              IconButton(
                                  icon: Icon(Icons.add_shopping_cart),
                                  onPressed: () {
                                    Cart.shared
                                        .productAdd(decodedPartsList[index]);
                                  }),
                            ]),
                          ),
                        );
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ));
  }
}
