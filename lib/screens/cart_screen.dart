import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {

  @override
  CartScreenState createState() => CartScreenState();

}

class CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Корзина'),
      ),
      bottomNavigationBar: Container(
        color: Colors.indigo,
        child: Row(
          children: [
            Expanded(
                child: ListTile(
                  title: Text("Hello"),
                ))
          ],
        ),
      ),
    );
  }

}