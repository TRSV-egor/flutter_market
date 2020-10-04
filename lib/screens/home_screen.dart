import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'description_screen.dart';

class HomeScreen extends StatefulWidget {

  @override
  HomeScreenState createState() => HomeScreenState();

}

class HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
          title: new Text('Интернет магазин')),
        body: new Container(
          child: FutureBuilder(builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.done)

            {var myData = json.decode(snapshot.data.toString());
              return new ListView.builder(
                itemCount: myData == null ?  0 : myData["parts"].length,
                itemBuilder: (BuildContext context,int index) {
                  return GestureDetector(
                      onTap:() =>  Navigator.push(context,MaterialPageRoute(builder: (context)=> DescriptionScreen(dataFromHomepage: myData['parts'][index],))),
                      child: new Card(
                          child: new Row(
                            children: [
                              FittedBox(
                                fit: BoxFit.cover,
                                child: Image.network(myData["parts"][index]["imageURL"], width: 80, height: 80,) ,
                              ),
                              Container(
                                child: Expanded(
                                  child: Padding(padding: EdgeInsets.all(10.0),
                                    child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.stretch,
                                     children: [
                                      Text(myData["parts"][index]["title"],
                                            style: Theme.of(context).textTheme.headline5,
                                            overflow: TextOverflow.fade,
                                            textAlign: TextAlign.left,
                                      ),
                                      Divider(),
                                      Text('${myData["parts"][index]["price"]} руб.',
                                            textAlign: TextAlign.end,
                                            style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],),))
                              )
                            ]
                        ),
                      )
                  );
                  // showDialog(
                },
              );} else {
              return Center(
                  child: CircularProgressIndicator());
            }
        },
          future: DefaultAssetBundle.of(context).loadString('assets/sparePartsList.json'),
          ),
      )
    );
  }
}


