import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_market/databases/DB1.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  FavoriteScreenState createState() => FavoriteScreenState();
}

class FavoriteScreenState extends State<FavoriteScreen> {

  //Получаем содержимое БД
  _get() async{
    List<Map<String,dynamic>> queryRow = await DatabaseHelper.instance.queryAll();
    return queryRow;
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
                List<Map<String,dynamic>> favoritesListMap = queryRow.data;

                return new ListView.builder(
                    itemCount: favoritesListMap.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => (){},
                        child: Card(
                          child: new Row(children: [
                            FittedBox(
                              fit: BoxFit.fill,
                              child: Image.network(
                                favoritesListMap[index]['imageURL'],
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
                                                favoritesListMap[index]['title'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5,
                                                overflow: TextOverflow.fade,
                                                textAlign: TextAlign.left,
                                              ),
                                              Divider(),
                                              Text(
                                                '${favoritesListMap[index]['price']} руб.',
                                                textAlign: TextAlign.end,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                            ])))),
                            IconButton(
                                icon: Icon(Icons.favorite, color: Colors.red,),
                                onPressed: () {
                                  setState(() {
                                    DatabaseHelper.instance.delete(favoritesListMap[index]['id']);
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
      )
    );

  }
}