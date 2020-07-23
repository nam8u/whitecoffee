import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map data;
  List userData;

  Future getData() async {
    http.Response response =
        await http.get("https://reqres.in/api/users?page=2");
    data = json.decode(response.body);
    setState(() {
      userData = data["data"];
    });
    debugPrint(userData.toString());
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('White Coffee'),
          backgroundColor: Colors.teal,
        ),
        body: ListView.builder(
          itemCount: userData == null ? 0 : userData.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(userData[index]["avatar"]),
                      radius: 35.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "${userData[index]["first_name"]} ${userData[index]["last_name"]}",
                      style: TextStyle(fontSize: 20.0),),


                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
