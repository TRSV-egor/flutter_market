//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  FavoriteScreenState createState() => FavoriteScreenState();
}

class FavoriteScreenState extends State<FavoriteScreen> {

  _get() async{
    List<Map<String,dynamic>> queryRow
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text('Избранное')),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('title'),
              subtitle: Text('price'),  
              leading: Image.network("http://t2.gstatic.com/images?q=tbn:ANd9GcR2yN1BTyr9BW57J7z4IcQU0i-P6skrmyQbDKho6-8pvBqf5AcWv67zG041rE_1gL-Met3mDJEobKFwmOaYkfo"),
              trailing: Icon(Icons.favorite, color: Colors.red,),
            );
          }
      ),
    );

  }
}