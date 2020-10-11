import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class DescriptionScreen extends StatelessWidget {

  final dynamic dataFromJSON;

  DescriptionScreen({Key key, this.dataFromJSON}) : super(key: key);


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
                    Image.network(dataFromJSON.imageURL,fit: BoxFit.fitHeight,),
                    Padding(padding: EdgeInsets.all(16.0),
                      child:
                      Column(
                        children: [
                          Text(dataFromJSON.title,
                            style: Theme.of(context).textTheme.headline3),
                          Divider(),
                          Row(
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                child: Text('${dataFromJSON.price} руб.',
                                  style: Theme.of(context).textTheme.headline6,
                                  textAlign: TextAlign.left,),),
                              Expanded(
                                  child: Text('${dataFromJSON.balance} шт.',
                                      style: Theme.of(context).textTheme.subtitle2,
                                      textAlign: TextAlign.right)),
                            ]
                          ),
                          Divider(),
                          SizedBox(height: 16.0),
                          Wrap(children: [
                            Text(dataFromJSON.description),
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