import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reddrop/home.dart';
import 'package:reddrop/signin.dart';
import 'package:reddrop/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return user != null ? Home() : SignIn();
  }
}
