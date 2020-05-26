import 'package:flutter/material.dart';
import 'package:reddrop/authService.dart';
import 'package:reddrop/loading.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService _auth = AuthService();
  final _key = GlobalKey<FormState>();
  String email;
  String password;
  bool loading = false;
  String error = '';

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.red[900]);

    return loading
        ? Loading()
        : Stack(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 130,
                          width: 100,
                          child: Image(
                            image: AssetImage('assets/drops_red.png'),
                          )),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Form(
                          key: _key,
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    prefixIcon: Icon(Icons.person),
                                    hintText: 'Email',
                                  ),
                                  onChanged: (val) =>
                                      setState(() => email = val),
                                  validator: (val) => val.contains('@')
                                      ? null
                                      : 'enter a valid email',
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    prefixIcon: Icon(Icons.lock),
                                  ),
                                  onChanged: (val) =>
                                      setState(() => password = val),
                                  validator: (val) => val.length < 6
                                      ? 'enter a 6+ character password'
                                      : null,
                                ),
                                SizedBox(
                                  height: 50.0,
                                ),
                                RaisedButton(
                                  color: Colors.red,
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    if (_key.currentState.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      dynamic result =
                                          await _auth.signinUsingEmailAndPass(
                                              email, password);
                                      if (result == null) {
                                        setState(() {
                                          error = 'Error Occured, try again';
                                          loading = false;
                                        });
                                      }
                                      setState(() {
                                        loading = false;
                                      });
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                RaisedButton(
                                  color: Colors.red,
                                  child: Text(
                                    'Register',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    if (_key.currentState.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      dynamic result =
                                          await _auth.registerUsingEmailAndPass(
                                              email, password);
                                      if (result == null) {
                                        setState(() {
                                          error = 'Error Occured, try again';
                                          loading = false;
                                        });
                                      }
                                      setState(() {
                                        loading = false;
                                      });
                                    }
                                  },
                                ),
                                SizedBox(height: 20.0),
                                Text(
                                  error,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]);
  }
}
