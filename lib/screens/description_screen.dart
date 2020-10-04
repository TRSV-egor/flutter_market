import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class DescriptionScreen extends StatelessWidget {

  final dynamic dataFromHomepage;

  DescriptionScreen({Key key, this.dataFromHomepage}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return new Scaffold(
        appBar: new AppBar(
            title: new Text('Интернет магазин сетевой')),
        body: Container(
              constraints: BoxConstraints.expand(),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                    Image.network(dataFromHomepage['imageURL'],fit: BoxFit.fitHeight,),
                    Padding(padding: EdgeInsets.all(16.0),
                      child:
                      Column(
                        children: [
                          Text(dataFromHomepage["title"],
                            style: Theme.of(context).textTheme.headline3),
                          Divider(),
                          Row(
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                child: Text('${dataFromHomepage['price']} руб.',
                                  style: Theme.of(context).textTheme.headline6,
                                  textAlign: TextAlign.left,),),
                              Expanded(
                                  child: Text('${dataFromHomepage['balance']} шт.',
                                      style: Theme.of(context).textTheme.subtitle2,
                                      textAlign: TextAlign.right)),
                            ]
                          ),
                          Divider(),
                          SizedBox(height: 16.0),
                          Wrap(children: [
                            Text(dataFromHomepage['description']),
                          ],)
                  ],
                ),),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(padding: EdgeInsets.all(16.0),
                      child: Wrap(
                        children: [
                          FlatButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                            child: Text('Вернуться'),
                          ),
                          RaisedButton(
                            onPressed: (){},
                            child: const Text('В корзину'),
                          )
                        ],
                      ),
                  ),
              )],
            )
        )
    ),
    );

  }
}