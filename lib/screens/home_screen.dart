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
        //drawer: Drawer(
            // child: ListView(
            //   padding: EdgeInsets.zero,
            //   children: <Widget>[
                // DrawerHeader(
                //   child: Container(
                //       child: Row(children:[
                //         Image.asset('assets/images/SPM-500.jpg', height: 50, width: 50,),
                //         SizedBox(width: 50.0,),
                //         Expanded(child: Text('SPARE PARTS MARKET', style: Theme.of(context).textTheme.headline4,))
                //       ])
                //   ),
                //   decoration: BoxDecoration(
                //     color: Colors.indigo,
                //   ),
                // ),

                // ListTile(
                //   title: Text('О приложении'),
                //   leading: Icon(Icons.info),
                //   onTap: () {
                //     Navigator.pop(context);
                //     showDialog(context: context,
                //         builder: (_) => AlertDialog(
                //           title: new Text("О программе",
                //             textAlign: TextAlign.center,
                //             style: Theme.of(context).textTheme.headline4,),
                //           content: Container(height: 200,
                //             color: Colors.red,
                //             alignment: Alignment.center,
                //             child: Column(mainAxisAlignment: MainAxisAlignment.start,
                //               children:[
                //               Text("Тестовое приложение Flutter"),
                //               SizedBox(height: 15,),
                //               Image.network('https://sntch.com/uploads/2018/12/anons-1.jpg',fit: BoxFit.cover,)
                //             ],),
                //           ),
                //           actions: <Widget>[
                //             FlatButton(
                //               child: Text('Продолжить'),
                //               onPressed: () {
                //                 Navigator.of(context).pop();
                //               },
                //             )
                //           ],
                //         ));
                //   },
                // ),

            //   ],
            // )),
        appBar: new AppBar(
          title: new Text('Лучшие предложения', ),
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
                                  builder: (context) {
                                    return DescriptionScreen(
                                    product: decodedPartsList[index],
                                  );
                                  })),
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
                                  icon: Icon(Icons.add_shopping_cart,
                                   color: Colors.indigoAccent,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      Cart.shared.productAdd(decodedPartsList[index]);
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
            IconButton(icon: Icon(Icons.favorite_border_outlined),tooltip: "Открыть ""Избранное""", onPressed: (){Navigator.pushNamed(context, '/favorite');}),
            IconButton(icon: Icon(Icons.shopping_cart_outlined), tooltip: "Открыть ""Корзину""", onPressed: (){Navigator.pushNamed(context, '/cart');}),
            IconButton(icon: Icon(Icons.settings_outlined),tooltip: "Открыть ""Настройки""", onPressed: () {Navigator.pushNamed(context, '/settings');}),

          ],),
        
      ),
    
    );
    
  }
}
