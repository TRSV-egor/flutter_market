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
//Получаем данные из json
  Future<List<Product>> getPartsListFromJSON(BuildContext context) async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/sparePartsList.json');
    List<dynamic> raw = jsonDecode(jsonString);
    return raw.map((f) => Product.fromJSON(f)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Лучшие предложения',
        ),
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
                        onTap: () {
                          return Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DescriptionScreen(
                                        product: decodedPartsList[index],
                                        callback: () => setState(() {}),
                                      )));
                        },
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
                                icon: Icon(
                                  Icons.add_shopping_cart,
                                  color: Colors.indigoAccent,
                                ),
                                onPressed: () {
                                  setState(() {
                                    Cart.shared
                                        .productAdd(decodedPartsList[index]);
                                  });
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
      ),
      bottomNavigationBar: new Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                icon: Icon(Icons.favorite_border_outlined),
                tooltip: "Открыть " "Избранное" "",
                onPressed: () {
                  Navigator.pushNamed(context, '/favorite');
                }),
            IconButton(
                icon: Icon(Icons.shopping_cart_outlined),
                tooltip: "Открыть " "Корзину" "",
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                }),
            IconButton(
                icon: Icon(Icons.settings_outlined),
                tooltip: "Открыть " "Настройки" "",
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                }),
          ],
        ),
      ),
    );
  }
}
