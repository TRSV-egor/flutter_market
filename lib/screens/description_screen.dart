import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

//my import
import 'package:flutter_market/components/cart.dart';
import 'package:flutter_market/components/product.dart';
import 'package:flutter_market/databases/DB1.dart';

class DescriptionScreen extends StatefulWidget {

  final Product product;
  bool like = false;

  DescriptionScreen({Key key, @required this.product}) : super(key: key);

  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {

  //bool like = checkStatus();


  //Функция для изменения состояния лайка и добавления\удаления записи в БД
  pressLike() async{
    List<Map> dataFromDB  =  await DatabaseHelper.instance.search({DatabaseHelper.columnId : widget.product.id});
    if (dataFromDB.isNotEmpty) {
      DatabaseHelper.instance.delete(widget.product.id);
      print('deleted');

      setState(() {widget.like = false;});
      print(widget.like);
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


      setState(() {widget.like = true;});
      print(widget.like);
    }
  }


Future<bool> check(id) async{
  List<Map> dataFromDB =  await DatabaseHelper.instance.search({DatabaseHelper.columnId : id});
  if (dataFromDB.isNotEmpty) {
    print('1');
    return true;
  }else{
    print('0');
    return false;
  }
}



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Описание')),
      body: Container(
          //constraints: BoxConstraints.expand(),
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

            ],
          ))),
    bottomNavigationBar: FutureBuilder(
      future: check(widget.product.id),
      builder: (context, AsyncSnapshot<bool> snapshot){
        widget.like = snapshot.data;
        return Container(height: 50,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Wrap(
              children: [
                Text('Тестим вот это ${widget.like}'),

                IconButton(
                  icon: Icon(Icons.star),
                  onPressed: () {
                    //print(widget.likeChanged);
                  },
                ),

                IconButton(
                  icon: Icon(
                    widget.like ? Icons.favorite : Icons.favorite_border_outlined,
                    color: widget.like ? Colors.red : Colors.black38,
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
        ),
      );},
      
    ),
    );
  }
}
