import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reddrop/authService.dart';
import 'package:reddrop/databaseService.dart';
import 'package:reddrop/home.dart';
import 'package:reddrop/loading.dart';
import 'package:reddrop/user.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  List<String> bloodGroups = [
    '',
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];
  List<String> cities = ['', 'Islamabad', 'Lahore', 'Faisalabad', 'Gujranwala'];

  String uid = AuthService().uid;
  File _profilePic;
  String _profilePicUrl;
  String _currentName;
  String _currentPhone;
  String _currentBloodGroup;
  String _currentCity;
  bool _currentStatus = false;
  bool updating = false;

  imagePicker() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print(image);
    setState(() {
      _profilePic = (image);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    String userEmail = user.userEmail;

    return StreamBuilder<User>(
        stream: DatabaseService(uid: user.uid).currentUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User userData = snapshot.data;

            uploadProfilePic(File image) async {
              try {
                StorageReference firebaseStorageRef =
                    FirebaseStorage.instance.ref().child('$userEmail/pic');
                await firebaseStorageRef.putFile(image).onComplete;
                var url = await firebaseStorageRef.getDownloadURL();
                print(url.toString());
                _profilePicUrl = url.toString();
              } catch (e) {
                print(e.toString());
              }
            }

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.red,
                title: Text('Profile'),
                centerTitle: true,
              ),
              body: Container(
                padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 50.0,
                            backgroundColor: Colors.white,
                            backgroundImage: _profilePic != null
                                ? FileImage(_profilePic)
                                : NetworkImage(userData.picUrl),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: IconButton(
                              icon: Icon(
                                Icons.edit,
                                size: 20,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                imagePicker();
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        initialValue: userData.name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          labelText: 'Name',
                        ),
                        validator: (val) => val.isEmpty ? 'enter name' : null,
                        onChanged: (val) =>
                            setState(() => _currentName = val ?? userData.name),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        initialValue: userData.phone,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            labelText: 'Phone',
                            hintText: '03XXXXXXXXX'),
                        validator: (val) => val.isEmpty
                            ? 'enter phone with format 03XXXXXXXXX'
                            : null,
                        onChanged: (val) => setState(
                            () => _currentPhone = val ?? userData.phone),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                              value: userData.bloodGroup,
                              items: bloodGroups.map((bloodGroup) {
                                return DropdownMenuItem(
                                  value: bloodGroup,
                                  child: Text(bloodGroup),
                                );
                              }).toList(),
                              onChanged: (val) => setState(() =>
                                  _currentBloodGroup =
                                      val ?? userData.bloodGroup),
                              validator: (val) =>
                                  val.isEmpty ? 'select blood group' : null,
                              hint: Text(userData.bloodGroup),
                            ),
                          ),
                          SizedBox(width: 20),
                          Flexible(
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                              value: userData.city,
                              items: cities.map((cityName) {
                                return DropdownMenuItem(
                                  child: Text(cityName),
                                  value: cityName,
                                );
                              }).toList(),
                              onChanged: (val) => setState(
                                  () => _currentCity = val ?? userData.city),
                              validator: (val) =>
                                  val.isEmpty ? 'select yout city' : null,
                              hint: Text(userData.city),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Ready to Donate',
                          ),
                          Switch(
                              value: userData.status,
                              activeColor: Colors.red,
                              onChanged: (val) =>
                                  setState(() => _currentStatus = val)),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      updating
                          ? SpinKitRing(
                              color: Colors.red,
                              size: 40.0,
                            )
                          : RaisedButton(
                              color: Colors.red,
                              child: Text(
                                'Update',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    updating = true;
                                  });

                                  await uploadProfilePic(_profilePic);

                                  await DatabaseService(uid: user.uid)
                                      .updateUserData(
                                    _currentName ?? userData.name,
                                    _currentPhone ?? userData.phone,
                                    _currentCity ?? userData.city,
                                    _currentBloodGroup ?? userData.bloodGroup,
                                    _profilePicUrl ?? userData.picUrl,
                                    _currentStatus ?? userData.status,
                                  );

                                  setState(() {
                                    updating = false;
                                  });

                                  Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()));
                                }
                              },
                            )
                    ]),
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
