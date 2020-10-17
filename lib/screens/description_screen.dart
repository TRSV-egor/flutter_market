import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_market/components/cart.dart';


class DescriptionScreen extends StatelessWidget {

  final dynamic product;

  DescriptionScreen({Key key, this.product}) : super(key: key);


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
                    Image.network(product.imageURL,fit: BoxFit.fitHeight,),
                    Padding(padding: EdgeInsets.all(16.0),
                      child:
                      Column(
                        children: [
                          Text(product.title,
                            style: Theme.of(context).textTheme.headline3),
                          Divider(),
                          Row(
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                child: Text('${product.price} руб.',
                                  style: Theme.of(context).textTheme.headline6,
                                  textAlign: TextAlign.left,),),
                              Expanded(
                                  child: Text('${product.balance} шт.',
                                      style: Theme.of(context).textTheme.subtitle2,
                                      textAlign: TextAlign.right)),
                            ]
                          ),
                          Divider(),
                          SizedBox(height: 16.0),
                          Wrap(children: [
                            Text(product.description),
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
                            onPressed: (){

                              Cart.shared.productAdd(product);
                            },
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