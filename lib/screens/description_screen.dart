import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

//my import
import 'package:flutter_market/components/cart.dart';
import 'package:flutter_market/components/product.dart';



class DescriptionScreen extends StatefulWidget {
  final Product product;

  DescriptionScreen({Key key, this.product}) : super(key: key);

  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  //Сюда нужно получить состояние лайка на основании Product
  bool like = true;

  //Функция для изменения состояния лайка
  void pressLike() {
    setState(() {
      like = !like;

    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('SPM')),
      body: Container(
          constraints: BoxConstraints.expand(),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Image.network(
                widget.product.imageURL,
                fit: BoxFit.fitHeight,
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(widget.product.title,
                        style: Theme.of(context).textTheme.headline3),
                    Divider(),
                    Row(
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '${widget.product.price} руб.',
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                              child: Text('${widget.product.balance} шт.',
                                  style: Theme.of(context).textTheme.subtitle2,
                                  textAlign: TextAlign.right)),
                        ]),
                    Divider(),
                    SizedBox(height: 16.0),
                    Wrap(
                      children: [
                        Text(widget.product.description),
                      ],
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Wrap(
                    children: [
                      IconButton(
                        icon: Icon(
                          like
                              ? Icons.favorite_border_outlined
                              : Icons.favorite,
                          color: like ? Colors.black38 : Colors.red,
                        ),
                        onPressed: () {
                          pressLike();
                        },
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Вернуться'),
                      ),
                      RaisedButton(
                        onPressed: () {
                          Cart.shared.productAdd(widget.product);

                        },
                        child: const Text('В корзину'),
                      )
                    ],
                  ),
                ),
              )
            ],
          ))),
    );
  }
}
