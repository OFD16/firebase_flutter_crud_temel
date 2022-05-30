import 'package:flutter/material.dart';
import 'CreatePage.dart';
import 'ReadPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('CRUD FUNCTIONS'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePage()),), child: Text('Veri oluştur')),
              ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ReadPage()),), child: Text('Veri yazdır/düzenle/sil')),
            ],
          ),
        ),
      );

  }
}