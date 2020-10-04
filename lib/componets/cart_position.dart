import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartPosition extends StatefulWidget {

  @override
  CartPositionState createState() => CartPositionState();

}

class CartPositionState extends State<CartPosition> {

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index){
          return new Card(
            child: ListTile(
                  title: Text('Product 1',),
                  subtitle: Text("Цена : 500000",),
                  leading: Image.asset('assets/images/SPM-500.jpg',),
                  trailing: Column(
                    children: [
                      IconButton(icon: Icon(Icons.arrow_drop_up), onPressed: null),
                      IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: null),
                    ],
                  ),

                  //isThreeLine: true,
                  //dense: true,
            ),


          );
        },
    );
  }

}