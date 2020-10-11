import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_market/components/cart_position.dart';
import 'dart:convert';

//my import
import 'package:flutter_market/screens/description_screen.dart';
import 'package:flutter_market/components/PartsList.dart';



class HomeScreen extends StatefulWidget {



  @override
  HomeScreenState createState() => HomeScreenState();

}

class HomeScreenState extends State<HomeScreen> {

  Future<List<JSONPartsList>> getPartsListFromJSON(BuildContext context) async {
    String jsonString = await DefaultAssetBundle.of(context).loadString('assets/sparePartsList.json');
    List<dynamic> raw = jsonDecode(jsonString);
    return raw.map((f) => JSONPartsList.fromJSON(f)).toList();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        drawer: Drawer(),
        appBar: new AppBar(
          title: new Text('SPM - Spare Parts Market'),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                ),
                onPressed: (){Navigator.pushNamed(context, '/cart');})
          ],
      ),
        body: new Container(
          child: FutureBuilder(
              future: getPartsListFromJSON(context),
              builder: (context, data){
                if(data.hasData){

                  List<JSONPartsList> decodedPartsList = data.data;

                  return new ListView.builder(
                              itemCount: decodedPartsList.length,
                              itemBuilder: (BuildContext context,int index) {
                    return GestureDetector(
                      onTap:() =>  Navigator.push(context,MaterialPageRoute(builder: (context)=> DescriptionScreen(dataFromJSON: decodedPartsList[index],))),
                      child: Card(
                            child: new Row(
                                children: [
                                  FittedBox(
                                    fit: BoxFit.cover,
                                    child: Image.network(decodedPartsList[index].imageURL,
                                      width: 80, height: 80,),
                                  ),
                                  Container(
                                      child: Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                Text(decodedPartsList[index].title,
                                                  style: Theme.of(context).textTheme.headline5,
                                                  overflow: TextOverflow.fade,
                                                  textAlign: TextAlign.left,
                                                ),
                                                Divider(),
                                                Row(
                                                  children: [
                                                    Text('${decodedPartsList[index].price} руб.',
                                                      textAlign: TextAlign.end,
                                                      style: Theme.of(context).textTheme.bodyText1,),
                                                    IconButton(icon: Icon(Icons.add_shopping_cart), onPressed: (){
                                                       ListOfProducts.shared.productAdd(decodedPartsList[index], index);
                                                    }),
                                                    ],
                                                ),
                                              ],),))
                                  )
                                ]
                            ),
                          ),
                    );
                  });

                }else{
                  return Center(child: CircularProgressIndicator(),);
                }
              }

          ),
        )
    );
  }
}
          
          
          
          //=======================================================================================================
          
          
          
          
          
          
        //   child: FutureBuilder(
        //     future: ,
        //     builder: (context,snapshot){
        //
        //     if (snapshot.connectionState == ConnectionState.done)
        //
        //     {var myData = json.decode(snapshot.data.toString());
        //       return new ListView.builder(
        //         itemCount: myData == null ?  0 : myData["parts"].length,
        //         itemBuilder: (BuildContext context,int index) {
        //           return GestureDetector(
        //               onTap:() =>  Navigator.push(context,MaterialPageRoute(builder: (context)=> DescriptionScreen(dataFromHomepage: myData['parts'][index],))),
        //               child: new Card(
        //                   child: new Row(
        //                     children: [
        //                       FittedBox(
        //                         fit: BoxFit.cover,
        //                         child: Image.network(myData["parts"][index]["imageURL"], width: 80, height: 80,) ,
        //                       ),
        //                       Container(
        //                         child: Expanded(
        //                           child: Padding(padding: EdgeInsets.all(10.0),
        //                             child: Column(
        //                              crossAxisAlignment: CrossAxisAlignment.stretch,
        //                              children: [
        //                               Text(myData["parts"][index]["title"],
        //                                     style: Theme.of(context).textTheme.headline5,
        //                                     overflow: TextOverflow.fade,
        //                                     textAlign: TextAlign.left,
        //                               ),
        //                               Divider(),
        //                               Text('${myData["parts"][index]["price"]} руб.',
        //                                     textAlign: TextAlign.end,
        //                                     style: Theme.of(context).textTheme.bodyText1,
        //                             ),
        //                           ],),))
        //                       )
        //                     ]
        //                 ),
        //               )
        //           );
        //           // showDialog(
        //         },
        //       );} else {
        //       return Center(
        //           child: CircularProgressIndicator());
        //     }
        // },
        //   future: DefaultAssetBundle.of(context).loadString('assets/sparePartsList.json'),
        //
        //   ),
//       )
//     );
//   }
// }
//

