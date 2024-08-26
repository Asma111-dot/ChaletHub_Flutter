import 'package:chalet_2/main_layout.dart';
import 'package:chalet_2/resources/config.dart';
import 'package:chalet_2/screens/auth_screen.dart';
import 'package:chalet_2/screens/booking_screen.dart';
import 'package:chalet_2/screens/chalet_details_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //  navigatorKey
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Chalet App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //pre-define input decoration
        inputDecorationTheme: const InputDecorationTheme(
          focusColor: Config.primaryColor,
          border: Config.outlinedBorder,
          focusedBorder: Config.focusBorder,
          errorBorder: Config.errorBorder,
          enabledBorder: Config.outlinedBorder,
          floatingLabelStyle: TextStyle(color: Config.primaryColor),
          prefixIconColor: Colors.black38,
        ),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Config.primaryColor,
          selectedItemColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey.shade700,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthPage(),
        'main': (context) => const MainLayout(),
        'chalet_details': (context) => ChaletDetails(
              addToFavorites: (String chaletName) {
                print('$chaletName added to favorites');
              },
              chaletDetails: {
                'name': 'Qatar Al Nada Chalet',
                'price': 60000,
                'capacity': 25,
                'deposit': 20000,
                'location': 'Sarf ',
              },
            ),
        'booking_page': (context) => CalendarScreen(),
      },
    );
  }
}
