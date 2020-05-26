import 'package:flutter/material.dart';
import 'package:reddrop/DonarProfile.dart';
import 'package:reddrop/user.dart';

class UserTile extends StatelessWidget {
  final User user;
  UserTile({this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, 'donarProfile', arguments: {
            'email': user.userEmail,
            'name': user.name,
            'phone': user.phone,
            'city': user.city,
            'bloodGroup': user.bloodGroup,
            'picUrl': user.picUrl,
            'status': user.status,
          });
        },
        leading: CircleAvatar(
            backgroundColor: Colors.red,
            backgroundImage: NetworkImage(user.picUrl)),
        title: Text(
          user.name,
        ),
        subtitle: Text(
          user.status ? 'Available' : 'Not Available',
          style: TextStyle(color: user.status ? Colors.green : Colors.red),
        ),
        trailing: Text(
          user.bloodGroup,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
