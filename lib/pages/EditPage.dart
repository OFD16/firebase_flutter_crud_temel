import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_temel/pages/ReadPage.dart';

class EditPage extends StatelessWidget {
  final String name;
  final String age;
  final String id;

  EditPage({Key? key, required this.name, required this.age, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controllerName = TextEditingController();
    final TextEditingController controllerAge = TextEditingController();

    controllerName.text = name;
    controllerAge.text = age;

    return Scaffold(
      appBar: AppBar(title: Text('Edit Sayfası')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: controllerName,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controllerAge,
            decoration: const InputDecoration(labelText: 'Age'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
              onPressed: () {
                CollectionReference users = FirebaseFirestore.instance.collection('users');
                 users
                    .doc(this.id)
                    .update({'name': controllerName.text, 'age': controllerAge.text})
                    .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => ReadPage())))
                    .catchError((error) => print("Failed to update user: $error"));
              },
              child: const Text('Düzenle')),
        ],
      ),
    );
  }
}
