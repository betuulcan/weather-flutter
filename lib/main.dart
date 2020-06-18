import 'package:flutter/material.dart';
import 'package:havadurumu/HavaBaglanti.dart';
import 'HavaBaglanti.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hava Durumu Api',
      home: HavaDurumuApi(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HavaDurumuApi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text("Hava Durumu API"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                elevation: 10,
                child: Text(
                  "Hava Durumunu Öğren",
                  style: TextStyle(fontSize: 16),
                ),
                textColor: Colors.white,
                color: Colors.orange,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RemoteApi()));
                },
              )
            ],
          ),
        ));
  }
}
