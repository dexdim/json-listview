import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  
  /*List data;

  Future<String> getData() async {
    http.Response response = await http.post(
        Uri.encodeFull(
            "http://www.malmalioboro.co.id/index.php/api/produk/get_list"),
        headers: {"Accept": "application/json"});
    setState(() {
      data = json.decode(response.body);
    });
    return "Success!";
  }
  */

Future<http.Response> createAlbum(String title, String ) {
  return http.post(
    'https://jsonplaceholder.typicode.com/albums',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'idtenan': idtenan,
    }),
  );
}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Data from API 2"),
        backgroundColor: Colors.blueAccent,
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new Text(data[index]["idtenan"]),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    this.getData();
  }
}
