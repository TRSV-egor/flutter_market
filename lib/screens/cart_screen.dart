import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//my imports
import 'package:flutter_market/components/cart_position.dart';

class CartScreen extends StatefulWidget {

  @override
  CartScreenState createState() => CartScreenState();

}

class CartScreenState extends State<CartScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Корзина"),
      ),
      body: ListView.builder(
          itemCount: ListOfProducts.shared.addedProductsList.length,
          itemBuilder: (context, index){
            return new Card(
              child: ListTile(
                title: Text(ListOfProducts.shared.addedProductsList[index].title),
                subtitle: Text("Цена : ${ListOfProducts.shared.addedProductsList[index].price}",),
                leading: Image.network(ListOfProducts.shared.addedProductsList[index].imageURL),
                trailing: Container(
                  child: Wrap(
                      children: [
                        IconButton(
                            icon: Icon(Icons.arrow_drop_up),
                            onPressed: (){
                              setState(() {
                                ListOfProducts.shared.productAdd(ListOfProducts.shared.addedProductsList[index], index);
                              });
                            }),
                        Text("${ListOfProducts.shared.addedProductsList[index].balance}"),
                        IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: (){
                          setState(() {
                            ListOfProducts.shared.productRemove(ListOfProducts.shared.addedProductsList[index]);
                          });
                        }),
                      ]),
                ),
              ),
            );
          }),
      bottomNavigationBar: Container(
        color: Colors.indigo,
        child: Row(
          children: [
            Expanded(
                child: ListTile(
                  title: Text("Всего: ${ListOfProducts.shared.addedProductsList.length}"),
                  //subtitle: Text("${ListOfProducts(context).totalPriceValue} руб."),
                ),),
            Expanded(
                child: MaterialButton(
                    color: Colors.indigoAccent,
                    child: Icon(Icons.remove_shopping_cart),
                    onPressed: (){
                      setState(() {
                        ListOfProducts.shared.productClearCart();
                    });
                    }
                ),
                ),

            Expanded(
              child: MaterialButton(onPressed: (){
                print(ListOfProducts.shared.addedProductsList.isEmpty);
              },
                child: Icon(Icons.account_balance_wallet_rounded),
                color: Colors.indigoAccent,),
          )
          ],
        ),
      ),
    );
  }

}