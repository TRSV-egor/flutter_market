import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'home_screen.dart';
import 'description_screen.dart';
import 'cart_screen.dart';


class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        buttonColor: Colors.indigoAccent,
        buttonTheme: const ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      initialRoute: '/splash',
      routes: {
        '/splash':(BuildContext context) => WelcomeScreen(),
        '/home':(BuildContext context) => HomeScreen(),
        '/description':(BuildContext context) => DescriptionScreen(),
        '/cart':(BuildContext context) => CartScreen(),

      },
    );
  }
}


class WelcomeScreen extends StatefulWidget {
  @override
  WelcomeScreenState createState() => new WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 1,
      navigateAfterSeconds: new HomeScreen(),
      title: new Text('Buy parts smarter',
        style: Theme.of(context).textTheme.headline5,),
      image: new Image.asset('assets/images/SPM-500.jpg', height: 150, width: 150,),
      loadingText: Text("Just a sec..."),
      photoSize: 100.0,
      loaderColor: Colors.indigoAccent,
      );
    }
}