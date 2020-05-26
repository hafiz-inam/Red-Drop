import 'package:flutter/material.dart';
import 'package:reddrop/DonarProfile.dart';
import 'package:reddrop/authService.dart';
import 'package:reddrop/splashScreen.dart';
import 'package:reddrop/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:reddrop/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.red,
          accentColor: Colors.red,
          cursorColor: Colors.red,
          textSelectionHandleColor: Colors.red,
          textSelectionColor: Colors.grey,
        ),
        home: SplashScreen(),
        routes: {
          'donarProfile': (context) => DonarProfile(),
        },
      ),
    );
  }
}
