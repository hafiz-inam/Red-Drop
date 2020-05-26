import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DonarProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    String sms = 'sms: ' + data['phone'];
    String call = 'tel: ' + data['phone'];

    launchUrlSMS() async {
      if (await canLaunch(sms))
        launch(sms);
      else
        print('could not luanch url');
    }

    launchUrlCall() async {
      if (await canLaunch(call))
        launch(call);
      else
        print('could not luanch url');
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.red),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(color: Colors.red),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 50.0,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(data['picUrl']),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 50),
//                            child: IconButton(
//                              icon: Icon(
//                                Icons.edit,
//                                size: 20,
//                                color: Colors.grey,
//                              ),
//                              onPressed: (){
//
//                              },
//                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        data['name'],
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            letterSpacing: 1.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  'Blood Group:',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  data['bloodGroup'],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Location:',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  data['city'],
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  'Phone:',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  data['phone'],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Status',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  data['status']
                                      ? 'Available'
                                      : 'Not Available',
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 60.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton.icon(
                                color: Colors.red,
                                onPressed: () {
                                  launchUrlCall();
                                },
                                icon: Icon(
                                  Icons.call,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'Call',
                                  style: TextStyle(color: Colors.white),
                                )),
                            RaisedButton.icon(
                                color: Colors.red,
                                onPressed: () {
                                  launchUrlSMS();
                                },
                                icon: Icon(
                                  Icons.message,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'SMS',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
