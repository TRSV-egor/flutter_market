import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

//my import
import 'package:flutter_market/components/cart.dart';
import 'package:flutter_market/components/product.dart';
import 'package:flutter_market/databases/DB1.dart';
import 'package:flutter_market/screens/cart_screen.dart';



class DescriptionScreen extends StatefulWidget {
  final Product product;

  DescriptionScreen({Key key, this.product}) : super(key: key);

  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {

  //bool like = checkStatus();
  bool like = true;

  //Функция для изменения состояния лайка
  checkStatus() async{
    List<Map> dataFromDB  =  await DatabaseHelper.instance.search({DatabaseHelper.columnId : widget.product.id});
    if (dataFromDB.isNotEmpty) {
      DatabaseHelper.instance.delete(widget.product.id);
      print('deleted');

      setState(() {like = false;});
      print(like);
    }else{
      await  DatabaseHelper.instance.insert({
        DatabaseHelper.columnId : widget.product.id,
        DatabaseHelper.columnPrice : widget.product.price,
        DatabaseHelper.columnTitle : widget.product.title,
        DatabaseHelper.columnDescription : widget.product.description,
        DatabaseHelper.columnImageURL : widget.product.imageURL,
        DatabaseHelper.columnBalance : widget.product.balance,
        DatabaseHelper.columnLike : 1,
      });
      print('added');


      setState(() {like = true;});
      print(like);
    }
  }






  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Описание')),
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

                      IconButton(icon: Icon(Icons.ac_unit_outlined), onPressed: () {
                        checkStatus();
                      }),

                      IconButton(
                        icon: Icon(
                          like ? Icons.favorite : Icons.favorite_border_outlined,
                          color: like ? Colors.red : Colors.black38,
                        ),
                        onPressed: () {
                          checkStatus();
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

                            Cart.shared.productAdd(widget.product)

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
