import 'package:flutter/material.dart';
//IMPORT PACKAGE UNTUK HTTP REQUEST DAN ASYNCHRONOUS
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
  //DEFINE VARIABLE url UNTUK MENAMPUNG END POINT
  final String url =
      'http://www.malmalioboro.co.id/index.php/api/produk/get_list';
  List
      data; //DEFINE VARIABLE data DENGAN TYPE List AGAR DAPAT MENAMPUNG COLLECTION / ARRAY

  @override
  void initState() {
    super.initState();
    this.getData(); //PANGGIL FUNGSI YANG TELAH DIBUAT SEBELUMNYA
  }

  Future<String> getData() async {
    // MEMINTA DATA KE SERVER DENGAN KETENTUAN YANG DI ACCEPT ADALAH JSON
    Map detail = {'idtenan': '136'};

    String body = json.encode(detail);

    http.Response response = await http.post(Uri.encodeFull(url), body: detail);

    setState(() {
      //RESPONSE YANG DIDAPATKAN DARI API TERSEBUT DI DECODE
      var content = json.decode(response.body);
      //KEMUDIAN DATANYA DISIMPAN KE DALAM VARIABLE data,
      //DIMANA SECARA SPESIFIK YANG INGIN KITA AMBIL ADALAH ISI DARI KEY hasil
      data = content;
      print(response.body);
    });
    return 'success!';
  }

  Widget build(context) {
    return MaterialApp(
      title: 'Supermarket Malioboro Mall',
      home: Scaffold(
          appBar: AppBar(title: Text('Supermarket')),
          body: Container(
            margin: EdgeInsets.all(10.0), //SET MARGIN DARI CONTAINER
            child: ListView.builder(
              //MEMBUAT LISTVIEW
              itemCount: data == null
                  ? 0
                  : data
                      .length, //KETIKA DATANYA KOSONG KITA ISI DENGAN 0 DAN APABILA ADA MAKA KITA COUNT JUMLAH DATA YANG ADA
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      //ListTile MENGELOMPOKKAN WIDGET MENJADI BEBERAPA BAGIAN
                      ListTile(
                        //leading TAMPIL PADA SEBELAH KIRI
                        // DIMANA VALUE DARI leading ADALAH WIDGET TEXT
                        // YANG BERISI NOMOR ITEM
                        leading: Text(
                          data[index]['nomor'],
                          style: TextStyle(fontSize: 20.0),
                        ),
                        //title TAMPIL DITENGAH SETELAH leading
                        // VALUENYA ADALAH WIDGET TEXT
                        // YANG BERISI NAMA SURAH
                        title: Text(
                          data[index]['nama'],
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                        //trailing TAMPIL PADA SEBELAH KANAN SETELAH title
                        //VALUE NYA ADALAH IMAGE
                        trailing: Image.network(
                          data[index]['gambar'],
                          width: 32.0,
                          height: 32.0,
                        ),
                        //subtitle TAMPIL TEPAT DIBAWAH title
                        subtitle: Column(
                          children: <Widget>[
                            //MENGGUNAKAN COLUMN
                            //DIMANA MASING-MASING COLUMN TERDAPAT ROW
                            Row(
                              children: <Widget>[
                                //MENAMPILKAN TEXT BARCODE
                                Text(
                                  'Barcode : ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                //MENAMPILKAN VALUE BARCODE
                                Text(
                                  data[index]['barcode'],
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15.0),
                                ),
                              ],
                            ),
                            //ROW SELANJUTNYA MENAMPILKAN HARGA ITEM
                            Row(
                              children: <Widget>[
                                Text(
                                  'Harga : ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(data[index]['harga'])
                              ],
                            ),
                          ],
                        ),
                      ),
                      //BUTTON
                      ButtonTheme(
                        child: ButtonBar(
                          children: <Widget>[
                            // BUTTON 1
                            FlatButton(
                              //DENGAN TEXT DETAIL ITEM
                              child: const Text('DETAIL ITEM'),
                              onPressed: () {/* ... */},
                            ),
                            //BUTTON 2
                            FlatButton(
                              //DENGAN TEXT BELI
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
