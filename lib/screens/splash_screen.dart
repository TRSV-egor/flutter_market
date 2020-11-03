import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
//my imports
import 'settings_screen.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';
import 'cart_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      //Отключение надписи дэбаг
      debugShowCheckedModeBanner: false,

      //Настройка темы
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        buttonColor: Colors.indigoAccent,
        buttonTheme: const ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
      ),

      //Инициализация стартового пути
      initialRoute: '/splash',

      //Инициализация путей других экранов
      routes: {
        '/splash':(BuildContext context) => WelcomeScreen(),
        '/home':(BuildContext context) => HomeScreen(),
        // '/description':(BuildContext context) => DescriptionScreen(),
        '/cart':(BuildContext context) => CartScreen(),
        '/favorite':(BuildContext context) => FavoriteScreen(),
        '/settings':(BuildContext context) => SettingsScreen(),

      },
    );
  }
}

//Экран приветствия
class WelcomeScreen extends StatefulWidget {
  @override
  WelcomeScreenState createState() => new WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    //Всплывающий экран и ео настройки
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new HomeScreen(),
      title: new Text('Buy parts smarter',
        style: Theme.of(context).textTheme.headline5,),
      image: new Image.asset('assets/images/SPM-500.jpg', height: 500, width: 500,),
      loadingText: Text("Just a sec..."),
      photoSize: 100.0,
      loaderColor: Colors.indigoAccent,
      );
    }
}