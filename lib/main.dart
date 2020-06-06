import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(Supermarket());
}

class Supermarket extends StatefulWidget {
  SupermarketState createState() => SupermarketState();
}

class SupermarketState extends State<Supermarket> {
  final String url =
      'http://www.malmalioboro.co.id/index.php/api/produk/get_list';
  List data;

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Future<String> getData() async {
    Map body = {'idtenan': '136'};

    http.Response response = await http.post(Uri.encodeFull(url), body: body);

    setState(() {
      var parse = json.decode(response.body);

      data = parse;
    });
    return 'success!';
  }

  Widget build(context) {
    return MaterialApp(
      title: 'Supermarket Malioboro Mall',
      home: Scaffold(
          appBar: AppBar(title: Text('Supermarket Malioboro Mall')),
          body: Container(
            margin: EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                var nama = data[index]['nama'];
                var deskripsi = data[index]['deskripsi'];
                var gambar = data[index]['gambar'];
                var harga = data[index]['harga'];

                return Container(
                    child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: ConstrainedBox(
                            constraints:
                                BoxConstraints(minWidth: 100, minHeight: 100),
                            child: Image.network(
                              'http://www.malmalioboro.co.id/$gambar',
                              width: 100,
                              height: 100,
                            )),
                        title: Text(
                          nama,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'Barcode : ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  deskripsi,
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Harga : ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  harga,
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      ButtonTheme(
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('DETAIL ITEM'),
                              onPressed: () {/* ... */},
                            ),
                            FlatButton(
                              child: const Text('BELI'),
                              onPressed: () {/* ... */},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
              },
            ),
          )),
    );
  }
}
