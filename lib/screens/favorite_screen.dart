import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_market/components/product.dart';
import 'package:flutter_market/databases/DB1.dart';

import 'description_screen.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  FavoriteScreenState createState() => FavoriteScreenState();
}

class FavoriteScreenState extends State<FavoriteScreen> {
  //Получаем содержимое БД
  _get() async {
    return await DatabaseHelper.instance.queryAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: new Text('Избранное')),
        body: new Container(
          child: FutureBuilder(
              future: _get(),
              builder: (context, queryRow) {
                if (queryRow.hasData) {
                  List<Product> favoritesListJSON = queryRow.data;

                  if (favoritesListJSON.isEmpty) {
                    return new Center(
                        child: Text('Вы ещё ничего не добавили в избранное',
                            style: Theme.of(context).textTheme.subtitle1));
                  } else {
                    return new ListView.builder(
                        itemCount: favoritesListJSON.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DescriptionScreen(
                                          product: favoritesListJSON[index],
                                          callback: () => setState(() {}),
                                        ))),
                            child: Card(
                              child: new Row(children: [
                                FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image.network(
                                    favoritesListJSON[index].imageURL,
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
                                                    favoritesListJSON[index]
                                                        .title,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5,
                                                    overflow: TextOverflow.fade,
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Divider(),
                                                  Text(
                                                    '${favoritesListJSON[index].price} руб.',
                                                    textAlign: TextAlign.end,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                  ),
                                                ])))),
                                IconButton(
                                    icon: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        DatabaseHelper.instance.delete(
                                            favoritesListJSON[index].id);
                                      });
                                    }),
                              ]),
                            ),
                          );
                        });
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ));
  }
}
