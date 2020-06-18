import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'models/HavaDurumu.dart';

class RemoteApi extends StatefulWidget {
  @override
  _RemoteApiState createState() => _RemoteApiState();
}

class _RemoteApiState extends State<RemoteApi> {
  Future<List<HavaDurumu>> _gonderiGetir() async {
    var response = await http.get(
        "http://api.weatherstack.com/current?access_key=336f6652cc8937665535a87818638585&query=istanbul");

    var response1 = await http.get(
        "http://api.weatherstack.com/current?access_key=336f6652cc8937665535a87818638585&query=duzce");

    var response2 = await http.get(
        "http://api.weatherstack.com/current?access_key=336f6652cc8937665535a87818638585&query=van");

    var response3 = await http.get(
        "http://api.weatherstack.com/current?access_key=336f6652cc8937665535a87818638585&query=london");

    var params = {"language": "tr"};
    var response4 = await http.post(
        "http://api.weatherstack.com/current?access_key=336f6652cc8937665535a87818638585&query=prague",
        body: json.encode(params));

    var response5 = await http.get(
        "http://api.weatherstack.com/current?access_key=336f6652cc8937665535a87818638585&query=tokyo");

    if (response.statusCode == 200 ||
        response1.statusCode == 200 ||
        response2.statusCode == 200 ||
        response3.statusCode == 200 ||
        response4.statusCode == 200 ||
        response5.statusCode == 200) {
      //sadece body kısmını getirdik ki diğer bilgileri vermesin.
      //return Gonderi.fromJson(json.decode(response.body));
      var toplam = "[" +
          response.body +
          "," +
          response1.body +
          "," +
          response2.body +
          "," +
          response3.body +
          "," +
          response4.body +
          "," +
          response5.body +
          "]";
      return (json.decode(toplam) as List)
          .map((tekGonderiMap) => HavaDurumu.fromJson(tekGonderiMap))
          .toList();
    } else {
      throw Exception("Bağlanılamadı ${response.statusCode}");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Günlük Hava Durumu"),
      ),
      //snapshot o an çekilmiş değer.
      body: FutureBuilder(
          future: _gonderiGetir(),
          builder:
              (BuildContext context, AsyncSnapshot<List<HavaDurumu>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (ctx) {
                            return AlertDialog(
                              // semanticLabel: Text("rgfgfd"),
                              title: Text(
                                snapshot.data[index].location.name,
                                textAlign: TextAlign.center,
                              ),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Image.network(
                                      snapshot.data[index].current.weatherIcons
                                          .first,
                                      width: 100,
                                      height: 100,
                                    ),
                                    Text("\nÖlçülen: " +
                                        snapshot.data[index].current.temperature
                                            .toString() +
                                        " °C " +
                                        snapshot.data[index].current
                                            .weatherDescriptions.first +
                                        ",\nHissedilen: " +
                                        snapshot.data[index].current.feelslike
                                            .toString() +
                                        " °C\n" +
                                        "Nem: %" +
                                        snapshot.data[index].current.humidity
                                            .toString() +
                                        "\nRüzgar Hızı: " +
                                        snapshot.data[index].current.windSpeed
                                            .toString() +
                                        " km/sa" +
                                        "\nRüzgar Yönü: " +
                                        snapshot.data[index].current.windDir),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("Tamam"),
                                  color: Colors.orange,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    isThreeLine: true,
                    title: Text(snapshot.data[index].location.name),
                    subtitle: Text(snapshot.data[index].current.temperature
                            .toString() +
                        " °C " +
                        snapshot.data[index].current.weatherDescriptions.first),
                    leading: CircleAvatar(
                      radius: 25,
                      child: Image.network(
                          snapshot.data[index].current.weatherIcons.first),
                    ),
                  );
                },
                itemCount: snapshot.data.length,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

// List<String> sehirler = [
//   "adana",
//   "adiyaman",
//   "afyonkarahisar",
//   "agri",
//   "aksaray",
//   "amasya",
//   "ankara",
//   "antalya",
//   "ardahan",
//   "artvin",
//   "aydin",
//   "balikesir",
//   "bartin",
//   "batman",
//   "bayburt",
//   "bilecik",
//   "bingol",
//   "bitlis",
//   "bolu",
//   "burdur",
//   "bursa",
//   "canakkale",
//   "cankiri",
//   "corum",
//   "denizli",
//   "diyarbakir",
//   "duzce",
//   "edirne",
//   "elazig",
//   "erzincan",
//   "erzurum",
//   "eskisehir",
//   "gaziantep",
//   "giresun",
//   "gumushane",
//   "hakkari",
//   "hatay",
//   "igdir",
//   "isparta",
//   "istanbul",
//   "izmir",
//   "kahramanmaras",
//   "karabük",
//   "karaman",
//   "kars",
//   "kastamonu",
//   "kayseri",
//   "kilis",
//   "kirikkale",
//   "kirklareli",
//   "kirsehir",
//   "kocaeli",
//   "konya",
//   "kutahya",
//   "malatya",
//   "manisa",
//   "mardin",
//   "mersin",
//   "mugla",
//   "mus",
//   "nevsehir",
//   "nigde",
//   "ordu",
//   "osmaniye",
//   "rize",
//   "sakarya",
//   "samsun",
//   "sanliurfa",
//   "siirt",
//   "sinop",
//   "sivas",
//   "sirnak",
//   "tekirdag",
//   "tokat",
//   "trabzon",
//   "tunceli",
//   "usak",
//   "van",
//   "yalova",
//   "yozgat",
//   "zonguldak"
// ];
