import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: DagitimEkrani()));

class DagitimEkrani extends StatefulWidget {
  @override
  _DagitimEkraniState createState() => _DagitimEkraniState();
}

class _DagitimEkraniState extends State<DagitimEkrani> {
  final yogurtController = TextEditingController();
  final ayranController = TextEditingController();
  final musteriController = TextEditingController();
  double toplam = 0;

  // BURAYI DOLDUR!
  String botToken = "8230534695:AAFMmMTWRnlRLzCKnaDLdSatPa694OXkOx0";
  String chatId = "1868853930";

  void hesapla() {
    setState(() {
      toplam = (double.tryParse(yogurtController.text) ?? 0) * 50 +
               (double.tryParse(ayranController.text) ?? 0) * 20;
    });
  }

  Future<void> gonder() async {
    String mesaj = "📍 Müşteri: ${musteriController.text}\n🥛 Yoğurt: ${yogurtController.text}\n🥤 Ayran: ${ayranController.text}\n💰 Toplam: $toplam TL";
    var url = Uri.parse("https://api.telegram.org/bot$botToken/sendMessage?chat_id=$chatId&text=$mesaj");
    await http.get(url);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Telegram'a Gönderildi!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dağıtım Takip")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: musteriController, decoration: InputDecoration(labelText: "Müşteri Adı")),
            TextField(controller: yogurtController, decoration: InputDecoration(labelText: "Yoğurt Adet"), keyboardType: TextInputType.number, onChanged: (v) => hesapla()),
            TextField(controller: ayranController, decoration: InputDecoration(labelText: "Ayran Adet"), keyboardType: TextInputType.number, onChanged: (v) => hesapla()),
            SizedBox(height: 20),
            Text("Toplam Tutar: $toplam TL", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ElevatedButton(onPressed: gonder, child: Text("Kaydet ve Telegram'a At"))
          ],
        ),
      ),
    );
  }
}
